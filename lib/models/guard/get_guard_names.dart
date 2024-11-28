class getGuards {
  bool? success;
  String? message;
  List<Data>? data;

  getGuards({this.success, this.message, this.data});

  getGuards.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? toGuardId;
  String? name;

  Data({this.toGuardId, this.name});

  Data.fromJson(Map<String, dynamic> json) {
    toGuardId = json['to_guard_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['to_guard_id'] = this.toGuardId;
    data['name'] = this.name;
    return data;
  }
}
