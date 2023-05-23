class ApiMessage {
  List<Messages>? messages;

  ApiMessage({
    this.messages,
  });

  ApiMessage.fromJson(dynamic json) {
    if (json['messages'] != null) {
      messages = [];
      json['messages'].forEach((v) {
        messages?.add(Messages.fromJson(v));
      });
    }
  }
}

class Messages {
  String? id;
  String? message;

  Messages({
    this.id,
    this.message,
  });

  Messages.fromJson(dynamic json) {
    id = json['id'] as String?;
    message = json['message'] as String?;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['message'] = message;
    return map;
  }
}
