import 'package:vaibhav_s_application2/presentation/chat_screen/controller/chat_controller.dart';
import 'package:get/get.dart';
import 'package:vaibhav_s_application2/presentation/chat_screen/models/chat_model.dart';
import 'package:vaibhav_s_application2/presentation/chat_screen/models/chatroom_details_model.dart';

/// A binding class for the ChatScreen.
///
/// This class ensures that the ChatController is created when the
/// ChatScreen is first loaded.
class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatController(
        ChatScreenModel().obs,
        ChatroomDetailsModel().obs,
      <ChatModel>[].obs
    )
    );
  }
}
