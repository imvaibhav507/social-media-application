import { Router } from "express";
import { upload } from "../middlewares/multer.middleware.js";
import { verifyJWT } from "../middlewares/auth.middleware.js";
import {
  createGroupChat,
  createPersonalChat,
  getChatRoomsList,
  getSingleChatRoom,
  addParticipants,
  getChatRoomDetails,
  getPersonalChatRoomDetails,
  searchChatRooms,
  renameChatRoom,
  sendMessages,
  getMessages,
  deleteChatRoom,
  leaveChatRoom,
} from "../controllers/chat.controller.js";

const chatroomRouter = Router();

chatroomRouter
  .route("/new-group-chat")
  .post(verifyJWT, upload.single("avatar"), createGroupChat);
chatroomRouter.route("/new-personal-chat/").get(verifyJWT, createPersonalChat);
chatroomRouter.route("/chatrooms").get(verifyJWT, getChatRoomsList);
chatroomRouter.route("/single-chatroom/").get(verifyJWT, getSingleChatRoom);
chatroomRouter.route("/add-participants").patch(verifyJWT, addParticipants);
chatroomRouter.route("/search-chatrooms/").get(verifyJWT, searchChatRooms);
chatroomRouter.route("/leave-chatroom").patch(verifyJWT, leaveChatRoom);
chatroomRouter
  .route("/send-message")
  .post(verifyJWT, upload.array("attachments", 10), sendMessages);
chatroomRouter.route("/get-messages/").get(verifyJWT, getMessages);

chatroomRouter
  .route("/")
  .get(verifyJWT, getChatRoomDetails)
  .delete(verifyJWT, deleteChatRoom)
  .patch(verifyJWT, renameChatRoom);

chatroomRouter
  .route("/personal-chat/")
  .get(verifyJWT, getPersonalChatRoomDetails);

export default chatroomRouter;
