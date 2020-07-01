import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(child: LayoutBuilder(
        builder: (ctx, cnt) {
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: cnt.maxWidth * 0.05),
                child: Center(
                  child: Card(
                    elevation: 3,
                    child: Padding(
                      padding: EdgeInsets.all(20),
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
                                          ? 'Entre com sua conta'
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
                              ? TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Nome Completo',
                                    suffixIcon: Icon(Icons.person),
                                  ),
                                )
                              : Container(),
                          SizedBox(height: !isLogin ? 10 : 0),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'E-mail',
                              suffixIcon: Icon(Icons.mail),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Senha',
                              suffixIcon: Icon(Icons.vpn_key),
                            ),
                          ),
                          SizedBox(height: 10),
                          !isLogin
                              ? TextField(
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
                                onPressed: () {},
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
