class AppUrl {
  static const String hostUrl = 'http://192.168.1.7:8080';
  static const String baseUrl = 'http://192.168.1.7:8080/api/v1';

  static const String signupApi = '$baseUrl/users/register';
  static const String loginApi = '$baseUrl/users/login';
  static const String uploadImageApi = '$baseUrl/users/update-avatar';
  static const String addGenderApi = '$baseUrl/users/add-gender';

  static const String getChatroomListApi = '$baseUrl/chatroom/chatrooms';
  static const String getSingleChatroomListItemApi = '$baseUrl/chatroom/single-chatroom';
  static const String getChatroomDetails = '$baseUrl/chatroom/';
  static const String deleteChatroom = '$baseUrl/chatroom/';
  static const String leaveChatroom = '$baseUrl/chatroom/leave-chatroom/';
  static const String renameChatroom = '$baseUrl/chatroom/';

  static const String getMessagesListApi = '$baseUrl/chatroom/get-messages/';
  static const String sendMessageApi = '$baseUrl/chatroom/send-message';
  static const String getSearchResultApi = '$baseUrl/chatroom/search-chatrooms';
  static const String addMembersToChatroomApi = '$baseUrl/chatroom/add-participants';

  static const String getSearchedUsersApi = '$baseUrl/users/search-users/';

  static const String getAllPostsApi = '$baseUrl/post/get-posts';

}