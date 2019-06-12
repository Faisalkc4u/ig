import 'dart:convert';
import 'package:http/http.dart' show Client;

class IGAPIModel {
  Client client = Client();
  String baseurl = "https://www.instagram.com/";
  String urlend = "/?__a=1";
  String username;
  String url;
  UserData user;
  IGAPIModel({this.username}) {
    this.url = baseurl + username + urlend;
  }
  Future<bool> getUserData() async {
    final response = await client.get(
      url,
    );
    try {
      if (response.statusCode == 200) {
        this.user = UserData(response.body);
      }
      return response.statusCode == 200 ? true : false;
    } catch (e) {
      return false;
    }
  }
}

class UserData {
  bool blocked_by_viewer;
  String full_name, username, profile_pic_url, profile_pic_url_hd, biography;
  String id;
  List<Post> listofPost;
  int follwing, followers, totalPost;
  UserData(snapshot) {
    final Map<dynamic, dynamic> _userjsondata = jsonDecode(snapshot);
    final Map<dynamic, dynamic> user = _userjsondata['graphql']['user'];
    this.blocked_by_viewer = user['blocked_by_viewer'];
    this.full_name = user['full_name'];
    this.id = user['id'];
    this.totalPost = user['edge_owner_to_timeline_media']['count'];
    this.followers = user['edge_followed_by']['count'];
    this.follwing = user['edge_follow']['count'];
    this.biography = user['biography'];
    this.profile_pic_url = user['profile_pic_url'];
    this.profile_pic_url_hd = user['profile_pic_url_hd'];
    if (totalPost > 0) {
      listofPost = [];
      List<dynamic> _post = user['edge_owner_to_timeline_media']['edges'];
      for (var item in _post) {
        listofPost.add(Post(item['node']));
      }
    }
  }
}

class Post {
  String thumbnail_src,display_url;
  bool is_video;
  Post(Map<dynamic, dynamic> post) {
    this.thumbnail_src = post['thumbnail_src'];
    this.display_url = post['display_url'];
  }
}
