import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadService {
  Future<String> uploadImage({bool opc, String productId, int index}) async {
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
      return _uploadPhoto(photo, productId, index);
    }
  }

  removeImage(String productId, int index) {
    FirebaseStorage()
        .ref()
        .child('/products/$productId/images/' + index.toString())
        .delete();
  }

  Future<String> _uploadPhoto(var photo, String productId, int index) async {
    try {
      var storageReference = FirebaseStorage().ref().child(
            '/products/${productId}/images/' + index.toString(),
          );
      var uploadTask = storageReference.putFile(photo);
      await uploadTask.onComplete;
      return await storageReference.getDownloadURL();
    } catch (e) {
      Get.snackbar('Erro no upload',
          'Não foi possivel enviar a foto. Tente novamente mais tarde.');
    }
  }
}
