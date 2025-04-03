import 'package:raxaadmin/utils/db_helper.dart';

class UserModel {
  String? userId;
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? email;
  bool? isAdmin;
  bool? infoRequired;
  int? credit;
  String? gender;
  String? profile;
  String? authToken;
  String? googleId;
  String? loginVia;
  int? creditRs;

  UserModel(
      {this.userId = "",
      this.firstName = "",
      this.lastName = "",
      this.mobileNumber = "",
      this.email = "",
      this.isAdmin,
      this.infoRequired,
      this.credit = 0,
      this.gender = "male",
      this.profile = "",
      this.authToken = "",
      this.googleId = "",
      this.loginVia = "email",
      this.creditRs = 0});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      userId: json['_id'] ?? json['user_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      mobileNumber: json['mobile_number'],
      email: json['email'],
      isAdmin: (json['isAdmin'] == 1 || json['isAdmin'] == true) ? true : false,
      infoRequired:
          (json['info_required'] == 1 || json['info_required'] == true)
              ? true
              : false,
      credit: json['credit'],
      gender: json['gender'],
      profile: json['profile'],
      authToken: json['authToken'],
      googleId: json['google_id'],
      creditRs: json['per_rs_credit'],
      loginVia: json['login_via']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[DBHelper.col_user_id] = userId;
    data[DBHelper.col_user_fname] = firstName;
    data[DBHelper.col_user_lname] = lastName;
    data[DBHelper.col_user_number] = mobileNumber;
    data[DBHelper.col_user_email] = email;
    data[DBHelper.col_user_admin] = (isAdmin == true) ? 1 : 0;
    data[DBHelper.col_user_info_required] = (infoRequired == true) ? 1 : 0;
    data[DBHelper.col_user_credit] = credit;
    data[DBHelper.col_user_gender] = gender;
    data[DBHelper.col_user_profile] = profile;
    data[DBHelper.col_user_token] = authToken;
    data[DBHelper.col_user_gmailid] = googleId;
    data[DBHelper.col_user_credit_per_rs] = creditRs;
    data[DBHelper.col_user_loginvia] = loginVia;
    return data;
  }

  @override
  String toString() {
    return "(userId=$userId, "
        "firstName=$firstName, "
        "lastName=$lastName, "
        "mobileNumber=$mobileNumber, "
        "email=$email, "
        "isAdmin=$isAdmin, "
        "infoRequired=$infoRequired, "
        "credit=$credit, "
        "gender=$gender, "
        "profile=$profile, "
        "authToken=$authToken, "
        "googleId=$googleId, "
        "creditPerRs=$creditRs, "
        "loginVia=$loginVia)";
  }
}
