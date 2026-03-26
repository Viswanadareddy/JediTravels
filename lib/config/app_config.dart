import 'package:flutter/foundation.dart' show kIsWeb;

class AppConfig {
  static String get baseUrl{
    if (kIsWeb){
      return 'http://127.0.0.1:5000';
    }
    return 'http://10.0.2.2:5000';
  } 
  // Android emulator -> local backend
  // later replace with deployed backend URL

  // true = use Flask backend
  // false = use Firestore
  static const bool useBackendHotels = true;
}