class AppUrl {
  static const String hostUrl = 'http://192.168.1.3:8080';
  static const String baseUrl = 'http://192.168.1.3:8080/api/v1';

  static const String signupApi = '$baseUrl/users/register';
  static const String loginApi = '$baseUrl/users/login';
  static const String uploadImageApi = '$baseUrl/users/update-avatar';
  static const String addGenderApi = '$baseUrl/users/add-gender';
  static const String getLoggedInUserApi = '$baseUrl/users/get-user';

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
  static const String likePostApi = '$baseUrl/post/like-post/';
  static const String unlikePostApi = '$baseUrl/post/unlike-post/';
  static const String getAllCommentsApi = '$baseUrl/post/all-comments/';
  static const String addCommentApi = '$baseUrl/post/add-comment';
  static const String deleteCommentApi = '$baseUrl/post/delete-comment/';
  static const String editCommentApi = '$baseUrl/post/edit-comment';
}