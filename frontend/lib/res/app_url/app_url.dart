class AppUrl {
  static const String hostUrl = 'https://social-media-application-9ykb.onrender.com';
  static const String baseUrl = 'https://social-media-application-9ykb.onrender.com/api/v1';

  static const String signupApi = '$baseUrl/users/register';
  static const String loginApi = '$baseUrl/users/login';
  static const String uploadImageApi = '$baseUrl/users/update-avatar';
  static const String addGenderApi = '$baseUrl/users/add-gender';

  static const String getChatroomListApi = '$baseUrl/chatroom/chatrooms';
  static const String getSingleChatroomListItemApi = '$baseUrl/chatroom/single-chatroom';
  static const String getChatroomDetails = '$baseUrl/chatroom/';

  static const String getMessagesListApi = '$baseUrl/chatroom/get-messages/';
  static const String sendMessageApi = '$baseUrl/chatroom/send-message';
  static const String getSearchResultApi = '$baseUrl/chatroom/search-chatrooms';
  static const String addMembersToChatroomApi = '$baseUrl/chatroom/add-participants';

  static const String getSearchedUsersApi = '$baseUrl/users/search-users/';

}