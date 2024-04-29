import 'package:vaibhav_s_application2/data/network/network_api_services.dart';
import 'package:vaibhav_s_application2/res/app_url/app_url.dart';

class PostsRepository{
  final _apiServices = NetworkApiServices();
  
  Future<dynamic> getAllPosts() async{
    dynamic response = await _apiServices.getApi(AppUrl.getAllPostsApi);
    return response;
  }

  Future<dynamic> getUserPostsList(String? userId) async{
    dynamic response = await _apiServices.getApi(AppUrl.getUserPostsListApi + '?userId=${userId}');
    return response;
  }

  Future<dynamic> likePost(String postId) async {
    dynamic response = await _apiServices.putApi(AppUrl.likePostApi + '?postId=${postId}',{});
    return response;
  }

  Future<dynamic> unlikePost(String postId) async {
    dynamic response = await _apiServices.deleteApi(AppUrl.unlikePostApi + '?postId=${postId}',{});
    return response;
  }

  Future<dynamic> getAllStories() async{
    dynamic response = await _apiServices.getApi(AppUrl.getAllStoriesApi);
    return response;
  }

  Future<dynamic> getSingleStory(String postId) async{
    dynamic response = await _apiServices.getApi(AppUrl.getSingleStoryApi + '?postId=${postId}');
    return response;
  }

  Future<dynamic> addStory(imageFiles, filename) async{
    dynamic response = await _apiServices.uploadImageApi(AppUrl.addStoryApi, imageFiles, filename);
    return response;
  }

  Future<dynamic> createPost(imageFiles, filename, String caption) async{
    dynamic response = await _apiServices.uploadImageApi(AppUrl.createPostApi + '?caption=${caption}', imageFiles, filename);
    return response;
  }

  Future<dynamic> getAllComments(String postId) async {
    dynamic response = await _apiServices.getApi(AppUrl.getAllCommentsApi + '?postId=${postId}');
    return response;
  }

  Future<dynamic> addComment(var data) async {
    dynamic response = await _apiServices.postApi(AppUrl.addCommentApi, data);
    return response;
  }
}