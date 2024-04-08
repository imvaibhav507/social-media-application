import { Router } from "express";
import { upload } from "../middlewares/multer.middleware.js";
import { verifyJWT } from "../middlewares/auth.middleware.js";
import { createNewPost, getAllPosts } from "../controllers/post.controller.js";

const postRouter = Router();

postRouter
  .route("/create-post")
  .post(verifyJWT, upload.array("attachments", 10), createNewPost);

postRouter.route("/get-posts").get(verifyJWT, getAllPosts);

export default postRouter;
