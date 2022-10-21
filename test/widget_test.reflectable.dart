// This file has been generated by the reflectable package.
// https://github.com/dart-lang/reflectable.
// @dart = 2.12

import 'dart:core';
import 'package:dart_json_mapper/src/model/annotations.dart' as prefix0;
import 'package:dart_json_mapper/src/name_casing.dart' as prefix3;
import 'package:flutter_go_ship_pbl6/feature/authentication/data/models/list_user_model.dart'
    as prefix1;
import 'package:flutter_go_ship_pbl6/feature/authentication/data/models/user_model.dart'
    as prefix2;

// ignore_for_file: camel_case_types
// ignore_for_file: implementation_imports
// ignore_for_file: prefer_adjacent_string_concatenation
// ignore_for_file: prefer_collection_literals
// ignore_for_file: unnecessary_const

// ignore:unused_import
import 'package:reflectable/mirrors.dart' as m;
// ignore:unused_import
import 'package:reflectable/src/reflectable_builder_based.dart' as r;
// ignore:unused_import
import 'package:reflectable/reflectable.dart' as r show Reflectable;

final _data = <r.Reflectable, r.ReflectorData>{
  const prefix0.JsonSerializable(): r.ReflectorData(
      <m.TypeMirror>[
        r.NonGenericClassMirrorImpl(
            r'ListUserModel',
            r'.ListUserModel',
            134217735,
            0,
            const prefix0.JsonSerializable(),
            const <int>[0, 6, 9, 10],
            const <int>[11, 12, 13, 14, 15, 6, 7, 8],
            const <int>[],
            -1,
            {},
            {},
            {
              r'': (bool b) => ({listUserModel}) => b
                  ? prefix1.ListUserModel(listUserModel: listUserModel)
                  : null,
              r'fromJson': (bool b) =>
                  (json) => b ? prefix1.ListUserModel.fromJson(json) : null
            },
            -1,
            0,
            const <int>[],
            const <Object>[
              prefix0.jsonSerializable,
              const prefix0.Json(
                  caseStyle: prefix3.CaseStyle.snake,
                  ignoreNullMembers: true,
                  name: 'data')
            ],
            null),
        r.NonGenericClassMirrorImpl(
            r'UserModel',
            r'.UserModel',
            134217735,
            1,
            const prefix0.JsonSerializable(),
            const <int>[1, 2, 3, 4, 5, 16, 27, 28],
            const <int>[
              11,
              12,
              13,
              14,
              15,
              16,
              17,
              18,
              19,
              20,
              21,
              22,
              23,
              24,
              25,
              26
            ],
            const <int>[],
            -1,
            {},
            {},
            {
              r'': (bool b) => ({id, name, email, gender, status}) => b
                  ? prefix2.UserModel(
                      email: email,
                      gender: gender,
                      id: id,
                      name: name,
                      status: status)
                  : null,
              r'fromJson': (bool b) =>
                  (json) => b ? prefix2.UserModel.fromJson(json) : null
            },
            -1,
            1,
            const <int>[],
            const <Object>[
              prefix0.jsonSerializable,
              const prefix0.Json(
                  caseStyle: prefix3.CaseStyle.snake, ignoreNullMembers: true)
            ],
            null)
      ],
      <m.DeclarationMirror>[
        r.VariableMirrorImpl(
            r'listUserModel',
            84017157,
            0,
            const prefix0.JsonSerializable(),
            -1,
            2,
            3,
            const <int>[1],
            const []),
        r.VariableMirrorImpl(
            r'id',
            67239941,
            1,
            const prefix0.JsonSerializable(),
            -1,
            4,
            4, const <int>[], const []),
        r.VariableMirrorImpl(
            r'name',
            67239941,
            1,
            const prefix0.JsonSerializable(),
            -1,
            5,
            5, const <int>[], const []),
        r.VariableMirrorImpl(
            r'email',
            67239941,
            1,
            const prefix0.JsonSerializable(),
            -1,
            5,
            5, const <int>[], const []),
        r.VariableMirrorImpl(
            r'gender',
            67239941,
            1,
            const prefix0.JsonSerializable(),
            -1,
            5,
            5, const <int>[], const []),
        r.VariableMirrorImpl(
            r'status',
            67239941,
            1,
            const prefix0.JsonSerializable(),
            -1,
            5,
            5, const <int>[], const []),
        r.MethodMirrorImpl(r'toJson', 35651586, 0, -1, 6, 7, null,
            const <int>[], const prefix0.JsonSerializable(), const []),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 0, 7),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 0, 8),
        r.MethodMirrorImpl(r'', 0, 0, -1, 0, 0, const <int>[], const <int>[0],
            const prefix0.JsonSerializable(), const []),
        r.MethodMirrorImpl(r'fromJson', 1, 0, -1, 0, 0, const <int>[],
            const <int>[1], const prefix0.JsonSerializable(), const []),
        r.MethodMirrorImpl(r'==', 2097154, -1, -1, 8, 8, const <int>[],
            const <int>[3], const prefix0.JsonSerializable(), const []),
        r.MethodMirrorImpl(r'toString', 2097154, -1, -1, 9, 9, const <int>[],
            const <int>[], const prefix0.JsonSerializable(), const []),
        r.MethodMirrorImpl(
            r'noSuchMethod',
            524290,
            -1,
            -1,
            -1,
            -1,
            const <int>[],
            const <int>[4],
            const prefix0.JsonSerializable(),
            const []),
        r.MethodMirrorImpl(r'hashCode', 2097155, -1, -1, 10, 10, const <int>[],
            const <int>[], const prefix0.JsonSerializable(), const []),
        r.MethodMirrorImpl(
            r'runtimeType',
            2097155,
            -1,
            -1,
            11,
            11,
            const <int>[],
            const <int>[],
            const prefix0.JsonSerializable(),
            const []),
        r.MethodMirrorImpl(r'toJson', 35651586, 1, -1, 6, 7, null,
            const <int>[], const prefix0.JsonSerializable(), const []),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 1, 17),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 1, 18),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 2, 19),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 2, 20),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 3, 21),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 3, 22),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 4, 23),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 4, 24),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 5, 25),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 5, 26),
        r.MethodMirrorImpl(
            r'',
            0,
            1,
            -1,
            1,
            1,
            const <int>[],
            const <int>[5, 6, 7, 8, 9],
            const prefix0.JsonSerializable(),
            const []),
        r.MethodMirrorImpl(r'fromJson', 1, 1, -1, 1, 1, const <int>[],
            const <int>[10], const prefix0.JsonSerializable(), const [])
      ],
      <m.ParameterMirror>[
        r.ParameterMirrorImpl(
            r'listUserModel',
            84030470,
            9,
            const prefix0.JsonSerializable(),
            -1,
            2,
            3,
            const <int>[1],
            const [],
            null,
            #listUserModel),
        r.ParameterMirrorImpl(
            r'json',
            151126022,
            10,
            const prefix0.JsonSerializable(),
            -1,
            6,
            7,
            null,
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_listUserModel',
            84017254,
            8,
            const prefix0.JsonSerializable(),
            -1,
            2,
            3,
            const <int>[1],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'other',
            134348806,
            11,
            const prefix0.JsonSerializable(),
            -1,
            12,
            12,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'invocation',
            134348806,
            13,
            const prefix0.JsonSerializable(),
            -1,
            13,
            13,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'id',
            67253254,
            27,
            const prefix0.JsonSerializable(),
            -1,
            4,
            4,
            const <int>[],
            const [],
            null,
            #id),
        r.ParameterMirrorImpl(
            r'name',
            67253254,
            27,
            const prefix0.JsonSerializable(),
            -1,
            5,
            5,
            const <int>[],
            const [],
            null,
            #name),
        r.ParameterMirrorImpl(
            r'email',
            67253254,
            27,
            const prefix0.JsonSerializable(),
            -1,
            5,
            5,
            const <int>[],
            const [],
            null,
            #email),
        r.ParameterMirrorImpl(
            r'gender',
            67253254,
            27,
            const prefix0.JsonSerializable(),
            -1,
            5,
            5,
            const <int>[],
            const [],
            null,
            #gender),
        r.ParameterMirrorImpl(
            r'status',
            67253254,
            27,
            const prefix0.JsonSerializable(),
            -1,
            5,
            5,
            const <int>[],
            const [],
            null,
            #status),
        r.ParameterMirrorImpl(
            r'json',
            151126022,
            28,
            const prefix0.JsonSerializable(),
            -1,
            6,
            7,
            null,
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_id',
            67240038,
            18,
            const prefix0.JsonSerializable(),
            -1,
            4,
            4,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_name',
            67240038,
            20,
            const prefix0.JsonSerializable(),
            -1,
            5,
            5,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_email',
            67240038,
            22,
            const prefix0.JsonSerializable(),
            -1,
            5,
            5,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_gender',
            67240038,
            24,
            const prefix0.JsonSerializable(),
            -1,
            5,
            5,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_status',
            67240038,
            26,
            const prefix0.JsonSerializable(),
            -1,
            5,
            5,
            const <int>[],
            const [],
            null,
            null)
      ],
      <Type>[
        prefix1.ListUserModel,
        prefix2.UserModel,
        const m.TypeValue<List<prefix2.UserModel>>().type,
        List,
        int,
        String,
        const m.TypeValue<Map<String, dynamic>>().type,
        Map,
        bool,
        String,
        int,
        Type,
        Object,
        Invocation
      ],
      2,
      {
        r'==': (dynamic instance) => (x) => instance == x,
        r'toString': (dynamic instance) => instance.toString,
        r'noSuchMethod': (dynamic instance) => instance.noSuchMethod,
        r'hashCode': (dynamic instance) => instance.hashCode,
        r'runtimeType': (dynamic instance) => instance.runtimeType,
        r'toJson': (dynamic instance) => instance.toJson,
        r'listUserModel': (dynamic instance) => instance.listUserModel,
        r'id': (dynamic instance) => instance.id,
        r'name': (dynamic instance) => instance.name,
        r'email': (dynamic instance) => instance.email,
        r'gender': (dynamic instance) => instance.gender,
        r'status': (dynamic instance) => instance.status
      },
      {
        r'listUserModel=': (dynamic instance, value) =>
            instance.listUserModel = value,
        r'id=': (dynamic instance, value) => instance.id = value,
        r'name=': (dynamic instance, value) => instance.name = value,
        r'email=': (dynamic instance, value) => instance.email = value,
        r'gender=': (dynamic instance, value) => instance.gender = value,
        r'status=': (dynamic instance, value) => instance.status = value
      },
      null,
      [])
};

final _memberSymbolMap = null;

void initializeReflectable() {
  r.data = _data;
  r.memberSymbolMap = _memberSymbolMap;
}