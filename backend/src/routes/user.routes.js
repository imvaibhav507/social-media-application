import { Router } from "express";
import {
  registerUser,
  loginUser,
  changeAvatar,
  addGender,
  searchUsers,
  getUser,
  followUser,
  unfollowUser,
  removeFollowerUser,
  getUserProfile,
  searchUserProfiles,
  sendFollowRequest,
  approveFollowRequest,
  getFollowRequestsList,
  getRecentFollowRequest,
  getFollowersList,
  getFollowingsList,
} from "../controllers/user.controller.js";
import { upload } from "../middlewares/multer.middleware.js";
import { verifyJWT } from "../middlewares/auth.middleware.js";

const router = Router();

router.route("/register").post(upload.single("avatar"), registerUser);
router.route("/login").post(loginUser);
router
  .route("/update-avatar")
  .patch(verifyJWT, upload.single("avatar"), changeAvatar);
router.route("/add-gender").patch(verifyJWT, addGender);
router.route("/search-users/").get(verifyJWT, searchUsers);
router.route("/search-user-profile/").get(verifyJWT, searchUserProfiles);
router.route("/get-user").get(verifyJWT, getUser);
router.route("/get-user-profile/").get(verifyJWT, getUserProfile);
router
  .route("/follow/")
  .post(verifyJWT, followUser)
  .delete(verifyJWT, unfollowUser);
router.route("/remove-follower/").delete(verifyJWT, removeFollowerUser);
router.route("/followers").get(verifyJWT, getFollowersList);
router.route("/followings").get(verifyJWT, getFollowingsList);
router
  .route("/follow-request/")
  .put(verifyJWT, sendFollowRequest)
  .delete(verifyJWT, approveFollowRequest)
  .get(verifyJWT, getFollowRequestsList);
router.route("/follow-request-item").get(verifyJWT, getRecentFollowRequest);
export default router;
