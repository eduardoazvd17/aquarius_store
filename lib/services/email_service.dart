import 'package:aquariusstore/utils/smtp_login_info.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class EmailService {
  forgotPass(String userEmail, String randomCode) async {
    String title = 'Aquarius Store - Recuperação de senha';
    String content =
        'Olá, se você solicitou a recuperação de senha este é o seu codigo: $randomCode.\n\nInsira-o no app para redefinir sua senha. Caso não tenha solicitado, apenas ignore este e-mail.\n\nAtenciosamente, Aquarius Store.';
    final smtpServer = gmail(SmtpLoginInfo.USERNAME, SmtpLoginInfo.PASSWORD);
    final message = Message()
      ..from = Address(SmtpLoginInfo.USERNAME, 'Aquarius Store')
      ..recipients.add(userEmail)
      ..subject = title
      ..text = content;
    await send(message, smtpServer);
  }
}
