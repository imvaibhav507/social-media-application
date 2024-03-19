import mongoose, { Schema } from "mongoose";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";

const chatParticipantSchema = new Schema(
  {
    chatee: {
      type: Schema.Types.ObjectId,
      ref: "User",
    },

    chatRoom: {
      type: Schema.Types.ObjectId,
      ref: "ChatRoom",
    },
  },
  { timestamps: true }
);

export const ChatParticipant = mongoose.model(
  "ChatParticipant",
  chatParticipantSchema
);
