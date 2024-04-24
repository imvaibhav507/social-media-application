import mongoose, { Schema } from "mongoose";

const followRequestSchema = new Schema(
  {
    requestedTo: {
      type: Schema.Types.ObjectId,
      ref: "User",
    },

    requestedBy: {
      type: Schema.Types.ObjectId,
      ref: "User",
    },
  },
  { timestamps: true }
);

export const FollowRequest = mongoose.model(
  "FollowRequest",
  followRequestSchema
);
