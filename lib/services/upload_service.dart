import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadService {
  Future<String> uploadImage(bool opc) async {
    var photo;
    try {
      if (opc) {
        photo = await ImagePicker.pickImage(source: ImageSource.camera);
      } else {
        photo = await ImagePicker.pickImage(source: ImageSource.gallery);
      }
    } catch (e) {
      Get.snackbar('Permissão negada',
          'Você precisa permitir antes de utilizar esta função.');
    }

    if (photo != null) {
      return _uploadPhoto(photo);
    } else {
      return null;
    }
  }

  removeImages(List urls) async {
    for (var url in urls) {
      FirebaseStorage()
          .getReferenceFromUrl(url)
          .then((image) => image.delete());
    }
  }

  removeImage(String url) async {
    FirebaseStorage().getReferenceFromUrl(url).then((image) => image.delete());
  }

  Future<String> _uploadPhoto(var photo) async {
    try {
      var storageReference = FirebaseStorage().ref().child(
            '/images/products/' + Random().nextInt(999999999).toString(),
          );
      var uploadTask = storageReference.putFile(photo);
      await uploadTask.onComplete;
      return await storageReference.getDownloadURL();
    } catch (e) {
      Get.snackbar('Erro no upload',
          'Não foi possivel enviar a foto. Tente novamente mais tarde.');
      return null;
    }
  }
}
