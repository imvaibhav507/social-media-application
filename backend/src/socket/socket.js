import { Server } from "socket.io";
import http from "http";
import { app } from "../app.js";

const server = http.createServer(app);

const io = new Server(server, {
  pingTimeout: 60000,
  cors: {
    origin: process.env.CORS_ORIGIN,
  },
});
io.on("connection", (socket) => {
  console.log("connected to socket.io");

  socket.on("setup", (userId) => {
    socket.join(userId);
    socket.broadcast.emit("online-user", userId);
    console.log(userId);
  });

  socket.on("typing", (chatroom) => {
    console.log("typing");
    console.log("chatroom");
    socket.to(chatroom).emit("typing", chatroom);
  });

  socket.on("stop typing", (chatroom) => {
    console.log("stop typing");
    console.log("chatroom");
    socket.to(chatroom).emit("stop typing", chatroom);
  });

  socket.on("join chatroom", (chatroom) => {
    socket.join(chatroom);
    console.log("User joined : ", chatroom);
  });

  socket.on("message sent", (message) => {
    console.log(message);
  });

  socket.on("new message", (newMessageReceived) => {
    var chatRoom = newMessageReceived.chatRoom;
    var sender = newMessageReceived.sender;

    if (!sender || !sender._id) {
      console.log("sender not defined");
      return;
    }
    console.log("message sender", sender._id);

    const members = chatRoom.members;
    if (!members) {
      console.log("members not defined");
      return;
    }

    socket.to(chatRoom).emit("message received", newMessageReceived);
    socket.to(chatRoom).emit("message sent", "new message");
  });
  socket.off("setup", () => {
    console.log("user offline");
    socket.leave(userId);
  });

  server.on("disconnect", () => {
    console.log("client disconnected");
  });
});

export { io, server };
