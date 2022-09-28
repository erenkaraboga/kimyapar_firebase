import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../services/firebase/FirebaseService.dart';
import '../../add_order/model/add_order_model.dart';

abstract class IOrderService {
  final FirebaseService service;
  IOrderService(this.service);
  void addOrder(AddOrderModel model);
  Stream<QuerySnapshot<Map<String, dynamic>>> getNotTakenOrders();
  Stream<QuerySnapshot<Map<String, dynamic>>> getMyOrders();
  Stream<QuerySnapshot<Map<String, dynamic>>> getCurrentOrderedUser(String id);
  Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentOrder(String docId);
  void takeOrder(String docId);
  finishOrder(String docId, String qr);
}
