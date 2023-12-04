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
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('hotels').snapshots();
  late final DatabaseManager _db;
  late List<LocationItem> locationItems = [];

  @override
  void initState() {
    super.initState();
    // Check if the user is authenticated
    FirebaseAuth.User? user = FirebaseAuth.FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Redirect to login page
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      // User is authenticated, proceed with initializing the page
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

  void _viewOnMapButtonPressed() {
    // Navigate to the MapPage with location items
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MapPage(locationItems: locationItems),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
       if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");

        }
        // print(snapshot.data()!.docs);
        return Scaffold(
      appBar: AppBar(
        title: Text('Locations - ${widget.category} in ${widget.district}'),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: _viewOnMapButtonPressed,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
      
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [ 
            SizedBox(height: 200.0, child: ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          print(data);
            return ListTile(
              title: Text(data['name']),
              subtitle: Text(data['Cost'].toString()),
            );
          }).toList(),
        ),)
             ,
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
          ],
        ),
      ),
    );
    });
     
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
                image: AssetImage('assets/location_image.jpg'), // Change this based on your images
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
