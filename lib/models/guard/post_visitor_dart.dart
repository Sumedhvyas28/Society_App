class postVisitorData {
  bool? success;
  List<Data>? data;

  postVisitorData({this.success, this.data});

  postVisitorData.fromJson(Map<String, dynamic> json) {
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
  String? apartmentNo;
  String? address;
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
  String? userName;

  Data(
      {this.id,
      this.apartmentNo,
      this.address,
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
      this.userName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    apartmentNo = json['apartment_no'];
    address = json['address'];
    visitorType = json['visitor_type'];
    visitorName = json['visitor_name'];
    purposeOfVisit = json['purpose_of_visit'];
    contactNumber = json['contact_number'];
    visitorImage = json['visitor_image'];
    visitDate = json['visit_date'];
    expectedDuration = json['expected_duration'];
    additionalNotes = json['additional_notes'];
    attachment = json['attachment'];
    status = json['status'];
    commentMessage = json['comment_message'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['apartment_no'] = this.apartmentNo;
    data['address'] = this.address;
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
    data['user_name'] = this.userName;
    return data;
  }
}
