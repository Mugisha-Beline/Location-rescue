import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'description.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  final CollectionReference searchCollection =
      FirebaseFirestore.instance.collection('searches');

  void _searchButtonPressed(BuildContext context) async {
    try {
      final String province = provinceController.text.trim();
      final String district = districtController.text.trim();
      final String category = categoryController.text.trim();

      if (province.isNotEmpty && district.isNotEmpty && category.isNotEmpty) {
        // Perform CRUD operation - save the search parameters to Firestore
        await searchCollection.add({
          'province': province,
          'district': district,
          'category': category,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Navigate to the DescriptionPage with search parameters
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DescriptionPage(
              province: province,
              district: district,
              category: category,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter all the fields.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('Error during search: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 4.0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.black,
            height: 1.0,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Handle back button press
          },
        ),
        title: const Text(
          'Home',
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Welcome to Location Rescue',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Color(0xFFe6aa60),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Are you in a new location in Rwanda and wondering where you can get accommodation, meals, gallery collections, entertainment houses, or recreation areas? We got you covered!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: provinceController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your Rwanda province',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: districtController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your district',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter category',
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _searchButtonPressed(context);
                  },
                  icon: const Icon(Icons.search, color: Colors.black),
                  label: const Text('Search'),
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
            ],
          ),
        ),
      ),
    );
  }
}
