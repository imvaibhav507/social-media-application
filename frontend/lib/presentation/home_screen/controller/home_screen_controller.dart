import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/presentation/daily_new_page/controller/daily_new_controller.dart';
import 'package:vaibhav_s_application2/presentation/daily_new_page/models/comments_model.dart';
import 'package:vaibhav_s_application2/presentation/daily_new_page/models/like_model.dart';
import 'package:vaibhav_s_application2/presentation/daily_new_page/models/post_model.dart';
import 'package:vaibhav_s_application2/presentation/home_screen/controller/stories_controller.dart';
import 'package:vaibhav_s_application2/presentation/home_screen/models/logged_in_user_model.dart';
import 'package:vaibhav_s_application2/repositories/auth_repository/auth_repository.dart';
import 'package:vaibhav_s_application2/res/app_url/app_url.dart';
import '../../../core/app_export.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../models/home_screen_model.dart';
import '../models/stories_model.dart';

class HomeScreenController extends GetxController with GetSingleTickerProviderStateMixin{

  late Socket socket;
  String? userId;
  RxList<String?> onlineUsers = [''].obs;

  TextEditingController searchController = TextEditingController();

  AuthRepository _authRepository = AuthRepository();

  Rx<LoggedInUserModel> loggedInUserModelObj =
      LoggedInUserModel().obs;

  late TabController tabviewController =
  Get.put(TabController(vsync: this, length: 2));

  var storiesController = Get.put(StoriesController(StoriesListModel().obs));
  var postsController = Get.put(DailyNewController(PostsModel().obs, LikeModel().obs, CommentsModel().obs));

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getLoggedInUser();
    storiesController.getAllStories();
    postsController.getAllPosts();
  }

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
    socket.disconnect();
    socket.dispose();
  }

  // joinChatroom() {
  //   socket.emit("join chatroom", chatroomId);
  // }

  setOnlineUsers(List<dynamic> users) {
    onlineUsers.value = users
        .map((user) => user.toString())
        .toList();
  }

  Future<void> connectSocket() async{
    socket = io(
        AppUrl.hostUrl,
        OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
            .setQuery({
          'userId': userId,
          // 'chatroom': chatroomId,
        }).build());
    socket.connect();

    socket.onConnect((_) {
      socket.emit("user connected", userId);
    });

    socket.on("message sent", (data) {
      print(data);
    });

    socket.on("get online users", (users) {
      setOnlineUsers(users);
      print('Online users: ${onlineUsers}');
    });

    socket.onDisconnect((_) {
      print("socket disconnected");
    });
  }

  Future<void> getLoggedInUser() async {
    _authRepository.loggedInUser().then((value) async{
      final response = await ApiResponse.completed(value);
      print(response.data);
      final data = response.data as Map<String, dynamic>;
      loggedInUserModelObj.value = LoggedInUserModel.fromJson(data);
      userId = await loggedInUserModelObj.value.data?.sId;
      connectSocket();
    });
  }
}
