import 'package:flutter_email_sender/flutter_email_sender.dart';

class EmailService {
  forgotPass(String userEmail, String randomCode) async {
    final Email email = Email(
      body: 'Aquarius Store - Recuperação de senha',
      subject:
          'Olá se você solicitou a recuperação de senha este é o seu codigo: $randomCode. Insira-o no app para redefinir sua senha. Caso não tenha solicitado, apenas ignore este e-mail. Obrigado.',
      recipients: [userEmail],
      //cc: ['cc@example.com'],
      //bcc: ['bcc@example.com'],
      //attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }
}
