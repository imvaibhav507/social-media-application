import { AsyncHandler } from "../utils/AsyncHandler.js";
import { ApiError } from "../utils/ApiError.js";
import { ApiResponse } from "../utils/ApiResponse.js";
import { ChatRoom } from "../models/chatroom.model.js";
import { Message } from "../models/message.model.js";
import { mongoose } from "mongoose";
import { User } from "../models/user.model.js";
import { uploadOnCloudinary } from "../utils/Cloudinary.js";

// chatroom

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

  const avatarLocalPath = "./public/temp/user.png";
  if (!avatarLocalPath) {
    throw new ApiError(400, "Avatar is required");
  }
  console.log(avatarLocalPath);

  // upload to cloudinary
  const avatar = await uploadOnCloudinary(avatarLocalPath);
  if (!avatar) {
    throw new ApiError(400, "Avatar not found");
  }

  const chatRoom = await ChatRoom.create({
    name,
    avatar: avatar.url || "./public/temp/user.png",
    isGroupChat: true,
    creator: req.user._id,
    members: allParticipants,
  });

  const createdChatRoom = await ChatRoom.findById(chatRoom._id);
  if (!createdChatRoom) {
    throw new ApiError(500, "Something went wrong while creating chatroom");
  }
  res
    .status(200)
    .json(
      new ApiResponse(200, createdChatRoom, "Chatroom created successfully")
    );
});

const createPersonalChat = AsyncHandler(async (req, res) => {
  const { participantUserId } = req.body;

  if (!participantUserId) {
    throw new ApiError(400, "No participant user id found!!");
  }

  const participantUser = await User.findById(participantUserId);
  console.log(participantUser);

  if (!participantUser) {
    throw new ApiError(400, "No user found with thee given id");
  }

  const allParticipants = [participantUserId, req.user._id];

  const existingPersonalChatroom = await ChatRoom.findOne({
    members: allParticipants,
    isGroupChat: false,
  });

  if (existingPersonalChatroom) {
    throw new ApiError(401, "Personal chat already exists with the user");
  }

  const chatRoom = await ChatRoom.create({
    name: participantUser.fullName,
    isGroupChat: false,
    avatar: participantUser.avatar,
    members: allParticipants,
    creator: req.user._id,
  });

  const createdChatRoom = await ChatRoom.findById(chatRoom._id);
  if (!createdChatRoom) {
    throw new ApiError(500, "Something went wrong while creating chatroom");
  }

  res
    .status(200)
    .json(
      new ApiResponse(200, createdChatRoom, "Chatroom created successfully")
    );
});

const getChatRoomsList = AsyncHandler(async (req, res) => {
  const userId = req.user._id;
  if (!userId) {
    throw new ApiError(400, "No user found");
  }
  const chatrooms = await ChatRoom.aggregate([
    {
      $match: {
        members: {
          $in: [userId],
        },
      },
    },

    {
      $lookup: {
        from: "messages",
        localField: "_id",
        foreignField: "chatRoom",
        as: "fetchedMessages",
      },
    },

    {
      $addFields: {
        lastMessage: { $last: "$fetchedMessages" },
      },
    },

    {
      $sort: {
        "lastMessage.createdAt": -1,
      },
    },

    {
      $project: {
        name: 1,
        lastMessage: "$lastMessage.content",
        avatar: 1,
        time: {
          $dateToString: {
            format: "%H:%M", // Specify the format to show only time
            date: "$lastMessage.createdAt",
            timezone: "Asia/Kolkata", // Specify the timezone if needed
          },
        },
      },
    },
    {
      $sort: {
        "lastMessage.createdAt": -1,
      },
    },
  ]);

  return res
    .status(200)
    .json(new ApiResponse(200, chatrooms, "chatrooms fetched successfully !!"));
});

const getSingleChatRoom = AsyncHandler(async (req, res) => {
  const chatroomId = req.query.chatroomId;
  console.log(chatroomId);

  const chatroom = await ChatRoom.aggregate([
    {
      $match: {
        _id: new mongoose.Types.ObjectId(chatroomId),
      },
    },

    {
      $lookup: {
        from: "messages",
        localField: "_id",
        foreignField: "chatRoom",
        as: "fetchedMessages",
      },
    },

    {
      $addFields: {
        lastMessage: { $last: "$fetchedMessages" },
      },
    },

    {
      $project: {
        name: 1,
        lastMessage: "$lastMessage.content",
        avatar: 1,
        time: {
          $dateToString: {
            format: "%H:%M", // Specify the format to show only time
            date: "$lastMessage.createdAt",
            timezone: "Asia/Kolkata", // Specify the timezone if needed
          },
        },
      },
    },
  ]);

  return res
    .status(200)
    .json(
      new ApiResponse(200, chatroom[0], "chatroom fetched successfully !!")
    );
});

const getChatRoomDetails = AsyncHandler(async (req, res) => {
  const { id } = req.query;

  console.log(id);
  const chatRoom = await ChatRoom.aggregate([
    {
      $match: {
        _id: new mongoose.Types.ObjectId(id),
      },
    },
    {
      $lookup: {
        from: "users",
        localField: "members",
        foreignField: "_id",
        as: "memberDetails",
      },
    },

    {
      $unwind: "$memberDetails", // Unwind the array of member details
    },
    {
      $project: {
        name: 1,
        avatar: 1,
        "memberDetails.username": 1,
        "memberDetails.username": 1,
        "memberDetails.email": 1,
        "memberDetails.avatar": 1,
      },
    },
    {
      $group: {
        _id: "$_id",
        name: { $first: "$name" },
        avatar: { $first: "$avatar" },
        memberDetails: { $push: "$memberDetails" },
      },
    },
  ]);
  console.log(chatRoom);
  return res
    .status(200)
    .json(
      new ApiResponse(200, chatRoom[0], "Chatroom details fetched successfully")
    );
});

const searchChatRooms = AsyncHandler(async (req, res) => {
  const userId = req.user._id;
  const searchQuery = req.query.search;
  console.log(searchQuery);

  if (!userId) {
    throw new ApiError(400, "No user found");
  }

  const chatrooms = await ChatRoom.aggregate([
    {
      $match: {
        members: {
          $in: [userId],
        },
      },
    },
    {
      $lookup: {
        from: "users",
        localField: "members",
        foreignField: "_id",
        as: "participants",
      },
    },

    {
      $match: {
        name: {
          $regex: searchQuery,
          $options: "i",
        },
      },
    },

    {
      $project: {
        _id: 1,
        name: 1,
        isGroupChat: 1,
        avatar: 1,
        members: {
          $filter: {
            input: "$participants",
            as: "participant",
            cond: {
              $ne: ["$$participant._id", userId],
            },
          },
        },
      },
    },
    {
      $project: {
        _id: 1,
        name: 1,
        isGroupChat: 1,
        avatar: 1,
        "members._id": 1,
        "members.fullName": 1,
        "members.username": 1,
      },
    },
  ]);

  return res
    .status(200)
    .json(new ApiResponse(200, chatrooms, "Chatrooms fetched successfully!"));
});

const renameChatRoom = AsyncHandler(async (req, res) => {
  const { id, name } = req.query;

  if (!name) {
    throw new ApiError(400, "Name is required");
  }

  const updatedChatRoom = await ChatRoom.findByIdAndUpdate(
    id,
    {
      $set: {
        name: name,
      },
    },
    { new: true }
  );

  if (!updatedChatRoom) {
    throw new ApiError(400, "No chatroom found to update");
  }

  return res
    .status(200)
    .json(new ApiResponse(200, updatedChatRoom, "Name updated"));
});

const deleteChatRoom = AsyncHandler(async (req, res) => {
  const chatroomId = req.query.id;

  const messagesToDelete = await Message.deleteMany({
    chatRoom: chatroomId,
  });

  console.log(messagesToDelete.deletedCount);

  const deletedChatroom = await ChatRoom.findByIdAndDelete(chatroomId);

  console.log(deletedChatroom.name);

  return res
    .status(200)
    .json(
      new ApiResponse(
        200,
        `Chatroom deleted: ${deletedChatroom.name}`,
        "chatroom deleted successfully !!"
      )
    );
});

const leaveChatRoom = AsyncHandler(async (req, res) => {
  const { chatroomId } = req.query.id;

  const chatroom = await ChatRoom.findByIdAndUpdate(
    chatroomId,
    {
      $pull: {
        members: req.user._id,
      },
    },
    { new: true }
  );

  return res
    .status(200)
    .json(
      new ApiResponse(200, `${chatroom.members}`, "group left successfully")
    );
});

// members

const addParticipants = AsyncHandler(async (req, res) => {
  const { chatroomId, participants } = req.body;
  console.log(req.body);

  const existingChatroom = await ChatRoom.findById(chatroomId);
  if (!existingChatroom) {
    throw new ApiError(400, "Chatroom does not exist");
  }

  const findExistingParticipants = await ChatRoom.findOne({
    _id: chatroomId,
    members: { $in: participants },
  });

  if (findExistingParticipants) {
    throw new ApiError(409, "Some participants already exist");
  }

  const updatedChatroom = await ChatRoom.findByIdAndUpdate(
    chatroomId,
    {
      $push: {
        members: { $each: participants },
      },
    },
    { new: true }
  );

  res
    .status(200)
    .json(
      new ApiResponse(
        200,
        updatedChatroom.members,
        `Participants added successfully to chatroom: ${chatroomId}`
      )
    );
});

const sendMessages = AsyncHandler(async (req, res) => {
  const { chatroomId, message } = req.body;

  const existingChatroom = await ChatRoom.aggregate([
    {
      $match: {
        _id: chatroomId,
        members: {
          $in: [req.user._id],
        },
      },
    },
  ]);

  if (!existingChatroom) {
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

const getMessages = AsyncHandler(async (req, res) => {
  const { id, page = 1, limit = 10 } = req.query;

  const parsePage = parseInt(page);
  const parseLimit = parseInt(limit);

  const skip = (parsePage - 1) * parseLimit;

  const messages = await Message.aggregate([
    {
      $match: {
        chatRoom: new mongoose.Types.ObjectId(id),
      },
    },
    {
      $lookup: {
        from: "users",
        localField: "sender",
        foreignField: "_id",
        as: "senders",
      },
    },

    {
      $addFields: {
        name: "$senders.fullName",
      },
    },

    {
      $addFields: {
        senderId: "$senders._id",
      },
    },

    {
      $unwind: "$name",
    },

    {
      $unwind: "$senderId",
    },

    {
      $project: {
        _id: 1,
        name: 1,
        senderId: 1,
        content: 1,
        attachments: 1,

        time: {
          $dateToString: {
            format: "%H:%M", // Specify the format to show only time
            date: "$createdAt",
            timezone: "Asia/Kolkata", // Specify the timezone if needed
          },
        },
        createdAt: 1,
      },
    },
    {
      $sort: {
        createdAt: -1,
      },
    },
    {
      $skip: skip,
    },
    {
      $limit: parseLimit,
    },
  ]);

  if (!messages) {
    throw new ApiError(400, "No messages found for the given chatroom id");
  }

  res
    .status(200)
    .json(
      new ApiResponse(200, messages, "All messages fetched successfully!!")
    );
});

const removeMember = AsyncHandler(async (req, res) => {
  const { chatroomId, userId } = req.body;
  const admin = req.user._id;

  if (admin === userId) {
    throw new ApiError(400, "Admin cannot remove itself");
  }

  const chatroom = await ChatRoom.findById(chatroomId);

  if (chatroom.creator._id !== admin) {
    throw new ApiError(500, "Only admin can remove a member");
  }

  const updatedChatroom = await ChatRoom.findByIdAndUpdate(
    chatroomId,
    {
      $pull: {
        members: userId,
      },
    },
    { new: true }
  );

  return res
    .status(200)
    .json(200, updatedChatroom.members, "Member removed successfully !!");
});

export {
  createGroupChat,
  createPersonalChat,
  getChatRoomsList,
  getSingleChatRoom,
  addParticipants,
  searchChatRooms,
  getChatRoomDetails,
  renameChatRoom,
  deleteChatRoom,
  leaveChatRoom,
  sendMessages,
  getMessages,
  removeMember,
};
