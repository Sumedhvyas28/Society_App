import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:society_app/models/user_model.dart';

part 'chat_participant_model.freezed.dart';
part 'chat_participant_model.g.dart';

@freezed
class ChatParticipantModel with _$ChatParticipantModel {
  factory ChatParticipantModel({
    required int id,
    @JsonKey(name: "chat_id") required int chatId,
    @JsonKey(name: "user_id") required int userId,
    required UserModel user,
  }) = _ChatParticipantModel;

  factory ChatParticipantModel.fromJson(Map<String, dynamic> json) =>
      _$ChatParticipantModelFromJson(json);
}
