import mongoose, { Schema } from "mongoose";

const commentSchema = new Schema(
  {
    post: {
      type: Schema.Types.ObjectId,
      ref: "Post",
    },

    content: {
      type: String,
      required: true,
    },

    commentedBy: {
      type: Schema.Types.ObjectId,
      ref: "User",
    },

    subComments: {
      type: Schema.Types.ObjectId,
      ref: "Comment",
    },
  },
  { timestamps: true }
);

export const Comment = mongoose.model("Comment", commentSchema);
