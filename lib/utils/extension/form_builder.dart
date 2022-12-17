import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

typedef MyFormFieldState = FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>;

enum FormFieldType {
  name,
  phone,
  password,
  confirmPassword,
  newPassword,
  oldPassword,
  memo,
  detailOrder,
  noteOrder,
  messagesDefault,
}

extension FormFieldTypeExtension on FormFieldType {
  String get labelText {
    switch (this) {
      case FormFieldType.phone:
        return 'Số điện thoại';
      case FormFieldType.name:
        return 'Họ và tên';
      case FormFieldType.password:
        return 'Mật khẩu';
      case FormFieldType.confirmPassword:
        return 'Xác nhận mật khẩu';
      case FormFieldType.newPassword:
        return 'Mật khẩu mới';
      case FormFieldType.oldPassword:
        return 'Mật khẩu hiện tại';
      case FormFieldType.memo:
        return 'Mô tả địa chỉ';
      case FormFieldType.detailOrder:
        return 'Chi tiết đơn hàng';
      case FormFieldType.noteOrder:
        return 'Lưu ý đến Shipper';
      case FormFieldType.messagesDefault:
        return 'Nhập tin nhắn';
      default:
        return '';
    }
  }

  String get hintText {
    switch (this) {
      case FormFieldType.phone:
        return '099-9999-999';
      default:
        return '';
    }
  }

  TextInputType get keyboardType {
    switch (this) {
      case FormFieldType.phone:
        return TextInputType.phone;
      case FormFieldType.memo:
        return TextInputType.multiline;
      case FormFieldType.detailOrder:
        return TextInputType.multiline;
      case FormFieldType.noteOrder:
        return TextInputType.multiline;
      case FormFieldType.messagesDefault:
        return TextInputType.multiline;
      default:
        return TextInputType.text;
    }
  }

  MyFormFieldState field(FormBuilderState formBuilderState) {
    final field = formBuilderState.fields[name];
    if (field == null) {
      throw Exception('Cannot detect state of form key');
    }
    return field;
  }

  FormFieldValidator<String?>? validator() {
    List<FormFieldValidator<String?>> validators = [];
    switch (this) {
      case FormFieldType.phone:
        validators = [
          FormBuilderValidators.required(errorText: 'Không được để trống số điện thoại'),
          FormBuilderValidators.integer(errorText: 'Số điện thoại bao gồm các chữ số'),
          FormBuilderValidators.compose(
            [
              (val) {
                final validNumber = RegExp(r'^[+|0]{1}[0-9]{9,11}$');
                return validNumber.hasMatch(val.toString().trim()) ? null : "Vui lòng nhập vào số điện thoại của bạn";
              },
            ],
          ),
        ];
        break;
      case FormFieldType.name:
        validators = [
          FormBuilderValidators.required(errorText: 'Không được để trống họ và tên'),
        ];
        break;
      case FormFieldType.password:
        validators = [
          FormBuilderValidators.required(errorText: 'Không được để trống mật khẩu'),
          FormBuilderValidators.minLength(6, errorText: 'Mật khẩu tối thiểu 8 ký tự'),
        ];
        break;
      case FormFieldType.newPassword:
        validators = [
          FormBuilderValidators.required(errorText: 'Không được để trống mật khẩu mới'),
          FormBuilderValidators.minLength(6, errorText: 'Mật khẩu tối thiểu 8 ký tự'),
        ];
        break;
      case FormFieldType.oldPassword:
        validators = [
          FormBuilderValidators.required(errorText: 'Không được để trống mật khẩu hiện tại'),
          FormBuilderValidators.minLength(6, errorText: 'Mật khẩu tối thiểu 8 ký tự'),
        ];
        break;
      case FormFieldType.confirmPassword:
        validators = [
          FormBuilderValidators.required(errorText: 'Không được để trống mật khẩu xác nhận'),
          FormBuilderValidators.minLength(6, errorText: 'Mật khẩu tối thiểu 8 ký tự'),
        ];
        break;
      case FormFieldType.memo:
        validators = [
          FormBuilderValidators.required(errorText: 'Không được để trống mô tả địa chỉ'),
          FormBuilderValidators.maxLength(1000, errorText: 'Vượt quá giói hạn số từ'),
        ];
        break;

      case FormFieldType.detailOrder:
        validators = [
          FormBuilderValidators.required(errorText: 'Không được để trống chi tiết đơn hàng'),
          FormBuilderValidators.maxLength(1000, errorText: 'Vượt quá giói hạn số từ'),
        ];
        break;
      case FormFieldType.messagesDefault:
        validators = [
          FormBuilderValidators.maxLength(1000, errorText: 'Vượt quá giói hạn số từ'),
        ];
        break;
      default:
        return null;
    }
    return FormBuilderValidators.compose(validators);
  }
}

extension FormKeyExtension on GlobalKey<FormBuilderState> {
  FormBuilderState? get formBuilderState {
    return currentState;
  }
}

extension ListFormFieldState on List<MyFormFieldState> {
  void validateFormFields() {
    FocusManager.instance.primaryFocus?.unfocus();
    final isValid = map((e) => e.validate()).reduce((v, e) => v && e);
    if (!isValid) {
      final errorMessage = map(
        (e) => e.errorText == null ? null : '${e.decoration.labelText}: ${e.errorText}',
      ).whereType<String>().toList().join('\n');
      throw Exception(errorMessage);
    }
  }
}
