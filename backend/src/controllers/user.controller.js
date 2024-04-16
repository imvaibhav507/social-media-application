import { AsyncHandler } from "../utils/AsyncHandler.js";
import { ApiError } from "../utils/ApiError.js";
import { ApiResponse } from "../utils/ApiResponse.js";
import { User } from "../models/user.model.js";
import mongoose from "mongoose";
import { uploadOnCloudinary } from "../utils/Cloudinary.js";
import { Follow } from "../models/follow.model.js";

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

const getUser = AsyncHandler(async (req, res) => {
  const userId = req.user._id;

  const fetchedUser = await User.aggregate([
    {
      $match: {
        _id: userId,
      },
    },

    {
      $project: {
        email: 1,
        username: 1,
        fullname: "$fullName",
        avatar: 1,
        gender: 1,
        dateOfBirth: 1,
      },
    },
  ]);

  return res
    .status(200)
    .json(new ApiResponse(200, fetchedUser[0], "User fetched successfully!!"));
});

const getUserProfile = AsyncHandler(async (req, res) => {
  const userId = req.query.userId;
  const fetchedUserProfile = await User.aggregate([
    {
      $match: {
        _id: new mongoose.Types.ObjectId(userId),
      },
    },

    {
      $lookup: {
        from: "follows",
        localField: "_id",
        foreignField: "following",
        as: "follower",
      },
    },

    {
      $lookup: {
        from: "follows",
        localField: "_id",
        foreignField: "follower",
        as: "following",
      },
    },
    {
      $lookup: {
        from: "posts",
        localField: "_id",
        foreignField: "creator",
        as: "posts",
      },
    },
    {
      $addFields: {
        postsCount: {
          $size: {
            $filter: {
              input: "$posts",
              as: "post",
              cond: {
                $eq: ["$$post.postType", "FEED"],
              },
            },
          },
        },
        followings: {
          $size: "$following",
        },
        followers: {
          $size: "$follower",
        },
      },
    },

    {
      $project: {
        username: 1,
        fullname: "$fullName",
        avatar: 1,
        postsCount: 1,
        followings: 1,
        followers: 1,
      },
    },
  ]);

  if (!fetchedUserProfile) {
    throw new ApiError(400, "User not found");
  }

  return res
    .status(200)
    .json(
      new ApiResponse(
        200,
        fetchedUserProfile[0],
        "User fetched successfully !!"
      )
    );
});
const searchUsers = AsyncHandler(async (req, res) => {
  const { chatroomId, searchQuery } = req.query;
  console.log(chatroomId, searchQuery);
  const foundUsers = await User.aggregate([
    {
      $match: {
        $or: [
          {
            fullName: {
              $regex: searchQuery,
              $options: "i",
            },
          },
          {
            username: {
              $regex: searchQuery,
              $options: "i",
            },
          },
        ],
      },
    },
    {
      $lookup: {
        from: "chatrooms",
        let: { userId: "$_id" },
        pipeline: [
          {
            $match: {
              $expr: {
                $in: ["$$userId", "$members"],
              },
              _id: new mongoose.Types.ObjectId(chatroomId),
            },
          },
        ],
        as: "chatroom",
      },
    },
    {
      $project: {
        _id: 1,
        fullName: 1,
        avatar: 1,
        username: 1,
        isAdded: {
          $cond: {
            if: { $gt: [{ $size: "$chatroom" }, 0] },
            then: true,
            else: false,
          },
        },
      },
    },
  ]);

  return res
    .status(200)
    .json(new ApiResponse(200, foundUsers, "User fetched successfully !!"));
});

const searchUserProfiles = AsyncHandler(async (req, res) => {
  const searchQuery = req.query.searchQuery;

  if (!searchQuery || searchQuery === "") {
    throw new ApiError(400, "No text entered");
  }

  const foundUserProfiles = await User.aggregate([
    {
      $match: {
        $or: [
          {
            fullName: {
              $regex: searchQuery,
              $options: "i",
            },
          },
          {
            username: {
              $regex: searchQuery,
              $options: "i",
            },
          },
        ],
        _id: { $ne: req.user._id },
      },
    },

    {
      $lookup: {
        from: "follows",
        localField: "_id",
        foreignField: "following",
        as: "followings",
      },
    },

    {
      $addFields: {
        followedByYou: {
          $cond: {
            if: { $in: [req.user._id, "$followings.follower"] },
            then: true,
            else: false,
          },
        },
      },
    },

    {
      $project: {
        fullname: "$fullName",
        username: 1,
        avatar: 1,
        followedByYou: 1,
      },
    },
  ]);

  return res
    .status(200)
    .json(new ApiResponse(200, foundUserProfiles, "found users"));
});

const followUser = AsyncHandler(async (req, res) => {
  const userId = req.query.userId;

  const searchFollow = await Follow.findOne({
    follower: req.user._id,
    following: userId,
  });

  if (searchFollow) {
    throw new ApiError(400, "Already following the user");
  }

  const createdFollow = await Follow.create({
    follower: req.user._id,
    following: userId,
  });

  if (!createdFollow) {
    throw new ApiError(400, "Error while following the user");
  }

  return res
    .status(200)
    .json(new ApiResponse(200, createdFollow, "User followed successfully !!"));
});

const unfollowUser = AsyncHandler(async (req, res) => {
  const userId = req.query.userId;
  const unfollowedUser = await Follow.deleteOne({
    follower: req.user._id,
    following: userId,
  });

  return res
    .status(200)
    .json(
      new ApiResponse(200, unfollowedUser, "User unfollowed successfully !!")
    );
});

export {
  registerUser,
  loginUser,
  changeAvatar,
  addGender,
  searchUsers,
  getUser,
  followUser,
  unfollowUser,
  getUserProfile,
  searchUserProfiles,
};
