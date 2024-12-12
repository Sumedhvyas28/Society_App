class postGuardMessage {
  String? message;
  Data? data;

  postGuardMessage({this.message, this.data});

  postGuardMessage.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? toGuardId;
  String? message;
  String? urgencyLevel;
  String? category;
  String? date;
  String? additionalNotes;
  Null? attachment;
  int? fromGuardId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.toGuardId,
      this.message,
      this.urgencyLevel,
      this.category,
      this.date,
      this.additionalNotes,
      this.attachment,
      this.fromGuardId,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    toGuardId = json['to_guard_id'];
    message = json['message'];
    urgencyLevel = json['urgency_level'];
    category = json['category'];
    date = json['date'];
    additionalNotes = json['additional_notes'];
    attachment = json['attachment'];
    fromGuardId = json['from_guard_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['to_guard_id'] = this.toGuardId;
    data['message'] = this.message;
    data['urgency_level'] = this.urgencyLevel;
    data['category'] = this.category;
    data['date'] = this.date;
    data['additional_notes'] = this.additionalNotes;
    data['attachment'] = this.attachment;
    data['from_guard_id'] = this.fromGuardId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
