// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatModelImpl _$$ChatModelImplFromJson(Map<String, dynamic> json) =>
    _$ChatModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      isPrivate: (json['is_private'] as num).toInt(),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      lastMessage: json['last_message'] == null
          ? null
          : ChatMessageModel.fromJson(
              json['last_message'] as Map<String, dynamic>),
      participants: (json['participants'] as List<dynamic>)
          .map((e) => ChatParticipantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ChatModelImplToJson(_$ChatModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'is_private': instance.isPrivate,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'last_message': instance.lastMessage,
      'participants': instance.participants,
    };
