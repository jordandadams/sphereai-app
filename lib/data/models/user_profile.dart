class UserProfile {
  String? id;
  String? email;
  String? password;
  String fullname;
  String phone;
  String dob;
  bool? isVerified;
  bool? isProMember;

  UserProfile({
      this.id,
      this.email,
      this.password,
      required this.fullname,
      required this.phone,
      required this.dob,
      this.isVerified,
      this.isProMember
  });

  UserProfile.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        email = json['email'] as String?,
        password = json['password'] as String?,
        fullname = (json['fullname'] as String?) ?? '',
        phone = (json['phone'] as String?) ?? '',
        dob = (json['dob'] as String?) ?? '',
        isVerified = json['isVerified'] as bool?,
        isProMember = json['isVerified'] as bool?;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['email'] = this.email;
    data['password'] = this.password;
    data['fullname'] = this.fullname;
    data['phone'] = this.phone;
    data['dob'] = this.dob;
    data['isVerified'] = this.isVerified;
    data['isProMember'] = this.isProMember;
    return data;
  }

}
