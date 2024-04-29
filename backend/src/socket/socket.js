import { Server } from "socket.io";
import http from "http";
import { app } from "../app.js";
import { mongoose } from "mongoose";
import { v4 as uuid } from "uuid";
import { ChatRoom } from "../models/chatroom.model.js";
import { ApiError } from "../utils/ApiError.js";

const server = http.createServer(app);

const io = new Server(server, {
  pingTimeout: 60000,
  cors: {
    origin: process.env.CORS_ORIGIN,
  },
});

export const getReceiverSocketId = (chatroom) => {
  console.log(chatroomSocketMap[chatroom]);
  // const filteredSocketId = chatroomSocketMap[chatroom].filter(
  //   (id) => id !== socket.id
  // );
  return chatroomSocketMap[chatroom];
};

export const getUserSocketId = (userId) => {
  return chatroomSocketMap[userId];
};

const userSocketMap = {};

const chatroomSocketMap = {};

io.on("connection", (socket) => {
  console.log("connected to socket.io", socket.id);

  const { userId } = socket.handshake.query;

  if (userId) {
    userSocketMap[userId] = socket.id;
    console.log("userSocketMap", userSocketMap);
  }

  io.emit("get online users", Object.keys(userSocketMap));

  socket.on("join chatroom", (chatroom) => {
    socket.join(chatroom);

    if (!chatroomSocketMap[chatroom]) {
      chatroomSocketMap[chatroom] = [socket.id];
    } else {
      chatroomSocketMap[chatroom].push(socket.id);
    }
    console.log("User joined : ", chatroom);
    console.log("chatroomSocketMap", chatroomSocketMap);
  });

  socket.on("leave chatroom", (chatroom) => {
    socket.leave(chatroom);

    if (chatroomSocketMap[chatroom]) {
      chatroomSocketMap[chatroom] = chatroomSocketMap[chatroom].filter(
        (id) => id !== socket.id
      );
      if (chatroomSocketMap[chatroom].length === 0) {
        delete chatroomSocketMap[chatroom];
      }
    }

    console.log(`Socket ${socket.id} left chatroom ${chatroom}`);
    console.log("chatroomSocketMap", chatroomSocketMap);
  });

  socket.off("setup", (userId) => {
    console.log("user offline");
    socket.leave(userId);
  });

  socket.on("typing", (data) => {
    console.log("typing", data);

    if (chatroomSocketMap[data.chatroom]) {
      const filteredSocketId = chatroomSocketMap[data.chatroom].filter(
        (id) => id !== socket.id
      );

      console.log("filtered Ids", filteredSocketId);
      if (filteredSocketId.length > 0) {
        io.to(filteredSocketId).emit("typing", data);
      }
    }
  });

  socket.on("stop typing", (chatroom) => {
    console.log("stop typing");

    if (chatroomSocketMap[chatroom]) {
      const filteredSocketId = chatroomSocketMap[chatroom].filter(
        (id) => id !== socket.id
      );

      console.log("filtered Ids", filteredSocketId);
      if (filteredSocketId) {
        io.to(filteredSocketId).emit("stop typing");
      }
    }
  });

  socket.on("update chat", async (data) => {
    const fetchedChatroom = await ChatRoom.findById(data.chatroom);

    const chatItem = await ChatRoom.aggregate([
      {
        $match: {
          _id: new mongoose.Types.ObjectId(data.chatroom),
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
        $lookup: {
          from: "users", // Assuming the collection name is "users"
          localField: "members",
          foreignField: "_id",
          as: "memberDetails",
        },
      },

      {
        $addFields: {
          filteredMembers: {
            $filter: {
              input: "$memberDetails",
              as: "member",
              cond: {
                $ne: ["$$member._id", new mongoose.Types.ObjectId(data.user)],
              },
            },
          },
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
          name: {
            $cond: {
              if: "$isGroupChat",
              then: "$name",
              else: {
                $first: "$filteredMembers.fullName",
              },
            },
          },
          lastMessage: "$lastMessage.content",
          avatar: {
            $cond: {
              if: "$isGroupChat",
              then: "$avatar",
              else: {
                $first: "$filteredMembers.avatar",
              },
            },
          },
          otherMembers: "$filteredMembers._id",
          isGroupChat: 1,
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

    const memberIds = fetchedChatroom.members.map((member) =>
      member.toString()
    );

    if (!memberIds) {
      throw new ApiError(400, "No ids found");
    }
    memberIds.forEach((memberId) => {
      const socketId = userSocketMap[memberId];
      if (socketId) {
        // Step 4: Emit the message to the socket ID
        io.to(socketId).emit("update chat", chatItem[0]);
      } else {
        console.log(`Socket ID not found for user ID: ${memberId}`);
      }
    });
  });

  socket.on("disconnect", () => {
    console.log("client disconnected", socket.id);
    delete userSocketMap[userId];
    io.emit("get online users", Object.keys(userSocketMap));
  });
});

export { io, server };
