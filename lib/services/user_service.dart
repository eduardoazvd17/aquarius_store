import 'package:aquariusstore/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  var _db = Firestore.instance.collection('users');

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
        return u;
      } else {
        return null;
      }
    }
  }

  Future<bool> register(User user) async {
    bool isUR = await isUserRegistered(user.email);
    if (isUR) {
      return false;
    } else {
      await _db.document(user.email).setData({
        'data': user.toJson(),
      });
      return true;
    }
  }

  Future<void> updateUser(User user) async {
    _db.document(user.email).updateData({
      'data': user.toJson(),
    });
  }
}
