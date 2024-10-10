import 'package:url_launcher/url_launcher.dart';

class WhatsAppHelper {
  static Future<void> sendDataToWhatsApp(String name, String phone,
      String itemName, double quantity, String unit) async {
    String message =
        'Name: $name\nPhone: $phone\nItem: $itemName\nQuantity: $quantity $unit';
    String url = 'https://wa.me/$phone?text=${Uri.encodeComponent(message)}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open WhatsApp';
    }
  }
}
