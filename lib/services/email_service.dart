import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class EmailService {
  String _username = 'noreply.aquariusstore@gmail.com';
  String _password = 'password';

  forgotPass(String userEmail, String randomCode) async {
    String title = 'Aquarius Store - Recuperação de senha';
    String content =
        'Olá, se você solicitou a recuperação de senha este é o seu codigo: $randomCode.\n\nInsira-o no app para redefinir sua senha. Caso não tenha solicitado, apenas ignore este e-mail.\n\nAtenciosamente, Aquarius Store.';
    final smtpServer = gmail(_username, _password);
    final message = Message()
      ..from = Address(_username, 'Aquarius Store')
      ..recipients.add(userEmail)
      ..subject = title
      ..text = content;
    await send(message, smtpServer);
  }
}
