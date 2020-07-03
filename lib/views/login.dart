import 'dart:convert';
import 'package:aquariusstore/models/user.dart';
import 'package:aquariusstore/services/user_service.dart';
import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:get/get.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLogin = true;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final passConfirmController = TextEditingController();

  _sendForm() async {
    var us = UserService();
    if (isLogin) {
      String email = emailController.text;
      String pass = _generateMD5(passController.text);
      var user = await us.login(email: email, password: pass);
      if (user == null) {
        Get.snackbar(
          'Credenciais incorretas',
          'Senha incorreta ou usuário não cadastrado.',
          backgroundColor: Colors.red[300],
        );
      } else {
        //TODO: Login efetuado.
        print('login efetuado');
      }
    } else {
      String name = nameController.text;
      String email = emailController.text;
      String pass = _generateMD5(passController.text);
      String passConfirm = _generateMD5(passConfirmController.text);
      if (passController.text.isEmpty || passController.text.length < 6) {
        Get.snackbar(
          'Senha inválida',
          'O tamanho da sua senha deve maior ou igual a 6 caracteres.',
          backgroundColor: Colors.red[300],
        );
      }
      if (pass != passConfirm) {
        Get.snackbar(
          'Senha inválida',
          'Os campos senha e confirmação de senha devem ser iguais.',
          backgroundColor: Colors.red[300],
        );
      }
      var user = User(
        fullName: name,
        email: email,
        password: pass,
      );
      bool status = await us.register(user);
      if (status) {
        //TODO: cadastro efetuado
        print('cadastro efetuado');
      } else {
        Get.snackbar(
          'Cadastro não efetuado',
          'Este e-mail já esta cadastrado em nosso sistema.',
          backgroundColor: Theme.of(context).errorColor,
        );
      }
    }
  }

  String _generateMD5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes).toString().toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(child: LayoutBuilder(
        builder: (ctx, cnt) {
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: cnt.maxWidth * 0.02),
                child: Center(
                  child: Card(
                    elevation: 3,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  icon: Icon(Icons.arrow_back_ios),
                                  onPressed: () => Get.close(1),
                                ),
                              ),
                              Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    SizedBox(height: 11),
                                    Text(
                                      isLogin
                                          ? 'Entre com a sua conta'
                                          : 'Cadastre-se',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Divider(),
                          !isLogin
                              ? TextFormField(
                                  controller: nameController,
                                  textCapitalization: TextCapitalization.words,
                                  decoration: InputDecoration(
                                    labelText: 'Nome Completo',
                                    suffixIcon: Icon(Icons.person),
                                  ),
                                )
                              : Container(),
                          SizedBox(height: !isLogin ? 10 : 0),
                          TextFormField(
                            controller: emailController,
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'E-mail',
                              suffixIcon: Icon(Icons.mail),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: passController,
                            autocorrect: false,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Senha',
                              suffixIcon: Icon(Icons.vpn_key),
                            ),
                          ),
                          SizedBox(height: 10),
                          !isLogin
                              ? TextFormField(
                                  controller: passConfirmController,
                                  autocorrect: false,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: 'Confirmação de Senha',
                                    suffixIcon: Icon(Icons.vpn_key),
                                  ),
                                )
                              : Container(),
                          SizedBox(height: !isLogin ? 10 : 0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              isLogin
                                  ? FlatButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {},
                                      child: Text('Esqueci minha senha'),
                                    )
                                  : Container(),
                              FlatButton(
                                color: Theme.of(context).accentColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                textColor: Colors.white,
                                onPressed: _sendForm,
                                child: Text(
                                    isLogin ? 'Entrar' : 'Efetuar Cadastro'),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  setState(() {
                                    isLogin = !isLogin;
                                  });
                                },
                                child: Text(isLogin
                                    ? 'Ainda não possui uma conta?'
                                    : 'Já possui uma conta?'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      )),
    );
  }
}
