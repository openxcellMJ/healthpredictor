class UserDetails {
  String? sId;
  String? fullName;
  String? email;
  String? countryCode;
  String? phoneNumber;
  String? status;
  String? profilePicture;

  UserDetails(
      {this.sId,
        this.fullName,
        this.email,
        this.countryCode,
        this.phoneNumber,
        this.profilePicture,
        this.status});

  UserDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    status = json['status'];
    profilePicture = json['profilePicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['countryCode'] = this.countryCode;
    data['phoneNumber'] = this.phoneNumber;
    data['status'] = this.status;
    data['profilePicture'] = this.profilePicture;
    return data;
  }
}