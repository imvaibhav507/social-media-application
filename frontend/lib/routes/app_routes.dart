import 'package:get/get.dart';
import 'package:vaibhav_s_application2/presentation/add_avatar_screen/add_avatar_screen.dart';
import 'package:vaibhav_s_application2/presentation/add_avatar_screen/binding/add_avatar_binding.dart';
import 'package:vaibhav_s_application2/presentation/add_member_screen/add_member_screen.dart';
import 'package:vaibhav_s_application2/presentation/add_member_screen/binding/add_member_binding.dart';
import 'package:vaibhav_s_application2/presentation/add_story_page/add_story_page.dart';
import 'package:vaibhav_s_application2/presentation/add_story_page/binding/add_story_bindings.dart';
import 'package:vaibhav_s_application2/presentation/capture_image_screen/binding/capture-image_bindings.dart';
import 'package:vaibhav_s_application2/presentation/capture_image_screen/capture_image_page.dart';
import 'package:vaibhav_s_application2/presentation/chat_screen/personalchat_screen.dart';
import 'package:vaibhav_s_application2/presentation/container_screen/binding/container_binding.dart';
import 'package:vaibhav_s_application2/presentation/create_post_page/binding/create_post_binding.dart';
import 'package:vaibhav_s_application2/presentation/create_post_page/create_post_page.dart';
import 'package:vaibhav_s_application2/presentation/follow_requests_page/follow_requests_page.dart';
import 'package:vaibhav_s_application2/presentation/follows_page/followers_list_model/followers_list_model.dart';
import 'package:vaibhav_s_application2/presentation/follows_page/followings_list_page.dart';
import 'package:vaibhav_s_application2/presentation/messages_page/bindings/chat_search_binding.dart';
import 'package:vaibhav_s_application2/presentation/messages_page/chats_search_screen.dart';
import 'package:vaibhav_s_application2/presentation/messages_page/messages_page.dart';
import 'package:vaibhav_s_application2/presentation/notifications_page/notifications_page.dart';
import 'package:vaibhav_s_application2/presentation/profile_page/profile_page.dart';
import 'package:vaibhav_s_application2/presentation/searched_profile_page/searched_profile_page.dart';
import 'package:vaibhav_s_application2/presentation/stories_screen/binding/story_binding.dart';
import 'package:vaibhav_s_application2/presentation/stories_screen/stories_screen.dart';
import '../presentation/chat_screen/chatroom_screen.dart';
import '../presentation/follows_page/followers_list_page.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/splash_screen/binding/splash_binding.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/login_screen/binding/login_binding.dart';
import '../presentation/log_in_screen/log_in_screen.dart';
import '../presentation/log_in_screen/binding/log_in_binding.dart';
import '../presentation/forgot_password_screen/forgot_password_screen.dart';
import '../presentation/forgot_password_screen/binding/forgot_password_binding.dart';
import '../presentation/sign_up_screen/sign_up_screen.dart';
import '../presentation/sign_up_screen/binding/sign_up_binding.dart';
import '../presentation/notification_screen/notification_screen.dart';
import '../presentation/notification_screen/binding/notification_binding.dart';
import '../presentation/invite_friends_screen/invite_friends_screen.dart';
import '../presentation/invite_friends_screen/binding/invite_friends_binding.dart';
import '../presentation/stories_container_screen/stories_container_screen.dart';
import '../presentation/stories_container_screen/binding/stories_container_binding.dart';
import '../presentation/stories_and_tweets_screen/stories_and_tweets_screen.dart';
import '../presentation/stories_and_tweets_screen/binding/stories_and_tweets_binding.dart';
import '../presentation/search_screen/search_screen.dart';
import '../presentation/search_screen/binding/search_binding.dart';
import '../presentation/live_screen/live_screen.dart';
import '../presentation/live_screen/binding/live_binding.dart';
import '../presentation/page_view_screen/page_view_screen.dart';
import '../presentation/page_view_screen/binding/page_view_binding.dart';
import '../presentation/account_view_screen/account_view_screen.dart';
import '../presentation/account_view_screen/binding/account_view_binding.dart';
import '../presentation/account_details_screen/account_details_screen.dart';
import '../presentation/account_details_screen/binding/account_details_binding.dart';
import '../presentation/chat_screen/binding/chat_binding.dart';
import '../presentation/friends_screen/friends_screen.dart';
import '../presentation/friends_screen/binding/friends_binding.dart';
import '../presentation/detailed_profile_screen/detailed_profile_screen.dart';
import '../presentation/detailed_profile_screen/binding/detailed_profile_binding.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/app_navigation_screen/binding/app_navigation_binding.dart';
import '../presentation/container_screen/container_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String loginScreen = '/login_screen';

  static const String logInScreen = '/log_in_screen';

  static const String forgotPasswordScreen = '/forgot_password_screen';

  static const String signUpScreen = '/sign_up_screen';

  static const String addAvatarScreen = '/add_avatar_screen';

  static const String notificationScreen = '/notification_screen';

  static const String inviteFriendsScreen = '/invite_friends_screen';

  static const String discoverPage = '/discover_page';

  static const String dailyNewPage = '/daily_new_page';

  static const String dailyNewTabContainerScreen =
      '/daily_new_tab_container_screen';

  static const String trendingPage = '/trending_page';

  static const String trendingTabContainerScreen =
      '/trending_tab_container_screen';

  static const String storiesPage = '/stories_page';

  static const String storiesContainerScreen = '/stories_container_screen';

  static const String trendingPostsPage = '/trending_posts_page';

  static const String trendingPostsTabContainerScreen =
      '/trending_posts_tab_container_screen';

  static const String storiesAndTweetsScreen = '/stories_and_tweets_screen';

  static const String searchScreen = '/search_screen';

  static const String liveScreen = '/live_screen';

  static const String storyScreen = '/for_you_screen';

  static const String pageViewScreen = '/page_view_screen';

  static const String commentsScreen = '/comments_screen';

  static const String accountViewScreen = '/account_view_screen';

  static const String accountDetailsScreen = '/account_details_screen';

  static const String messagesPage = '/messages_page';

  static const String chatroomScreen = '/chat_screen';

  static const String personalChatScreen = '/personal_chat_screen';

  static const String friendsScreen = '/friends_screen';

  static const String notificationsPage = '/notifications_page';

  static const String profilePage = '/profile_page';

  static const String detailedProfileScreen = '/detailed_profile_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';

  static const String containerScreen = '/container_screen';

  static const String homeScreen = '/home_screen';

  static const String chatsSearchScreen = '/chats_search_screen';

  static const String addMembersScreen = '/chat_add_member';

  static const String createPostPage = '/create_post_page';

  static const String addStoryScreen = '/add_story_screen';

  static const String captureImageScreen = '/capture_image_screen';

  static const String searchedProfileScreen = '/searched_profile_screen';

  static const String followRequestsPage = '/follow_requests_page';

  static const String followingsPage = '/followings_page';

  static const String followersPage = '/followers_page';

  static List<GetPage> pages = [
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(),
      bindings: [
        SplashBinding(),
      ],
    ),

    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
      bindings: [
        LoginBinding(),
      ],
    ),
    GetPage(
      name: logInScreen,
      page: () => LogInScreen(),
      bindings: [
        LogInBinding(),
      ],
    ),
    GetPage(
      name: forgotPasswordScreen,
      page: () => ForgotPasswordScreen(),
      bindings: [
        ForgotPasswordBinding(),
      ],
    ),
    GetPage(
      name: signUpScreen,
      page: () => SignUpScreen(),
      bindings: [
        SignUpBinding(),
      ],
    ),
    GetPage(
        name: addAvatarScreen,
        page: () => AddAvatarScreen(),
      bindings: [
        AddAvatarBinding()
      ]
    ),
    GetPage(
      name: notificationScreen,
      page: () => NotificationScreen(),
      bindings: [
        NotificationBinding(),
      ],
    ),
    GetPage(
      name: containerScreen,
      page: () => ContainerScreen(),
      bindings: [
        ContainerBinding(),
      ],
    ),
    GetPage(
      name: inviteFriendsScreen,
      page: () => InviteFriendsScreen(),
      bindings: [
        InviteFriendsBinding(),
      ],
    ),
    GetPage(
      name: storiesContainerScreen,
      page: () => StoriesContainerScreen(),
      bindings: [
        StoriesContainerBinding(),
      ],
    ),
    GetPage(
      name: storiesAndTweetsScreen,
      page: () => StoriesAndTweetsScreen(),
      bindings: [
        StoriesAndTweetsBinding(),
      ],
    ),
    GetPage(
      name: searchScreen,
      page: () => SearchScreen(),
      bindings: [
        SearchBinding(),
      ],
    ),
    GetPage(
      name: liveScreen,
      page: () => LiveScreen(),
      bindings: [
        LiveBinding(),
      ],
    ),
    GetPage(
      name: storyScreen,
      page: () => StoryScreen(),
      bindings: [
        StoryBinding(),
      ],
    ),
    GetPage(
      name: pageViewScreen,
      page: () => PageViewScreen(),
      bindings: [
        PageViewBinding(),
      ],
    ),
    GetPage(
      name: accountViewScreen,
      page: () => AccountViewScreen(),
      bindings: [
        AccountViewBinding(),
      ],
    ),
    GetPage(
      name: accountDetailsScreen,
      page: () => AccountDetailsScreen(),
      bindings: [
        AccountDetailsBinding(),
      ],
    ),

    GetPage(
      name: friendsScreen,
      page: () => FriendsScreen(),
      bindings: [
        FriendsBinding(),
      ],
    ),
    GetPage(
      name: detailedProfileScreen,
      page: () => DetailedProfileScreen(),
      bindings: [
        DetailedProfileBinding(),
      ],
    ),
    GetPage(
      name: appNavigationScreen,
      page: () => AppNavigationScreen(),
      bindings: [
        AppNavigationBinding(),
      ],
    ),
    GetPage(
      name: initialRoute,
      page: () => SplashScreen(),
      bindings: [
        SplashBinding(),
      ],
    ),

    GetPage(
        name: chatroomScreen,
        page: () => ChatroomScreen(),
      bindings: [ChatBinding()]
    ),

    GetPage(
        name: personalChatScreen,
        page: () => PersonalChatScreen(),
      bindings: [ChatBinding()]
    ),

    GetPage(
        name: chatsSearchScreen,
        page: () => ChatsSearchScreen(),
      bindings: [ChatsSearchBinding()]
    ),

    GetPage(
        name: addMembersScreen,
        page: () => AddMemberScreen(),
      bindings: [AddMemberBinding()]
    ),

    GetPage(
        name: createPostPage,
        page: () => CreatePostPage(),
      bindings: [CreatePostBinding()],
    ),

    GetPage(
        name: addStoryScreen,
        page: () => AddStoryScreen(),
      bindings: [AddStoryBinding()],
    ),

    GetPage(
        name: captureImageScreen,
        page: () => CaptureImageScreen(),
      bindings: [CaptureImageBinding()],
    ),
    GetPage(name: followingsPage, page: () => FollowingsPage()),
    GetPage(name: followersPage, page: () => FollowersPage()),
    GetPage(name: followRequestsPage, page: () => FollowRequestsPage()),
    GetPage(name: messagesPage, page: () => MessagesPage()),
    GetPage(name: searchedProfileScreen, page: () => SearchedProfilePage()),
    GetPage(name: notificationsPage, page: () => NotificationsPage()),
    GetPage(name: profilePage, page: () => ProfilePage()),

  ];


}
