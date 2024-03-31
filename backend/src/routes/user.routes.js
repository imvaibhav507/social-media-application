import { Router } from "express";
import {
  registerUser,
  loginUser,
  changeAvatar,
  addGender,
  searchUsers,
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

export default router;
