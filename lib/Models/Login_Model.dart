import 'dart:convert';
import 'package:vigenesia/Screens/Login.dart';

LoginModels loginModelsFromJson(String str) => LoginModels.fromJson(json.decode(str));

String loginModelsToJson(LoginModels data) => json.encode(data.toJson());

class LoginModels {
  LoginModels({
    this.active,
    this.message,
    this.data
  });

  bool isActive;
  String message;
  Data data;

  factory LoginModels.fromJson(Map<String, dynamic> Json) => LoginModels(
      isActive: Json["is_Active"],
      message: Json["message"],
      data: data.fromJson(json["data"]),
  );

  Map<String, Dynamic> toJson() => {
      "is_Active": isActive,
      "message": message,
      "data": data.toJson(),
  };
}

class Data {
    Data({
        this.iduser,
        this.nama,
        this.profesi,
        this.email,
        this.password,
        this.roleId,
        this.isActive,
        this.tanggalInput,
        this.modified,
    });

    String.iduser;
    String.nama;
    String profesi;
    String email;
    String password;
    String roleId;
    String isActive;
    DateTime tanggalInput;
    String modified;

    factory  Data.fromJson(Map<String, dynamic> json) => Data(
      iduser: json["iduser"]
      nama: json["nama"],
      profesi: json["profesi"],
      email: json["email"],
      password: json["password"],
      roleId: json["role_id"],
      isActive: json["is_active"],
      tanggalInput: DateTime.parse(json["tanggal_input"]),
      modified: json["modified"],
    );

    Map<String, dynamic> toJson() => {
      "iduser": iduser,
      "nama": nama,
      "profesi": profesi,
      "email": email,
      "password": password,
      "role_id": roleId,
      "is_active": isActive,
      "tanggal_input": "${tanggalInput.year.toString().padLeft(4, '0')}-
$tanggalInput.month.toString().padleft(2, '0')}-
${tanggalInput.day.toString().padLeft(2, '0')}",
      "modified": modified,
    };
  