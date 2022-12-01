class ChangePasswordRequest {
  String? oldPassword;
  String? newPassword;
  String? confirmewPassword;

  ChangePasswordRequest(
    {
    this.oldPassword,
    this.newPassword,
    this.confirmewPassword,
    }
  );

  Map<String, dynamic> toJson() {
    return {
      'old_password': oldPassword,
      'new_password': newPassword,
      'repeat_password': confirmewPassword,
    };
  }
}
