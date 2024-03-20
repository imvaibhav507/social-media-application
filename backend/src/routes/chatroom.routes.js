import { Router } from "express";
import { upload } from "../middlewares/multer.middleware.js";
import { verifyJWT } from "../middlewares/auth.middleware.js";
import {
  createGroupChat,
  getChatRooms,
  addParticipants,
  sendMessages,
} from "../controllers/chat.controller.js";

const chatroomRouter = Router();

chatroomRouter.route("/new").post(verifyJWT, createGroupChat);
chatroomRouter.route("/chatrooms").get(verifyJWT, getChatRooms);
chatroomRouter.route("/add-participants").put(verifyJWT, addParticipants);
chatroomRouter
  .route("/send-message")
  .post(verifyJWT, upload.array("attachments", 10), sendMessages);
export default chatroomRouter;
