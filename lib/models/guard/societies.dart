class getSocieties {
  bool? success;
  List<Data>? data;

  getSocieties({this.success, this.data});

  getSocieties.fromJson(Map<String, dynamic> json) {
    success = json['success'];
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
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? title;
  List<Buildings>? buildings;

  Data({this.id, this.title, this.buildings});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['buildings'] != null) {
      buildings = <Buildings>[];
      json['buildings'].forEach((v) {
        buildings!.add(new Buildings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.buildings != null) {
      data['buildings'] = this.buildings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Buildings {
  int? buildingId;
  int? societyId;
  String? buildingName;

  Buildings({this.buildingId, this.societyId, this.buildingName});

  Buildings.fromJson(Map<String, dynamic> json) {
    buildingId = json['building_id'];
    societyId = json['society_id'];
    buildingName = json['building_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['building_id'] = this.buildingId;
    data['society_id'] = this.societyId;
    data['building_name'] = this.buildingName;
    return data;
  }
}
