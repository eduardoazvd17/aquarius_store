import 'package:aquariusstore/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

class UserService {
  var _db = Firestore.instance.collection('users');
  var _credentials = GetStorage('credentials');

  Future<bool> isUserRegistered(String email) async {
    DocumentSnapshot user = await _db.document(email).get();
    if (user == null || user.data == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<User> login({String email, String password}) async {
    DocumentSnapshot user = await _db.document(email).get();
    if (user == null || user.data == null) {
      return null;
    } else {
      var u = User.fromJson(user.data['data']);
      if (u.password.toUpperCase() == password) {
        saveCredentials(email);
        return u;
      } else {
        return null;
      }
    }
  }

  Future<User> loginWithCredentials() async {
    String email = loadCredentials();
    if (email == null || email.isEmpty) {
      return null;
    } else {
      DocumentSnapshot user = await _db.document(email).get();
      if (user.data == null) {
        return null;
      } else {
        return User.fromJson(user.data['data']);
      }
    }
  }

  saveCredentials(String email) {
    _credentials.write('email', email);
  }

  String loadCredentials() {
    return _credentials.read('email');
  }

  deleteCredentials() {
    _credentials.remove('email');
  }

  Future<bool> register(User user) async {
    bool isUR = await isUserRegistered(user.email);
    if (isUR) {
      return false;
    } else {
      await _db.document(user.email).setData({
        'data': user.toJson(),
      });
      saveCredentials(user.email);
      return true;
    }
  }

  Future<void> updateUser(User user) async {
    _db.document(user.email).updateData({
      'data': user.toJson(),
    });
  }

  Future<bool> changePass(String email, String newPass) async {
    DocumentSnapshot user = await _db.document(email).get();
    if (user == null || user.data == null) {
      return false;
    } else {
      User u = User.fromJson(user.data['data']);
      u.password = newPass;
      await updateUser(u);
      return true;
    }
  }
}
