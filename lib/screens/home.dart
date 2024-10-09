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
    'Rye': 'राई (Rai)',
    'Millet': 'बाजरा (Bajra)',
    'Sorghum': 'ज्वार (Jowar)',
    'Quinoa': 'क्विनोआ (Kinoa)',
    'Buckwheat': 'कुट्टू (Kuttu)',
    'Amaranth': 'राजगरा (Rajgira)',
    'Spelt': 'स्पेल्ट (Spellt)',
    'Farro': 'फ़ारो (Faro)',
    'Kamut': 'कामुत (Kamut)',
    'Teff': 'टेफ़ (Tef)',
    'Triticale': 'ट्रिटिकल (Tritakal)',
    'Sunflower seeds': 'सूरजमुखी के बीज (Surajmukhi ke bij)',
    'Pumpkin seeds': 'कद्दू के बीज (Kaddu ke bij)',
    'Sesame seeds': 'तिल के बीज (Til ke bij)',
    'Chia seeds': 'चिया के बीज (Chia ke bij)',
    'Flaxseeds': 'अलसी के बीज (Alsi ke bij)',
    'Hemp seeds': 'भांग के बीज (Bhang ke bij)',
    'Mustard': 'सरसों (Sarson)',
    'Cumin': 'जीरा (Jeera)',
    'Coriander': 'धनिया (Dhaniya)',
    'Turmeric': 'हल्दी (Haldi)',
    'Ginger': 'अदरक (Adrak)',
    'Cinnamon': 'दालचीनी (Dalchini)',
    'Cloves': 'लौंग (Laung)',
    'Cardamom': 'इलायची (Elaichi)',
    'Paprika': 'लाल मिर्च (Lal mirch)',
  };

  Map<String, Map<String, dynamic>> selectedQuantities = {};
  String searchQuery = "";

  void _showQuantityDialog(String itemName) {
    double quantity = selectedQuantities[itemName]?['value'] ?? 0.0;
    String unit =
        selectedQuantities[itemName]?['unit'] ?? 'kg'; // Default to kg
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter quantity for $itemName'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter quantity',
                ),
                onChanged: (value) {
                  quantity = double.tryParse(value) ?? 0.0;
                },
              ),
              DropdownButton<String>(
                value: unit,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      unit = newValue;
                    });
                  }
                },
                items: <String>['kg', 'g']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                setState(() {
                  selectedQuantities[itemName] = {
                    'value': quantity,
                    'unit': unit,
                  };
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Filter the items based on the search query
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
            // Add functionality here
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Add functionality here
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
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
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
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

                  return GestureDetector(
                    onTap: () {
                      _showQuantityDialog(itemName);
                    },
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
