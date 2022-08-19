import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkConnection {
  static Future<bool> checkConnection() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile) {
      return true;
    } else if (result == ConnectivityResult.wifi) {
      return true;
    } else if (result == ConnectivityResult.ethernet) {
      return true;
    } else if (result == ConnectivityResult.none) {
      return false;
    }
    return false;
  }
}
