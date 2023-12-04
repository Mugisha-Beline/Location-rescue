import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  final String uid;

  DatabaseManager({required this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference hotelCollection =
      FirebaseFirestore.instance.collection("hotels");
  final CollectionReference restaurantCollection =
      FirebaseFirestore.instance.collection("restaurants");
  final CollectionReference locationCollection =
      FirebaseFirestore.instance.collection("locations");

  Future<void> savingUserData(String fullName, String email) async {
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "profilePic": "",
      "uid": uid,
    });
  }

  Future<DocumentSnapshot> gettingUserData(String email) async {
    return await userCollection.where("email", isEqualTo: email).get().then(
      (QuerySnapshot querySnapshot) {
        return querySnapshot.docs.first;
      },
    );
  }

  Stream<DocumentSnapshot> getUserHotel() {
    return userCollection.doc(uid).snapshots();
  }

  Future<void> createHotel(String userName, String id, String hotelName) async {
    DocumentReference hotelDocumentReference =
        await hotelCollection.add({
      "hotelName": hotelName,
      "hotelIcon": "",
      "names": [],
      "hotelId": "",
    });

    await hotelDocumentReference.update({
      "names": FieldValue.arrayUnion(["${uid}_$userName"]),
      "hotelId": hotelDocumentReference.id,
    });

    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
      "hotels": FieldValue.arrayUnion(["${hotelDocumentReference.id}_$hotelName"])
    });
  }

  Future<bool> isUserJoined(
      String hotelName, String hotelId, String userName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();

    List<dynamic> hotels = await documentSnapshot['hotels'];
    return hotels.contains("${hotelId}_$hotelName");
  }

  Future<void> toggleHotelJoin(
      String hotelId, String userName, String hotelName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference hotelDocumentReference = hotelCollection.doc(hotelId);

    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> hotels = await documentSnapshot['hotels'];

    if (hotels.contains("$hotelId}_$hotelName")) {
      await userDocumentReference.update({
        "hotels": FieldValue.arrayRemove(["${hotelId}_$hotelName"])
      });
      await hotelDocumentReference.update({
        "names": FieldValue.arrayRemove(["${uid}_$userName"])
      });
    } else {
      await userDocumentReference.update({
        "hotels": FieldValue.arrayUnion(["${hotelId}_$hotelName"])
      });
      await hotelDocumentReference.update({
        "names": FieldValue.arrayUnion(["${uid}_$userName"])
      });
    }
  }

  Future<void> addLocationItem({
    required String name,
    required String description,
    required String province,
    required String district,
    required String category,
  }) async {
    try {
      await locationCollection.add({
        'name': name,
        'description': description,
        'province': province,
        'district': district,
        'category': category,
      });
    } catch (e) {
      print('Error adding location item: $e');
    }
  }

  Future<List<LocationItem>> getLocationItems({
    required String province,
    required String district,
    required String category,
  }) async {
    try {
      QuerySnapshot querySnapshot = await locationCollection
          .where('province', isEqualTo: province)
          .where('district', isEqualTo: district)
          .where('category', isEqualTo: category)
          .get();

      List<LocationItem> locationItems = querySnapshot.docs.map((doc) {
        return LocationItem(
          name: doc['name'],
          description: doc['description'],
        );
      }).toList();

      return locationItems;
    } catch (e) {
      print('Error fetching location items: $e');
      return [];
    }
  }

  Future<void> updateLocationItem({
    required String documentId,
    required String newName,
    required String newDescription,
  }) async {
    try {
      await locationCollection.doc(documentId).update({
        'name': newName,
        'description': newDescription,
      });
    } catch (e) {
      print('Error updating location item: $e');
    }
  }

  Future<void> deleteLocationItem({required String documentId}) async {
    try {
      await locationCollection.doc(documentId).delete();
    } catch (e) {
      print('Error deleting location item: $e');
    }
  }

  Future<void> addUserData(String name, String email) async {
    try {
      await userCollection.doc(uid).set({
        'name': name,
        'email': email,
      });
    } catch (e) {
      print('Error adding user data: $e');
    }
  }
}

class LocationItem {
  final String name;
  final String description;

  LocationItem({
    required this.name,
    required this.description,
  });
}
