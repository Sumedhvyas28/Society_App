class postGuardNote {
  String? message;
  Data? data;

  postGuardNote({this.message, this.data});

  postGuardNote.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? image;
  String? description;
  String? guard;
  String? time;
  int? sender;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data({
    this.name,
    this.image,
    this.description,
    this.guard,
    this.time,
    this.sender,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    description = json['description'];
    guard = json['guard'];
    time = json['time'];
    sender = json['sender'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = {};
    if (name != null) data['name'] = name!;
    if (image != null) data['image'] = image!;
    if (description != null) data['description'] = description!;
    if (guard != null) data['guard'] = guard!;
    if (time != null) data['time'] = time!;
    if (sender != null) data['sender'] = sender!.toString();
    if (updatedAt != null) data['updated_at'] = updatedAt!;
    if (createdAt != null) data['created_at'] = createdAt!;
    if (id != null) data['id'] = id!.toString();
    return data;
  }
}
