import mongoose, { Schema } from "mongoose";

const postSchema = new Schema(
  {
    postType: {
      type: String,
      required: true,
    },

    caption: {
      type: String,
      required: true,
    },

    attachments: [
      {
        type: String,
        required: true,
      },
    ],

    creator: {
      type: Schema.Types.ObjectId,
      ref: "User",
    },

    createdAt: {
      type: Date,
      expires: 30,
    },
  },
  { timestamps: true }
);

export const Post = mongoose.model("Post", postSchema);
