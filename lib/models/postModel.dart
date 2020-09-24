class PostsModel{
  List<dynamic> posts;

  PostsModel({this.posts});

  factory PostsModel.fromJson(dynamic json){
    List<dynamic> postList=json.map((i)=>PostModel.fromJson(i)).toList();
    return PostsModel(
      posts: postList
    );
  }
}

class PostModel{
  String messageId;
  bool isAno;
  String description;
  String timeStamp;
  String title;
  String uid;
  String name;

  PostModel({
    this.messageId,
    this.isAno,
    this.description,
    this.timeStamp,
    this.title,
    this.uid,
    this.name
  });

  factory PostModel.fromJson(dynamic json){
    return PostModel(
      messageId: json["message_id"],
      isAno: json["isAno"],
      description: json["desc"],
      timeStamp: json["timeStamp"],
      title: json["title"],
      uid: json["uid"],
      name: json["name"]
    );
  }
}