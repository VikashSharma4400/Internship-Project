import 'package:flutter/material.dart';

import 'HomePage.dart';


class CitySelectionPage extends StatefulWidget {
  const CitySelectionPage({super.key});

  @override
  _CitySelectionPageState createState() => _CitySelectionPageState();
}

class _CitySelectionPageState extends State<CitySelectionPage> {
  String selectedCity = ""; // Variable to store the selected city

  final List<String> cities =
  [
    'New Delhi', 'Agra', 'Lucknow',
    'Mathura', 'Noida', 'Kanpur',
    'Jaipur', 'Bharatpur', 'Prayagraj',
    'Chennai', 'Mumbai', 'Bengaluru',
     'Hyderabad', 'Pune', 'Ahmedabad',
    'Kolkata', 'Kochi', 'Dhanbad',
    'Patna', 'Chandigarh', 'Indore',
    'Bhopal', 'Gurugram', 'Mysuru',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a City'),
      ),
      body: ListView(
        children: cities.map((city) {
          return ListTile(
            title: Text(city),
            onTap: () {
              setState(() {
                selectedCity = city;
              });
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(selectedCity: selectedCity)));
            },
          );
        }).toList(),
      ),
    );
  }
}