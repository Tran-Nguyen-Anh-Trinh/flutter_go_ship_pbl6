class RegisterRequest {
  String? phoneNumber;
  String? password;
  int? role;
  String? verificationId;

  RegisterRequest(this.phoneNumber, this.password, this.role, {this.verificationId});

  Map<String, dynamic> toJson() {
    return {
      'phone_number': phoneNumber,
      'password': password,
      'role': role,
    };
  }
}
