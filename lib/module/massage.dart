class MassageModel {
  late String senduid;
  late String receiveid;
  late String text;
  late String datetime;


  MassageModel({
    required this.senduid,
    required this.receiveid,
    required this.text,
    required this.datetime,

  });

  MassageModel.fromJson(Map<String, dynamic>? json) {
    senduid = json!['senduid'];
    receiveid = json['receiveid'];
    text = json['text'];
    datetime = json['datetime'];

  }

  Map<String, dynamic> toMap() {
    return {
      'senduid': senduid,
      'receiveid': receiveid,
      'text': text,
      'datetime':datetime,

    };
  }
}
