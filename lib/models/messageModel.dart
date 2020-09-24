class MessagesModel{
  List<dynamic> messages;

  MessagesModel({
    this.messages
  });

  factory MessagesModel.fromJson(dynamic json){
    // List<dynamic> messageList=json.map((i)=>MessageModel.fromJson(i)).toList();
    // return MessagesModel(
    //   messages: messageList
    // );
  }
}

class MessageModel{
   
}