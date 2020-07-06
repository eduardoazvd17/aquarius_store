import 'dart:convert';
import 'dart:math';
import 'package:aquariusstore/models/user.dart';
import 'package:aquariusstore/services/email_service.dart';
import 'package:aquariusstore/services/user_service.dart';
import 'package:aquariusstore/controllers/user_controller.dart';
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
  bool isLoading = false;
  bool isForgotPass = false;
  bool sendEmail = false;
  String genCode;

  final UserController userController = Get.find<UserController>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final passConfirmController = TextEditingController();
  final codeController = TextEditingController();

  _sendForgotPass() async {
    var us = UserService();
    if (sendEmail) {
      String email = emailController.text;
      String code = codeController.text;
      String pass = _generateMD5(passController.text);
      String passConfirm = _generateMD5(passConfirmController.text);

      if (code != genCode) {
        Get.snackbar(
          'Código inválido',
          'Insira o código que lhe enviamos por e-mail corretamente.',
          backgroundColor: Theme.of(context).errorColor,
        );
        return;
      }
      if (passController.text.isEmpty || passController.text.length < 6) {
        Get.snackbar(
          'Senha inválida',
          'O tamanho da sua senha deve maior ou igual a 6 caracteres.',
          backgroundColor: Theme.of(context).errorColor,
        );
        return;
      }
      if (pass != passConfirm) {
        Get.snackbar(
          'Senha inválida',
          'Os campos nova senha e confirmação de senha devem ser iguais.',
          backgroundColor: Theme.of(context).errorColor,
        );
        return;
      }
      setState(() {
        isLoading = true;
      });
      bool result = await us.changePass(email, pass);
      setState(() {
        isLogin = true;
        isLoading = false;
        isForgotPass = false;
        sendEmail = false;
      });
      if (result) {
        Get.snackbar(
          'Senha alterada',
          'Utilize sua nova senha para entrar.',
          backgroundColor: Theme.of(context).errorColor,
        );
      } else {
        Get.snackbar(
          'Erro ao alterar senha',
          'Não foi possível alterar sua senha, tente novamente.',
          backgroundColor: Theme.of(context).errorColor,
        );
      }
      passController.clear();
      passConfirmController.clear();
      codeController.clear();
    } else {
      String email = emailController.text;
      if (!GetUtils.isEmail(email)) {
        Get.snackbar(
          'E-mail inválido',
          'Endereço de e-mail inválido.',
          backgroundColor: Theme.of(context).errorColor,
        );
        return;
      }
      setState(() {
        isLoading = true;
      });
      bool isUserReg = await us.isUserRegistered(email);
      if (!isUserReg) {
        Get.snackbar(
          'Conta inexistente',
          'Não existe uma conta associada a este endereço de e-mail.',
          backgroundColor: Theme.of(context).errorColor,
        );
        setState(() {
          isLoading = false;
        });
        return;
      }
      var randomCode = Random().nextInt(999999);
      while (randomCode < 100000) {
        randomCode *= 10;
      }
      await EmailService().forgotPass(email, randomCode.toString());
      setState(() {
        genCode = randomCode.toString();
        sendEmail = true;
        isLoading = false;
      });
      Get.snackbar(
        'Código de Recuperação',
        'Enviamos um e-mail para $email com o código de recuperação para alterar a senha.',
        backgroundColor: Theme.of(context).errorColor,
      );
    }
  }

  _sendForm() async {
    var us = UserService();
    if (isLogin) {
      String email = emailController.text;
      String pass = _generateMD5(passController.text);
      if (!GetUtils.isEmail(email)) {
        Get.snackbar(
          'E-mail inválido',
          'Endereço de e-mail inválido.',
          backgroundColor: Theme.of(context).errorColor,
        );
        return;
      }
      setState(() {
        isLoading = true;
      });
      var user = await us.login(email: email, password: pass);
      if (user == null) {
        Get.snackbar(
          'Credenciais incorretas',
          'Senha incorreta ou usuário não cadastrado.',
          backgroundColor: Theme.of(context).errorColor,
        );
        setState(() {
          isLoading = false;
        });
        return;
      } else {
        //LOGADO
        userController.setUser(user);
        Get.close(1);
      }
    } else {
      String name = nameController.text;
      String email = emailController.text;
      String pass = _generateMD5(passController.text);
      String passConfirm = _generateMD5(passConfirmController.text);
      if (!GetUtils.isEmail(email)) {
        Get.snackbar(
          'E-mail inválido',
          'Endereço de e-mail inválido.',
          backgroundColor: Theme.of(context).errorColor,
        );
        return;
      }
      if (passController.text.isEmpty || passController.text.length < 6) {
        Get.snackbar(
          'Senha inválida',
          'O tamanho da sua senha deve maior ou igual a 6 caracteres.',
          backgroundColor: Theme.of(context).errorColor,
        );
        return;
      }
      if (pass != passConfirm) {
        Get.snackbar(
          'Senha inválida',
          'Os campos senha e confirmação de senha devem ser iguais.',
          backgroundColor: Theme.of(context).errorColor,
        );
        return;
      }
      setState(() {
        isLoading = true;
      });
      var user = User(
        fullName: name,
        email: email,
        password: pass,
      );
      bool status = await us.register(user);
      if (status) {
        //CADASTRADO
        userController.setUser(user);
        Get.close(1);
      } else {
        Get.snackbar(
          'Cadastro não efetuado',
          'Este e-mail já esta cadastrado em nosso sistema.',
          backgroundColor: Theme.of(context).errorColor,
        );
        setState(() {
          isLoading = false;
        });
        return;
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
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : SafeArea(child: LayoutBuilder(
              builder: (ctx, cnt) {
                return Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: cnt.maxWidth * 0.02),
                      child: Center(
                        child: Card(
                          elevation: 3,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 15),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: IconButton(
                                        icon: Icon(Icons.arrow_back_ios),
                                        onPressed: () {
                                          if (isForgotPass || sendEmail) {
                                            setState(() {
                                              isForgotPass = false;
                                              sendEmail = false;
                                            });
                                            passController.clear();
                                            passConfirmController.clear();
                                            codeController.clear();
                                            return;
                                          }
                                          if (!isLogin) {
                                            setState(() {
                                              isLogin = true;
                                            });
                                          } else {
                                            Get.close(1);
                                          }
                                        },
                                      ),
                                    ),
                                    Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          SizedBox(height: 11),
                                          Text(
                                            isForgotPass
                                                ? 'Esqueci minha senha'
                                                : isLogin
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
                                        textCapitalization:
                                            TextCapitalization.words,
                                        decoration: InputDecoration(
                                          labelText: 'Nome Completo',
                                          suffixIcon: Icon(Icons.person),
                                        ),
                                      )
                                    : Container(),
                                SizedBox(height: !isLogin ? 10 : 0),
                                sendEmail
                                    ? Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          TextFormField(
                                            controller: codeController,
                                            autocorrect: false,
                                            keyboardType:
                                                TextInputType.numberWithOptions(
                                              decimal: false,
                                            ),
                                            decoration: InputDecoration(
                                              labelText:
                                                  'Código de Recuperação',
                                              suffixIcon: Icon(Icons.lock),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      )
                                    : TextFormField(
                                        controller: emailController,
                                        autocorrect: false,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          labelText: 'E-mail',
                                          suffixIcon: Icon(Icons.mail),
                                        ),
                                      ),
                                SizedBox(height: sendEmail ? 0 : 10),
                                sendEmail
                                    ? TextFormField(
                                        controller: passController,
                                        autocorrect: false,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          labelText: 'Nova Senha',
                                          suffixIcon: Icon(Icons.vpn_key),
                                        ),
                                      )
                                    : isForgotPass
                                        ? Text(
                                            'Digite seu e-mail acima para receber o código de recuperação de senha.',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        : TextFormField(
                                            controller: passController,
                                            autocorrect: false,
                                            obscureText: true,
                                            decoration: InputDecoration(
                                              labelText: 'Senha',
                                              suffixIcon: Icon(Icons.vpn_key),
                                            ),
                                          ),
                                SizedBox(height: 10),
                                sendEmail
                                    ? TextFormField(
                                        controller: passConfirmController,
                                        autocorrect: false,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          labelText: 'Confirmação de Senha',
                                          suffixIcon: Icon(Icons.vpn_key),
                                        ),
                                      )
                                    : !isLogin
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
                                SizedBox(
                                    height: sendEmail ? 10 : !isLogin ? 10 : 0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    isForgotPass
                                        ? Container()
                                        : isLogin
                                            ? FlatButton(
                                                padding: EdgeInsets.zero,
                                                onPressed: () {
                                                  nameController.clear();
                                                  passController.clear();
                                                  passConfirmController.clear();
                                                  setState(() {
                                                    isForgotPass = true;
                                                  });
                                                },
                                                child:
                                                    Text('Esqueci minha senha'),
                                              )
                                            : Container(),
                                    FlatButton(
                                      color: Theme.of(context).accentColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                      textColor: Colors.white,
                                      onPressed: isForgotPass
                                          ? _sendForgotPass
                                          : _sendForm,
                                      child: Text(
                                        sendEmail
                                            ? 'Alterar Senha'
                                            : isForgotPass
                                                ? 'Enviar Código'
                                                : isLogin
                                                    ? 'Entrar'
                                                    : 'Efetuar Cadastro',
                                      ),
                                    ),
                                  ],
                                ),
                                isForgotPass
                                    ? Container()
                                    : isLogin
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              FlatButton(
                                                onPressed: () {
                                                  nameController.clear();
                                                  emailController.clear();
                                                  passController.clear();
                                                  passConfirmController.clear();
                                                  setState(() {
                                                    isLogin = !isLogin;
                                                  });
                                                },
                                                child: Text(
                                                    'Ainda não possui uma conta?'),
                                              ),
                                            ],
                                          )
                                        : Container(),
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
