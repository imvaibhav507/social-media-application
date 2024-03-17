import { Router } from "express";
import {
  registerUser,
  loginUser,
  changeAvatar,
  addGender,
} from "../controllers/user.controller.js";
import { upload } from "../middlewares/multer.middleware.js";
import { verifyJWT } from "../middlewares/auth.middleware.js";

const router = Router();

router.route("/users/register").post(upload.single("avatar"), registerUser);
router.route("/users/login").post(loginUser);
router
  .route("/users/update-avatar")
  .patch(verifyJWT, upload.single("avatar"), changeAvatar);
router.route("/users/add-gender").patch(verifyJWT, addGender);

export default router;
