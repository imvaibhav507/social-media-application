import { AsyncHandler } from "../utils/AsyncHandler.js";
import { ApiError } from "../utils/ApiError.js";
import { ApiResponse } from "../utils/ApiResponse.js";
import { ChatParticipant } from "../models/chat.participant.model.js";
import { ChatRoom } from "../models/chatroom.model.js";
import { Message } from "../models/message.model.js";

const createGroupChat = AsyncHandler(async (req, res) => {
  const { name, participants } = req.body;
  console.log(name);
  if (name.trim() === "") {
    throw new ApiError("400", "Group name is required");
  }

  if (participants.length < 1) {
    throw new ApiError(400, "Group must have atleast two participants!!");
  }

  const allParticipants = [...participants, req.user._id];

  const chatRoom = await ChatRoom.create({
    name,
    isGroupChat: true,
    creator: req.user._id,
  });

  const createdChatRoom = await ChatRoom.findById(chatRoom._id);
  if (!createdChatRoom) {
    throw new ApiError(500, "Something went wrong while creating chatroom");
  }

  const participantPromises = allParticipants.map(async (v) => {
    await ChatParticipant.create({
      chatee: v,
      chatRoom: chatRoom._id,
    });
  });

  await Promise.all(participantPromises);

  res
    .status(200)
    .json(new ApiResponse(200, chatRoom, "Chatroom created successfully"));
});

const getChatRooms = AsyncHandler(async (req, res) => {
  const userId = req.user._id;
  if (!userId) {
    throw new ApiError(400, "No user found");
  }
  const chatrooms = await ChatParticipant.aggregate([
    [
      {
        $match: {
          chatee: userId,
        },
      },
      {
        $lookup: {
          from: "chatrooms",
          localField: "chatRoom",
          foreignField: "_id",
          as: "chatRoomDetails",
        },
      },
      { $unwind: "$chatRoomDetails" },
      {
        $lookup: {
          from: "chatparticipants",
          localField: "chatRoomDetails._id",
          foreignField: "chatRoom",
          as: "participants",
        },
      },
      {
        $project: {
          _id: "$chatRoomDetails._id",
          name: "$chatRoomDetails.name",
          avatar: "$chatRoomDetails.avatar",
          isGroupChat: "$chatRoomDetails.isGroupChat",
          creator: "$chatRoomDetails.creator",
          participants: "$participants.chatee",
        },
      },
    ],
  ]);

  return res
    .status(200)
    .json(new ApiResponse(200, chatrooms, "chatrooms fetched successfully !!"));
});

const addParticipants = AsyncHandler(async (req, res) => {
  const { chatroomId, participants } = req.body;
  console.log(req.body);

  const existingChatroom = await ChatRoom.findById(chatroomId);
  if (!existingChatroom) {
    throw new ApiError(400, "Chatroom does not exist");
  }

  const existingParticipants = await ChatParticipant.find({
    chatRoom: chatroomId,
    chatee: { $in: participants },
  });

  if (existingParticipants.length > 0) {
    throw new ApiError(409, "Some participants already exist");
  }

  const participantPromises = participants.map(async (participant) => {
    await ChatParticipant.create({
      chatee: participant,
      chatRoom: chatroomId,
    });
  });

  await Promise.all(participantPromises);

  res.status(200).json(
    new ApiResponse(
      200,
      // participantPromises,
      `Participants added successfully to chatroom: ${chatroomId}`
    )
  );
});

const sendMessages = AsyncHandler(async (req, res) => {
  const { chatroomId, message } = req.body;

  const existingParticipants = await ChatParticipant.findOne({
    chatee: req.user._id,
    chatRoom: chatroomId,
  });

  if (!existingParticipants) {
    throw new ApiError(400, "Sender does not belong to the chatroom");
  }

  const attachments = req.files || [];

  if (
    (!message || message === "") &&
    (!attachments || attachments.length === 0)
  ) {
    throw new ApiError(400, "Nothing to send");
  }

  const messageForRealTime = {};

  const messageForDB = {
    content: message,
    attachments,
    sender: req.user._id,
    chatRoom: chatroomId,
  };

  const sentMessage = await Message.create(messageForDB);

  return res
    .status(200)
    .json(new ApiResponse(200, sentMessage, "Message sent successfully"));
});

export { createGroupChat, getChatRooms, addParticipants, sendMessages };
