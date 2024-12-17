class getVisitorData {
  bool? success;
  List<Data>? data;

  getVisitorData({this.success, this.data});

  getVisitorData.fromJson(Map<String, dynamic> json) {
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
  String? visitorType;
  String? visitorName;
  String? purposeOfVisit;
  String? contactNumber;
  String? visitorImage;
  String? visitDate;
  String? expectedDuration;
  String? additionalNotes;
  String? attachment;
  String? status;
  String? commentMessage;
  String? apartmentNo;
  String? address;
  String? guardId;
  String? userName;
  String? buildingName;

  Data(
      {this.id,
      this.visitorType,
      this.visitorName,
      this.purposeOfVisit,
      this.contactNumber,
      this.visitorImage,
      this.visitDate,
      this.expectedDuration,
      this.additionalNotes,
      this.attachment,
      this.status,
      this.commentMessage,
      this.apartmentNo,
      this.address,
      this.guardId,
      this.userName,
      this.buildingName});

  // Data.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   visitorType = json['visitor_type'];
  //   visitorName = json['visitor_name'];
  //   purposeOfVisit = json['purpose_of_visit'];
  //   contactNumber = json['contact_number'];
  //   visitorImage = json['visitor_image'];
  //   visitDate = json['visit_date'];
  //   expectedDuration = json['expected_duration'];
  //   additionalNotes = json['additional_notes'];
  //   attachment = json['attachment'];
  //   status = json['status'];
  //   commentMessage = json['comment_message'];
  //   apartmentNo = json['apartment_no'];
  //   address = json['address'];
  //   guardId = json['guard_id'];
  //   userName = json['user_name'];
  //   buildingName = json['building_name'];
  // }
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int
        ? json['id']
        : int.tryParse(json['id']?.toString() ?? '');
    visitorType = json['visitor_type']?.toString();
    visitorName = json['visitor_name']?.toString();
    purposeOfVisit = json['purpose_of_visit']?.toString();
    contactNumber = json['contact_number']?.toString();
    visitorImage = json['visitor_image']?.toString();
    visitDate = json['visit_date']?.toString();
    expectedDuration = json['expected_duration']?.toString();
    additionalNotes = json['additional_notes']?.toString();
    attachment = json['attachment']?.toString();
    status = json['status']?.toString();
    commentMessage = json['comment_message']?.toString();
    apartmentNo = json['apartment_no']?.toString();
    address = json['address']?.toString();
    guardId = json['guard_id']?.toString();
    userName = json['user_name']?.toString();
    buildingName = json['building_name']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['visitor_type'] = this.visitorType;
    data['visitor_name'] = this.visitorName;
    data['purpose_of_visit'] = this.purposeOfVisit;
    data['contact_number'] = this.contactNumber;
    data['visitor_image'] = this.visitorImage;
    data['visit_date'] = this.visitDate;
    data['expected_duration'] = this.expectedDuration;
    data['additional_notes'] = this.additionalNotes;
    data['attachment'] = this.attachment;
    data['status'] = this.status;
    data['comment_message'] = this.commentMessage;
    data['apartment_no'] = this.apartmentNo;
    data['address'] = this.address;
    data['guard_id'] = this.guardId;
    data['user_name'] = this.userName;
    data['building_name'] = this.buildingName;
    return data;
  }
}
