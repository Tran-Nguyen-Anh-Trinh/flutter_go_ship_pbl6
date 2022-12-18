class PhonePasswordRequest {
  String? phoneNumber;
  String? password;

  PhonePasswordRequest(this.phoneNumber, this.password);

  Map<String, dynamic> toJson() {
    return {
      'phone_number': phoneNumber,
      'password': password,
    };
  }
}