import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  final List<Map<String, dynamic>> historyData;

  const DrawerWidget({super.key, required this.historyData});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'History',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ...historyData.map((entry) {
            return ListTile(
              title: Text(
                  '${entry['item']} - ${entry['quantity']} ${entry['unit']}'),
              subtitle: Text(
                  'Name: ${entry['name']} | Phone: ${entry['phone']} | Date: ${entry['date']}'),
            );
          }).toList(),
        ],
      ),
    );
  }
}
