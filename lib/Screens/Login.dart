import 'dart:html';
import 'package:vigenesia/Constant/const.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:dio/dio.dart';
import 'MainScreen.dart';
import 'Register.dart';
import 'package:flutter/gestures.dart';
import 'dart:convert';
import 'package:vigenesia/Models/Login_Model.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key)

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String nama;

  final GlobalKey<FormBuilderState> _fbkey = GlobalKey<FormBuilderState>();

  Future<LoginModels> postLogin(String email, String password) async {
    var dio = Dio();
    String baseurl = url;

    Map<String, dynamic> data = {"email": email, "password": password};

    try {
      final Response = await dio.post("$baseurl/vigenesia/api/login/",
          data: data,
          options: Options(headers: {'Content-type': 'application/json'});

    print("Respon -> ${Response.data} + ${Response.statusCode}");
    if (Response.statusCode == 200) {
      final LoginModel = LoginModels.fromJson(Response.data);

      return LoginModel;
    }
  } catch (e) {
    print("Failed To Load $e");
  }
}

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // <--berfungsi untuk bisa scroll
        child: SafeArea(
          // < -- Biar Gak Keluar Area Screen HP
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Login Area",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 50), //<-- Kasih Jarak Tinggi : 50px
                Center(
                  child: Form(
                    key: _fbkey,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Column(
                        children: [
                          FormBuilderTextField(
                            name: "email",
                            controller: emailController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10),
                              border: OutlineInputBorder(),
                              labelText : "Email"),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            FormBuilderTextField(
                              obscureText:
                                    true,
                              name : "password",
                              controller : passwordController,

                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10),
                                  border: OutlineInputBorder(),
                                  labelText: "password"),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'dont have account ? ',
                              style: TextStyle(color: Colors.black54),
                            ),
                            TextSpan(
                              text: 'Sign Up',
                              recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context, 
                                  new MaterialPageRoute(
                                    builder: 
                                        (BuildContext context) => 
                                            new Register()));
                              },
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.blueAccent,
                              )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () async {
                            await postLogin(emailController.text, passwordController.text)
                            .then((value) => {
                              if (value != null)
                              {
                                setState(() {
                                  nama = value.data.nama;
                                  Navigator.pushReplacement(
                                    context,
                                    new MaterialPageRoute(
                                      builder: (BuildContext contex) => new MainScreens(nama: nama)));
                                })
                                }
                                else if (value == null)
                                {
                                  Flushbar(
                                    message:
                                  "Check Your Email / Password",
                                      duration: 
                                  BackgroundColor:
                                      Colors.redAccent,
                                  flushbarPosition: 
                                      flushbarPosition. TOP,
                                  ).show(context),
                                }
                              });
                          },
                          child: Text("Sign In")),
                    ),
                  ]
                ),
              ),
            ),
          ),
              ],
            ),
          ),
        ),
      ),
      );
  }
}