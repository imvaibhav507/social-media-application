import { Router } from "express";
import { upload } from "../middlewares/multer.middleware.js";
import { verifyJWT } from "../middlewares/auth.middleware.js";
import {
  addComment,
  checkPostLiked,
  createNewPost,
  deleteComment,
  editComment,
  getAllComments,
  getAllPosts,
  likePost,
  unlikePost,
} from "../controllers/post.controller.js";

const postRouter = Router();

postRouter
  .route("/create-post")
  .post(verifyJWT, upload.array("attachments", 10), createNewPost);

postRouter.route("/get-posts").get(verifyJWT, getAllPosts);

postRouter.route("/like-post/").put(verifyJWT, likePost);

postRouter.route("/check-like/").get(verifyJWT, checkPostLiked);

postRouter.route("/unlike-post/").delete(verifyJWT, unlikePost);

postRouter.route("/add-comment").post(verifyJWT, addComment);
postRouter.route("/delete-comment/").delete(verifyJWT, deleteComment);
postRouter.route("/edit-comment").patch(verifyJWT, editComment);
postRouter.route("/all-comments/").get(verifyJWT, getAllComments);

export default postRouter;
