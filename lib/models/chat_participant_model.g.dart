// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_participant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatParticipantModelImpl _$$ChatParticipantModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatParticipantModelImpl(
      id: (json['id'] as num).toInt(),
      chatId: (json['chat_id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ChatParticipantModelImplToJson(
        _$ChatParticipantModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chat_id': instance.chatId,
      'user_id': instance.userId,
      'user': instance.user,
    };
