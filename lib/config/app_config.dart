class AppConfig {
  static const String baseUrl = 'http://10.0.2.2:5000'; 
  // Android emulator -> local backend
  // later replace with deployed backend URL

  // true = use Flask backend
  // false = use Firestore
  static const bool useBackendHotels = true;
}