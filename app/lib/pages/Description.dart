import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;
import '../datamanagers/database_manager.dart';
import 'maps.dart';

class DescriptionPage extends StatefulWidget {
  final String province;
  final String district;
  final String category;

  const DescriptionPage({
    Key? key,
    required this.province,
    required this.district,
    required this.category,
  }) : super(key: key);

  @override
  _DescriptionPageState createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  late final DatabaseManager _db;
  late List<LocationItem> locationItems = [];

  // Create a CollectionReference called hotels that references the firestore collection
  CollectionReference hotelsRef =
      FirebaseFirestore.instance.collection('hotels');

  // Add hotel
  Future<void> addHotel() {
    return hotelsRef
        .add({
          'name': 'New Hotel',
          'Cost': 100,
        })
        .then((value) => print("Hotel Added"))
        .catchError((error) => print("Failed to add hotel: $error"));
  }

  // Delete hotel
  Future<void> deleteHotel(String hotelId) {
    return hotelsRef
        .doc(hotelId)
        .delete()
        .then((value) => print("Hotel Deleted"))
        .catchError((error) => print("Failed to delete hotel: $error"));
  }

  // Update hotel
  Future<void> updateHotel(String hotelId, String newName) {
    return hotelsRef
        .doc(hotelId)
        .update({'name': newName})
        .then((value) => print("Hotel Updated"))
        .catchError((error) => print("Failed to update hotel: $error"));
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.User? user = FirebaseAuth.FirebaseAuth.instance.currentUser;

    if (user != null) {
      _db = DatabaseManager(uid: user.uid);
      loadLocationItems();
    }
  }

  Future<void> loadLocationItems() async {
    try {
      locationItems = await _db.getLocationItems(
        province: widget.province,
        district: widget.district,
        category: widget.category,
      );
      setState(() {});
    } catch (e) {
      print('Error loading location items: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Locations - ${widget.category} in ${widget.district}'),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MapPage(locationItems: locationItems),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: hotelsRef.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return SizedBox(
                  height: 350.0,
                  child: ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      final myController = TextEditingController();

                      return Column(children: [
                        GestureDetector(
                          onTap: () {
                            deleteHotel(document.id);
                          },
                          child: Text(data['name']),
                        ),
                        Text(data['Cost'].toString()),
                        TextField(
                          controller: myController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Update Hotel',
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              updateHotel(document.id, myController.text);
                            },
                            child: Text('Update')),
                        SizedBox(height: 20.0)
                      ]);
                    }).toList(),
                  ),
                );
              },
            ),
            TextButton(
              onPressed: () {
                addHotel();
              },
              child: Text(
                "Add Hotel",
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              widget.category,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: locationItems.length,
                itemBuilder: (context, index) {
                  return LocationItemCard(item: locationItems[index]);
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          MapPage(locationItems: locationItems),
                    ),
                  );
                },
                icon: const Icon(Icons.search, color: Colors.black),
                label: const Text('View on Map'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: const Color(0xFFe6aa07),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  elevation: 4.0,
                ),
              ),
            ),
            // TextButton to navigate to the MapPage
            
          ],
        ),
      ),
    );
  }
}

class LocationItemCard extends StatelessWidget {
  final LocationItem item;

  const LocationItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: const Color(0xFFFFFFFF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              image: DecorationImage(
                image: AssetImage(
                    'assets/location_image.jpg'), // Change this based on your images
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Description:',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  item.description,
                  style: TextStyle(
                    fontSize: 10.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
