import 'package:aquariusstore/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DBService {
  var _db = Firestore.instance;
  static const USER_COLLECTION = 'users';

  Future<bool> isUserRegistered(String email) async {
    DocumentSnapshot user =
        await _db.collection(USER_COLLECTION).document(email).get();
    if (user == null || user.data == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<User> login({String email, String password}) async {
    DocumentSnapshot user =
        await _db.collection(USER_COLLECTION).document(email).get();
    if (user == null || user.data == null) {
      return null;
    } else {
      var u = User.fromJson(user.data['data']);
      if (u.password == password) {
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
      await _db.collection(USER_COLLECTION).document(user.email).setData({
        'data': user.toJson(),
      });
      return true;
    }
  }

  Future<void> updateUser(User user) async {
    _db.collection(USER_COLLECTION).document(user.email).updateData({
      'data': user.toJson(),
    });
  }
}
