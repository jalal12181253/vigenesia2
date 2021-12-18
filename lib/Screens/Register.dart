import 'package:vigenesia/Constant/Const.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:dio/dio.dart';

class Register extends StatefulWidget {
 const Register({Key key}) : super(key: key);

 @override
 _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Ganti base URL




  String baseurl = url,

  Future postRegister(
      String nama, String profesi, String email, String password) async{
    var dio = Dio();

    dynamic data = {
      "nama": nama,
      "profesi": profesi,
      "email": email,
      "password": password
    };

    try {
      final response = await dio.post("$baseurl/vigenesia/api/registrasi/",
        data: data,
        options: Options(headers: {'Content-type': 'application/json'}));

    print("Respon -> ${response.data} + ${response.statusCode}");

    if (response.statusCode == 200) {
      return response.data;
    }
    } catch (e) {
      print("Failed To Load $e");
    }
  }

TextEditingController nameController = TextEditingController();
 TextEditingController profesiController = TextEditingController();
 TextEditingController emailController = TextEditingController();
 TextEditingController passwordController = TextEditingController();
 @override
Widget build(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      child: SafeArea(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width / 1.3,
               height: MediaQuery.of(context).size.height,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Text(
                                "Register Your Account",

                                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 50),
                              FormBuilderTextField(
                                name: "name",
                                controller: nameController,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 10)
                                    border: OutlineInputBorder(),
                                    labelText: "nama"),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              FormBuilderTextField(
                                  obscureText: 
                                      true,
                                  name: "password",
                                  controller: passwordController,

                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 10),
                                      border: OutlineInputBorder(),
                                      labelText: "password"),
                              ),
                              SeizedBox(
                                  height: 30,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  onPressed: () async {                                    
                                  },
                                  child: Text("daftar")),
                                ),
                                ],
                  ),
          ),
        ),
      ),
    ),
  );
}
}
