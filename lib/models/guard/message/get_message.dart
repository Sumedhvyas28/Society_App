class GuardMessages {
  int? id;
  String? message;
  String? urgencyLevel;
  String? category;
  String? date;
  String? additionalNotes;
  String? attachment;
  String? createdAt;
  String? updatedAt;
  String? fromGuardName;
  String? toGuardName;

  GuardMessages({
    this.id,
    this.message,
    this.urgencyLevel,
    this.category,
    this.date,
    this.additionalNotes,
    this.attachment,
    this.createdAt,
    this.updatedAt,
    this.fromGuardName,
    this.toGuardName,
  });

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
    return {
      'id': id,
      'message': message,
      'urgency_level': urgencyLevel,
      'category': category,
      'date': date,
      'additional_notes': additionalNotes,
      'attachment': attachment,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'from_guard_name': fromGuardName,
      'to_guard_name': toGuardName,
    };
  }
}
