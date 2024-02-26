import 'package:json_annotation/json_annotation.dart';

part 'push_message.g.dart';

@JsonSerializable()
class PushMessage {
  PushMessage(this.uri, this.type, this.title, this.body, this.contextId);

  factory PushMessage.fromJson(Map<String, dynamic> json) =>
      _$PushMessageFromJson(json);

  Map<String, dynamic> toJson() => _$PushMessageToJson(this);

  final String? uri;
  final String? type;
  final String? title;
  final String? body;
  final String? contextId;

  @override
  String toString() {
    return 'PushMessage{'
        'uri: $uri, '
        'type: $type, '
        'title: $title, '
        'body: $body, '
        'contextId: $contextId}';
  }
}
