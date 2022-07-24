import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kimyapar/view/map/model/UserModel.dart';

abstract class IMapService {
  final FirebaseFirestore _db;

  IMapService(this._db);

  Future<List<UserModel>> retrieveUsers();
  double drawDistance(double lat, long, endLat, endLong);
  Future<List<UserModel>> filterGeo();
}

class UserHelper extends IMapService {
  UserHelper(super.db);

  FirebaseFirestore get _db => FirebaseFirestore.instance;
  @override
  Future<List<UserModel>> retrieveUsers() async {
    FirebaseFirestore _db = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("users").get();
    return snapshot.docs
        .map((docSnapshot) => UserModel.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  double drawDistance(double lat, long, endLat, endLong) {
    return Geolocator.distanceBetween(lat, long, endLat, endLong);
  }

  Future<List<UserModel>> filterGeo() async {
    List<UserModel> nearList = [];
    await retrieveUsers().then((list) {
      nearList.addAll(list);
      nearList.retainWhere((element) =>
          drawDistance(element.lat!, element.long, 40.599391, 33.610534) <
          1200);
      print("Yakındaki Aşçılar = " + "${nearList.length}");
    });
    return nearList;
  }
}
