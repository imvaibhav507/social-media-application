import { AsyncHandler } from "../utils/AsyncHandler.js";
import { ApiError } from "../utils/ApiError.js";
import { ApiResponse } from "../utils/ApiResponse.js";
import { mongoose } from "mongoose";
import { Post } from "../models/post.model.js";
import { Like } from "../models/like.model.js";
import { Comment } from "../models/comment.model.js";
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
      $match: {
        postType: "FEED",
      },
    },
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
      $lookup: {
        from: "likes",
        let: { postId: "$_id" },
        pipeline: [
          {
            $match: {
              $expr: {
                $and: [
                  { $eq: ["$postLiked", "$$postId"] }, // Match the post ID
                  {
                    $eq: [
                      "$likedBy",
                      new mongoose.Types.ObjectId(req.user._id),
                    ],
                  }, // Match the user ID
                ],
              },
            },
          },
        ],
        as: "likes",
      },
    },
    {
      $addFields: {
        isLikedBy: {
          $cond: {
            if: { $gt: [{ $size: "$likes" }, 0] },
            then: true,
            else: false,
          },
        },
      },
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
            format: "%H:%M",
            date: "$createdAt",
            timezone: "Asia/Kolkata",
          },
        },
        isLikedBy: 1,
      },
    },
  ]);

  return res
    .status(200)
    .json(
      new ApiResponse(200, fetchedPosts, "All posts fetched successfully !!")
    );
});

const getUserPostList = AsyncHandler(async (req, res) => {
  const userId = req.query.userId;

  const fetchedPostList = await Post.aggregate([
    {
      $match: {
        creator: new mongoose.Types.ObjectId(userId),
        postType: "FEED",
      },
    },

    {
      $addFields: {
        isMultiPost: {
          $cond: {
            if: {
              $gt: [{ $size: "$attachments" }, 1],
            },
            then: true,
            else: false,
          },
        },
      },
    },

    {
      $project: {
        cover: { $first: "$attachments" },
        isMultiPost: 1,
      },
    },
  ]);

  if (!fetchedPostList) {
    throw new ApiError(400, "No posts found");
  }

  return res
    .status(200)
    .json(new ApiResponse(200, fetchedPostList, "All posts fetched !!"));
});

const likePost = AsyncHandler(async (req, res) => {
  const postId = req.query.postId;

  const findPost = await Post.findById(postId);
  if (!findPost) {
    throw new ApiError(400, "No post found with given id");
  }

  const findLiked = await Like.findOne({
    likedBy: req.user._id,
    postLiked: postId,
  });

  if (findLiked) {
    throw new ApiError(400, "Post already liked");
  }

  const liked = await Like.create({
    likedBy: req.user._id,
    postLiked: postId,
  });

  if (!liked) {
    throw new ApiError(400, "Error while liking the post");
  }

  return res.status(200).json(new ApiResponse(200, liked, "Post Liked"));
});

const unlikePost = AsyncHandler(async (req, res) => {
  const postId = req.query.postId;

  const findPost = await Post.findById(postId);
  if (!findPost) {
    throw new ApiError(400, "No post found with given id");
  }

  const unliked = await Like.deleteOne({
    likedBy: req.user._id,
    postLiked: postId,
  });

  if (!unliked) {
    throw new ApiError(400, "Error while unliking the post");
  }

  return res.status(200).json(new ApiResponse(200, unliked, "Post unliked"));
});

const checkPostLiked = AsyncHandler(async (req, res) => {
  const postId = req.query.postId;

  const findPost = await Post.findById(postId);
  if (!findPost) {
    throw new ApiError(400, "No post found with given id");
  }

  const checkLike = await Like.find({
    likedBy: req.user._id,
    postLiked: postId,
  });

  if (!checkLike) {
    throw new ApiError(400, "Error while fetching like");
  }

  var liked = true;
  if (checkLike.length == 0) {
    liked = false;
  }

  return res.status(200).json(new ApiResponse(200, liked, "Post Liked"));
});

const addComment = AsyncHandler(async (req, res) => {
  const { comment, postId } = req.body;
  console.log(comment, postId);
  if (!comment) {
    throw new ApiError(400, "Comment cannot be empty");
  }

  const createdComment = await Comment.create({
    post: postId,
    content: comment,
    commentedBy: req.user._id,
  });

  if (!createdComment) {
    throw new ApiError(400, "Error while creating comment");
  }

  return res
    .status(200)
    .json(new ApiResponse(200, createdComment, "Comment added successfully!!"));
});

const deleteComment = AsyncHandler(async (req, res) => {
  const commentId = req.query.commentId;
  if (!commentId) {
    throw new ApiError(400, "No comment found to be deleted");
  }

  const deletedComment = await Comment.findByIdAndDelete(commentId);

  return res
    .status(200)
    .json(new ApiResponse(200, deletedComment, "Comment deleted"));
});

const editComment = AsyncHandler(async (req, res) => {
  const { newComment, commentId } = req.body;

  if (!newComment) {
    throw new ApiError(400, "Comment cannot be empty");
  }

  const updatedComment = await Comment.findByIdAndUpdate(
    commentId,
    {
      $set: {
        content: newComment,
      },
    },
    { new: true }
  );

  if (!updatedComment) {
    throw new ApiError(400, "Error while updating comment");
  }

  return res
    .status(200)
    .json(200, updatedComment, "Comment updated successfully !!");
});

const getAllComments = AsyncHandler(async (req, res) => {
  const postId = req.query.postId;
  const fetchedComments = await Comment.aggregate([
    {
      $match: {
        post: new mongoose.Types.ObjectId(postId),
      },
    },

    {
      $lookup: {
        from: "users",
        localField: "commentedBy",
        foreignField: "_id",
        as: "user",
      },
    },
    {
      $unwind: "$user",
    },

    {
      $sort: {
        createdAt: -1,
      },
    },

    {
      $addFields: {
        currentTime: new Date(), // Add a field to store the current time
      },
    },
    {
      $addFields: {
        timeDifference: {
          $subtract: ["$currentTime", "$createdAt"],
        }, // Calculate the time difference
      },
    },
    {
      $addFields: {
        secondsAgo: {
          $divide: ["$timeDifference", 1000],
        }, // Convert time difference to seconds
        minutesAgo: {
          $divide: ["$timeDifference", 1000 * 60],
        }, // Convert time difference to minutes
        hoursAgo: {
          $divide: ["$timeDifference", 1000 * 60 * 60],
        }, // Convert time difference to hours
        daysAgo: {
          $divide: ["$timeDifference", 1000 * 60 * 60 * 24],
        }, // Convert time difference to days
        weeksAgo: {
          $divide: ["$timeDifference", 1000 * 60 * 60 * 24 * 7],
        }, // Convert time difference to weeks
      },
    },
    {
      $addFields: {
        formattedCreatedAt: {
          $cond: {
            if: { $lt: ["$secondsAgo", 60] }, // If seconds ago is less than 60 seconds
            then: {
              $concat: [
                {
                  $toString: {
                    $floor: "$secondsAgo",
                  },
                },
                " seconds ago",
              ],
            }, // Format as seconds ago
            else: {
              $cond: {
                if: { $lt: ["$minutesAgo", 60] }, // If minutes ago is less than 60 minutes
                then: {
                  $concat: [
                    {
                      $toString: {
                        $floor: "$minutesAgo",
                      },
                    },
                    " minutes ago",
                  ],
                }, // Format as minutes ago
                else: {
                  $cond: {
                    if: { $lt: ["$hoursAgo", 24] }, // If hours ago is less than 24 hours
                    then: {
                      $concat: [
                        {
                          $toString: {
                            $floor: "$hoursAgo",
                          },
                        },
                        " hours ago",
                      ],
                    }, // Format as hours ago
                    else: {
                      $cond: {
                        if: {
                          $lt: ["$daysAgo", 7],
                        }, // If days ago is less than 7 days
                        then: {
                          $concat: [
                            {
                              $toString: {
                                $floor: "$daysAgo",
                              },
                            },
                            " days ago",
                          ],
                        }, // Format as days ago
                        else: {
                          $concat: [
                            {
                              $toString: {
                                $floor: "$weeksAgo",
                              },
                            },
                            " weeks ago",
                          ],
                        }, // Format as weeks ago
                      },
                    },
                  },
                },
              },
            },
          },
        },
      },
    },

    {
      $project: {
        avatar: "$user.avatar",
        fullname: "$user.fullName",
        content: 1,
        commentedBy: 1,
        CreatedAt: "$formattedCreatedAt",
      },
    },
  ]);

  return res
    .status(200)
    .json(new ApiResponse(200, fetchedComments, "All comments fetched!!"));
});

const addStory = AsyncHandler(async (req, res) => {
  const files = req.files;
  console.log(files);
  if (!files) {
    throw new ApiError(400, "Attachments are required");
  }

  const uploadedFiles = await Promise.all(
    files.map(async (file) => await uploadOnCloudinary(file.path))
  );

  const urls = uploadedFiles.map((uploadedFile) => uploadedFile.url);
  console.log(urls);
  var story;
  const existingStory = await Post.findOne({
    postType: "STORY",
    creator: req.user._id,
  });

  if (existingStory) {
    const updatedStory = await Post.findOneAndUpdate(
      { postType: "STORY", creator: req.user._id },
      {
        $push: {
          attachments: { $each: urls },
        },
      },
      { new: true }
    );

    story = updatedStory;
  } else {
    const newStory = await Post.create({
      postType: "STORY",
      attachments: urls,
      caption: "caption",
      creator: req.user._id,
    });
    story = newStory;
  }
  return res
    .status(200)
    .json(new ApiResponse(200, story, "Story added successfully !!"));
});

const getAllStoriesList = AsyncHandler(async (req, res) => {
  const fetchedStories = await Post.aggregate([
    {
      $match: {
        postType: "STORY",
      },
    },

    {
      $lookup: {
        from: "users",
        localField: "creator",
        foreignField: "_id",
        as: "user",
      },
    },

    {
      $unwind: "$user",
    },

    {
      $project: {
        fullname: "$user.fullName",
        avatar: "$user.avatar",
        cover: { $first: "$attachments" },
        createdAt: "$formattedCreatedAt",
      },
    },
  ]);
  console.log(fetchedStories);
  return res
    .status(200)
    .json(new ApiResponse(200, fetchedStories, "All stories fetched !!"));
});

const getSingleStory = AsyncHandler(async (req, res) => {
  const postId = req.query.postId;
  const fetchedStory = await Post.aggregate([
    {
      $match: {
        _id: new mongoose.Types.ObjectId(postId),
      },
    },

    {
      $lookup: {
        from: "users",
        localField: "creator",
        foreignField: "_id",
        as: "user",
      },
    },
    {
      $unwind: "$user",
    },

    {
      $sort: {
        createdAt: -1,
      },
    },

    {
      $addFields: {
        currentTime: new Date(), // Add a field to store the current time
      },
    },
    {
      $addFields: {
        timeDifference: {
          $subtract: ["$currentTime", "$createdAt"],
        }, // Calculate the time difference
      },
    },
    {
      $addFields: {
        secondsAgo: {
          $divide: ["$timeDifference", 1000],
        }, // Convert time difference to seconds
        minutesAgo: {
          $divide: ["$timeDifference", 1000 * 60],
        }, // Convert time difference to minutes
        hoursAgo: {
          $divide: ["$timeDifference", 1000 * 60 * 60],
        }, // Convert time difference to hours
        daysAgo: {
          $divide: ["$timeDifference", 1000 * 60 * 60 * 24],
        }, // Convert time difference to days
        weeksAgo: {
          $divide: ["$timeDifference", 1000 * 60 * 60 * 24 * 7],
        }, // Convert time difference to weeks
      },
    },
    {
      $addFields: {
        formattedCreatedAt: {
          $cond: {
            if: { $lt: ["$secondsAgo", 60] }, // If seconds ago is less than 60 seconds
            then: {
              $concat: [
                {
                  $toString: {
                    $floor: "$secondsAgo",
                  },
                },
                " seconds ago",
              ],
            }, // Format as seconds ago
            else: {
              $cond: {
                if: { $lt: ["$minutesAgo", 60] }, // If minutes ago is less than 60 minutes
                then: {
                  $concat: [
                    {
                      $toString: {
                        $floor: "$minutesAgo",
                      },
                    },
                    " minutes ago",
                  ],
                }, // Format as minutes ago
                else: {
                  $cond: {
                    if: { $lt: ["$hoursAgo", 24] }, // If hours ago is less than 24 hours
                    then: {
                      $concat: [
                        {
                          $toString: {
                            $floor: "$hoursAgo",
                          },
                        },
                        " hours ago",
                      ],
                    }, // Format as hours ago
                    else: {
                      $cond: {
                        if: {
                          $lt: ["$daysAgo", 7],
                        }, // If days ago is less than 7 days
                        then: {
                          $concat: [
                            {
                              $toString: {
                                $floor: "$daysAgo",
                              },
                            },
                            " days ago",
                          ],
                        }, // Format as days ago
                        else: {
                          $concat: [
                            {
                              $toString: {
                                $floor: "$weeksAgo",
                              },
                            },
                            " weeks ago",
                          ],
                        }, // Format as weeks ago
                      },
                    },
                  },
                },
              },
            },
          },
        },
      },
    },

    {
      $project: {
        avatar: "$user.avatar",
        fullname: "$user.fullName",
        attachments: 1,
        CreatedAt: "$formattedCreatedAt",
      },
    },
  ]);

  if (!fetchedStory) {
    throw new ApiError(400, "No story found !!");
  }

  return res
    .status(200)
    .json(new ApiResponse(200, fetchedStory[0], "Story fetched successfully"));
});

const deleteStory = AsyncHandler(async (req, res) => {});

export {
  createNewPost,
  getAllPosts,
  getUserPostList,
  likePost,
  checkPostLiked,
  unlikePost,
  addComment,
  deleteComment,
  editComment,
  getAllComments,
  addStory,
  getAllStoriesList,
  getSingleStory,
};
