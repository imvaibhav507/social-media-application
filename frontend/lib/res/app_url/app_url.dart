class AppUrl {
  static const String hostUrl = 'http://192.168.1.7:8080';
  static const String baseUrl = 'http://192.168.1.7:8080/api/v1';

  static const String signupApi = '$baseUrl/users/register';
  static const String loginApi = '$baseUrl/users/login';
  static const String uploadImageApi = '$baseUrl/users/update-avatar';
  static const String addGenderApi = '$baseUrl/users/add-gender';
  static const String getLoggedInUserApi = '$baseUrl/users/get-user';
  static const String followUserApi = '$baseUrl/users/follow/';
  static const String unfollowUserApi = '$baseUrl/users/follow/';
  static const String getUserProfileApi = '$baseUrl/users/get-user-profile/';
  static const String searchUserProfileApi = '$baseUrl/users/search-user-profile/';
  static const String followRequestApi = '$baseUrl/users/follow-request/';

  static const String getChatroomListApi = '$baseUrl/chatroom/chatrooms';
  static const String getSingleChatroomListItemApi = '$baseUrl/chatroom/single-chatroom';
  static const String getChatroomDetails = '$baseUrl/chatroom/';
  static const String getPersonalChatDetails = '$baseUrl/chatroom/personal-chat/';
  static const String createPersonalChat = '$baseUrl/chatroom/new-personal-chat/';
  static const String deleteChatroom = '$baseUrl/chatroom/';
  static const String leaveChatroom = '$baseUrl/chatroom/leave-chatroom/';
  static const String renameChatroom = '$baseUrl/chatroom/';

  static const String getMessagesListApi = '$baseUrl/chatroom/get-messages/';
  static const String sendMessageApi = '$baseUrl/chatroom/send-message';
  static const String getSearchResultApi = '$baseUrl/chatroom/search-chatrooms';
  static const String addMembersToChatroomApi = '$baseUrl/chatroom/add-participants';

  static const String getSearchedUsersApi = '$baseUrl/users/search-users/';
  static const String getAllPostsApi = '$baseUrl/post/get-posts';
  static const String getUserPostsListApi = '$baseUrl/post/user-posts-list/';
  static const String likePostApi = '$baseUrl/post/like-post/';
  static const String unlikePostApi = '$baseUrl/post/unlike-post/';
  static const String getAllStoriesApi = '$baseUrl/post/get-stories';
  static const String getSingleStoryApi = '$baseUrl/post/get-single-story/';
  static const String addStoryApi = '$baseUrl/post/add-story';

  static const String getAllCommentsApi = '$baseUrl/post/all-comments/';
  static const String addCommentApi = '$baseUrl/post/add-comment';
  static const String deleteCommentApi = '$baseUrl/post/delete-comment/';
  static const String editCommentApi = '$baseUrl/post/edit-comment';
}