class getBuildingPeople {
  bool? success;
  List<Users>? users;

  getBuildingPeople({this.success, this.users});

  getBuildingPeople.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  int? userId;
  String? userName;
  String? apartmentNo;
  String? address;

  Users({this.userId, this.userName, this.apartmentNo, this.address});

  Users.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    apartmentNo = json['apartment_no'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['apartment_no'] = this.apartmentNo;
    data['address'] = this.address;
    return data;
  }
}
