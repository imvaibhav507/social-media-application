import mongoose, { Schema } from "mongoose";

const likeSchema = new Schema(
  {
    likedBy: {
      type: Schema.Types.ObjectId,
      ref: "User",
      unique: true,
    },

    postLiked: {
      type: Schema.Types.ObjectId,
      ref: "Post",
      unique: true,
    },

    commentLiked: {
      type: Schema.Types.ObjectId,
      ref: "Comment",
      unique: true,
    },
  },
  { timestamps: true }
);

export const Like = mongoose.model("Like", likeSchema);
