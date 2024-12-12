import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:society_app/models/chat_message_model.dart';
import 'package:society_app/models/chat_participant_model.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

@freezed
class ChatModel with _$ChatModel {
  factory ChatModel({
    required int id,
    String? name,
    @JsonKey(name: "is_private") required int isPrivate,
    @JsonKey(name: "created_at") required String createdAt,
    @JsonKey(name: "updated_at") required String updatedAt,
    @JsonKey(name: "last_message") ChatMessageModel? lastMessage,
    required List<ChatParticipantModel> participants,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
}
