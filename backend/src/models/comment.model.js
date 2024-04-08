import mongoose, { Schema } from "mongoose";

const commentSchema = new Schema(
  {
    post: {
      type: Schema.Types.ObjectId,
      ref: "Post",
      unique: true,
    },

    content: {
      type: String,
      required: true,
    },

    commentedBy: {
      type: Schema.Types.ObjectId,
      ref: "User",
      unique: true,
    },

    subComments: {
      type: Schema.Types.ObjectId,
      ref: "Comment",
      unique: true,
    },
  },
  { timestamps: true }
);

export const Comment = mongoose.model("Comment", commentSchema);
