class GuardMessages {
  dynamic? id;
  String? message;
  String? urgencyLevel;
  String? category;
  String? date;
  Null? additionalNotes;
  Null? attachment;
  String? createdAt;
  String? updatedAt;
  String? fromGuardName;
  String? toGuardName;

  GuardMessages(
      {this.id,
      this.message,
      this.urgencyLevel,
      this.category,
      this.date,
      this.additionalNotes,
      this.attachment,
      this.createdAt,
      this.updatedAt,
      this.fromGuardName,
      this.toGuardName});

  GuardMessages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    urgencyLevel = json['urgency_level'];
    category = json['category'];
    date = json['date'];
    additionalNotes = json['additional_notes'];
    attachment = json['attachment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fromGuardName = json['from_guard_name'];
    toGuardName = json['to_guard_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['urgency_level'] = this.urgencyLevel;
    data['category'] = this.category;
    data['date'] = this.date;
    data['additional_notes'] = this.additionalNotes;
    data['attachment'] = this.attachment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['from_guard_name'] = this.fromGuardName;
    data['to_guard_name'] = this.toGuardName;
    return data;
  }
}
