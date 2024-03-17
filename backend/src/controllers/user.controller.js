import { AsyncHandler } from "../utils/AsyncHandler.js";
import { ApiError } from "../utils/ApiError.js";
import { ApiResponse } from "../utils/ApiResponse.js";
import { User } from "../models/user.model.js";
import mongoose from "mongoose";
import { uploadOnCloudinary } from "../utils/Cloudinary.js";

const generateAccessAndRefreshToken = async (userId) => {
  try {
    const user = await User.findById(userId);
    const accessToken = await user.generateAccessToken();
    const refreshToken = await user.generateRefreshToken();

    user.refreshToken = refreshToken;
    user.save({ validateBeforeSave: false });
    return { accessToken, refreshToken };
  } catch (error) {
    throw new ApiError(500, "Something went wrong while generating token");
  }
};

const registerUser = AsyncHandler(async (req, res) => {
  const { fullName, email, username, dateOfBirth, password } = req.body;

  console.log(fullName, email, username, dateOfBirth);

  // validation
  if (
    [fullName, email, username, password, dateOfBirth].some(
      (field) => field?.trim() === ""
    )
  ) {
    throw new ApiError(400, "All fields are required");
  }

  const existingUser = await User.findOne({
    $or: [{ username }, { email }],
  });

  if (existingUser) {
    throw new ApiError(409, "User with given name or email already exist.");
  }

  // const avatarLocalPath = req.file?.path;
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

  // create new db entry
  const user = await User.create({
    fullName,
    avatar: avatar.url || "./public/temp/user.png",
    email,
    password,
    username: username.toLowerCase(),
    dateOfBirth,
  });

  const createdUser = await User.findById(user._id).select(
    "-password -refreshToken"
  );
  if (!createdUser) {
    throw new ApiError(500, "Something went wrong while creating user");
  }

  return res
    .status(200)
    .json(new ApiResponse(200, "User registered successfully"));
});

const loginUser = AsyncHandler(async (req, res) => {
  const { username, email, password } = req.body;
  if (!(username || email)) {
    throw new ApiError(400, "username or email required");
  }

  const user = await User.findOne({
    $or: [{ username }, { email }],
  });

  if (!user) {
    throw new ApiError(404, "User does not exit");
  }

  const isPasswordValid = await user.isPasswordCorrect(password);
  if (!isPasswordValid) {
    throw new ApiError(401, "Incorrect password");
  }

  const { accessToken, refreshToken } = await generateAccessAndRefreshToken(
    user._id
  );

  const loggedInUser = await User.findById(user._id).select(
    "-password -accessToken"
  );
  console.log(loggedInUser._id, accessToken, refreshToken);

  return res.json(
    new ApiResponse(200, {
      userId: loggedInUser._id,
      accessToken,
      refreshToken,
    })
  );
});

const changeAvatar = AsyncHandler(async (req, res) => {
  const avatarLocalPath = req.file?.path;
  if (!avatarLocalPath) {
    throw new ApiError(400, "Avatar is required");
  }

  const avatar = await uploadOnCloudinary(avatarLocalPath);
  if (!avatar.url) {
    throw new ApiError(400, "Error while uploading avatar");
  }

  await User.findByIdAndUpdate(
    req.user?._id,
    {
      $set: { avatar: avatar.url },
    },
    { new: true }
  );

  return res
    .status(200)
    .json(new ApiResponse(200, avatar.url, "Avatar uploaded successfully"));
});

const addGender = AsyncHandler(async (req, res) => {
  const { gender } = req.body;
  if (!gender) {
    throw new ApiError(400, "Please mention your gender");
  }

  await User.findByIdAndUpdate(
    req.user?._id,
    {
      $set: { gender: gender },
    },
    { new: true }
  );

  return res
    .status(200)
    .json(new ApiResponse(200, gender, "Gender added successfully"));
});
export { registerUser, loginUser, changeAvatar, addGender };
