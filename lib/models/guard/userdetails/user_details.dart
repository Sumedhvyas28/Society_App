class getUserDetails {
  bool? success;
  Data? data;

  getUserDetails({this.success, this.data});

  getUserDetails.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;
  UserDetail? userDetail;

  Data({this.user, this.userDetail});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    userDetail = json['user_detail'] != null
        ? new UserDetail.fromJson(json['user_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.userDetail != null) {
      data['user_detail'] = this.userDetail!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? role;

  User({this.id, this.name, this.email, this.role});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['role'] = this.role;
    return data;
  }
}

class UserDetail {
  String? description;
  String? societyName;
  Null? buildingName;
  Null? apartmentNo;
  Null? address;
  String? phoneNumber;
  Null? service;
  Null? profileImage;
  Null? image;
  Null? birthDate;
  Null? age;
  String? gender;
  Null? hobbies;
  Null? jobTitle;
  Null? languagesSpoken;

  UserDetail(
      {this.description,
      this.societyName,
      this.buildingName,
      this.apartmentNo,
      this.address,
      this.phoneNumber,
      this.service,
      this.profileImage,
      this.image,
      this.birthDate,
      this.age,
      this.gender,
      this.hobbies,
      this.jobTitle,
      this.languagesSpoken});

  UserDetail.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    societyName = json['society_name'];
    buildingName = json['building_name'];
    apartmentNo = json['apartment_no'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    service = json['service'];
    profileImage = json['profile_image'];
    image = json['image'];
    birthDate = json['birth_date'];
    age = json['age'];
    gender = json['gender'];
    hobbies = json['hobbies'];
    jobTitle = json['job_title'];
    languagesSpoken = json['languages_spoken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['society_name'] = this.societyName;
    data['building_name'] = this.buildingName;
    data['apartment_no'] = this.apartmentNo;
    data['address'] = this.address;
    data['phone_number'] = this.phoneNumber;
    data['service'] = this.service;
    data['profile_image'] = this.profileImage;
    data['image'] = this.image;
    data['birth_date'] = this.birthDate;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['hobbies'] = this.hobbies;
    data['job_title'] = this.jobTitle;
    data['languages_spoken'] = this.languagesSpoken;
    return data;
  }
}
