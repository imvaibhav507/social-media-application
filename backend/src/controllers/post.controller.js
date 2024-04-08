import { AsyncHandler } from "../utils/AsyncHandler.js";
import { ApiError } from "../utils/ApiError.js";
import { ApiResponse } from "../utils/ApiResponse.js";
import { mongoose } from "mongoose";
import { Post } from "../models/post.model.js";
import { uploadOnCloudinary } from "../utils/Cloudinary.js";

const createNewPost = AsyncHandler(async (req, res) => {
  const caption = req.body.caption;
  const files = req.files;
  console.log(caption, files);
  if (!files || !caption) {
    throw new ApiError(400, "Attachments and caption are required");
  }

  const uploadedFiles = await Promise.all(
    files.map(async (file) => await uploadOnCloudinary(file.path))
  );

  const urls = uploadedFiles.map((uploadedFile) => uploadedFile.url);
  console.log(urls);

  const newPost = await Post.create({
    postType: "FEED",
    caption: caption,
    attachments: urls,
    creator: req.user._id,
  });

  return res
    .status(200)
    .json(new ApiResponse(200, newPost, "Post created successfully !!"));
});

const getAllPosts = AsyncHandler(async (req, res) => {
  const fetchedPosts = await Post.aggregate([
    {
      $lookup: {
        from: "users",
        localField: "creator",
        foreignField: "_id",
        as: "creator",
      },
    },

    {
      $unwind: "$creator",
    },

    {
      $project: {
        attachments: 1,
        caption: 1,
        creator: {
          _id: 1,
          fullName: 1,
          username: 1,
          avatar: 1,
        },
        createdAt: {
          $dateToString: {
            format: "%H:%M", // Specify the format to show only time
            date: "$createdAt",
            timezone: "Asia/Kolkata", // Specify the timezone if needed
          },
        },
      },
    },
  ]);

  return res
    .status(200)
    .json(
      new ApiResponse(200, fetchedPosts, "All posts fetched successfully !!")
    );
});
export { createNewPost, getAllPosts };
