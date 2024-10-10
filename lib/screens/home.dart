import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final Map<String, String> items = {
    'Rice': 'चावल (Chawal)',
    'Wheat': 'गेहूं (Gehun)',
    'Barley': 'जौ (Jau)',
    'Oats': 'जई (Jai)',
    'Corn': 'मक्का (Makka)',
    'Millet': 'बाजरा (Bajra)',
    'Mustard': 'सरसों (Sarson)',
    'Cumin': 'जीरा (Jeera)',
    'Turmeric': 'हल्दी (Haldi)',
    'Ginger': 'अदरक (Adrak)',
  };

  Map<String, Map<String, dynamic>> selectedQuantities = {};
  String searchQuery = "";

  // Function to display the quantity dialog
  void _showQuantityDialog(String itemName) {
    String name = selectedQuantities[itemName]?['name'] ?? '';
    String phone = selectedQuantities[itemName]?['phone'] ?? '';
    double quantity = selectedQuantities[itemName]?['value'] ?? 0.0;
    String unit = selectedQuantities[itemName]?['unit'] ?? 'kg';

    showDialog(
      context: context,
      builder: (context) => QuantityDialog(
        itemName: itemName,
        initialName: name,
        initialPhone: phone,
        initialQuantity: quantity,
        initialUnit: unit,
        onSave: (updatedName, updatedPhone, updatedQuantity, updatedUnit) {
          setState(() {
            selectedQuantities[itemName] = {
              'name': updatedName,
              'phone': updatedPhone,
              'value': updatedQuantity,
              'unit': updatedUnit,
            };
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = items.keys
        .where((item) => item.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF444444),
        title: const Text(
          'MillMate',
          style: TextStyle(
            fontWeight: FontWeight.w100,
            fontSize: 24,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        elevation: 5,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Add functionality for sidebar here
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Add functionality for notifications here
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 10),
            Expanded(
              child: _buildGridView(filteredItems),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              searchQuery = ""; // Clear the search when back is pressed
            });
          },
        ),
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Search...',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGridView(List<String> filteredItems) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of items in a row
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 2 / 2.3, // Adjusts the size of the boxes
      ),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        String itemName = filteredItems[index];
        String itemTranslation = items[itemName]!;

        return ItemCard(
          itemName: itemName,
          itemTranslation: itemTranslation,
          onTap: () => _showQuantityDialog(itemName),
        );
      },
    );
  }
}

// Separate widget for the Quantity Dialog
class QuantityDialog extends StatelessWidget {
  final String itemName;
  final String initialName;
  final String initialPhone;
  final double initialQuantity;
  final String initialUnit;
  final Function(String, String, double, String) onSave;

  const QuantityDialog({
    super.key,
    required this.itemName,
    required this.initialName,
    required this.initialPhone,
    required this.initialQuantity,
    required this.initialUnit,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    String name = initialName;
    String phone = initialPhone;
    double quantity = initialQuantity;
    String unit = initialUnit;

    return AlertDialog(
      title: Text('Enter details for $itemName'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter Name',
                labelText: 'Name',
              ),
              onChanged: (value) => name = value,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter Phone',
                labelText: 'Phone',
              ),
              keyboardType: TextInputType.phone,
              onChanged: (value) => phone = value,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter quantity',
              ),
              onChanged: (value) => quantity = double.tryParse(value) ?? 0.0,
            ),
            DropdownButton<String>(
              value: unit,
              onChanged: (newValue) {
                if (newValue != null) {
                  unit = newValue;
                }
              },
              items: <String>['kg', 'g'].map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            onSave(name, phone, quantity, unit);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

// Separate widget for the Item Card
class ItemCard extends StatelessWidget {
  final String itemName;
  final String itemTranslation;
  final VoidCallback onTap;

  const ItemCard({
    super.key,
    required this.itemName,
    required this.itemTranslation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                itemName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                itemTranslation,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
