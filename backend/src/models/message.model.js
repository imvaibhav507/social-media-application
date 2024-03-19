import mongoose, { Schema } from "mongoose";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";

const messageSchema = new Schema(
  {
    content: {
      type: String,
    },

    attachments: [
      {
        public_id: {
          type: String,
          required: true,
        },
        url: {
          type: String,
          required: true,
        },
      },
    ],

    sender: {
      type: Schema.Types.ObjectId,
      ref: "ChatParticipant",
    },

    chatRoom: {
      type: Schema.Types.ObjectId,
      ref: "ChatRoom",
    },

    seen: {
      type: Boolean,
      default: false,
    },
  },
  { timestamps: true }
);

export const Message = mongoose.model("Message", messageSchema);
