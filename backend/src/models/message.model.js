import mongoose, { Schema } from "mongoose";

const messageSchema = new Schema(
  {
    content: {
      type: String,
      default: "",
    },

    attachments: [
      {
        url: {
          type: String,
          required: true,
        },
      },
    ],

    sender: {
      type: Schema.Types.ObjectId,
      ref: "User",
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
