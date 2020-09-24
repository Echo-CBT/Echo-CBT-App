class ChatsModel{
  List<dynamic> chats;

  ChatsModel({
    this.chats
  });

  factory ChatsModel.fromJson(dynamic json){
    // print(json);
    // print(json.runtimeType);
    List<dynamic> chatsList=json.map((i)=>ChatModel.fromJson(i)).toList();
    return ChatsModel(
      chats: chatsList
    );
  }
}

class ChatModel{
  String uid;
  String name;
  String chatId;

  ChatModel({
    this.uid,
    this.name,
    this.chatId
  });

  factory ChatModel.fromJson(dynamic json){
    return ChatModel(
      uid: json["uid"],
      name: json["name"],
      chatId: json["chatId"]
    );
  }
}