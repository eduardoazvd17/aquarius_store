import 'package:flutter_mailer/flutter_mailer.dart';

class EmailService {
  forgotPass(String userEmail, String randomCode) async {
    final mailOptions = MailOptions(
      body: 'Aquarius Store - Recuperação de senha',
      subject:
          'Olá, se você solicitou a recuperação de senha este é o seu codigo: $randomCode. Insira-o no app para redefinir sua senha. Caso não tenha solicitado, apenas ignore este e-mail. Obrigado.',
      recipients: [userEmail],
      isHTML: false,
    );
    await FlutterMailer.send(mailOptions);
  }
}
