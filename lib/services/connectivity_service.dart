import 'package:nb_utils/nb_utils.dart';

class ConnectivityService {
  static Future<bool> hasInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    log("device connectivityResult : ${connectivityResult}");
    if (connectivityResult.any(
          (element) => element == ConnectivityResult.mobile,
        ) ||
        connectivityResult.any(
          (element) => element == ConnectivityResult.wifi,
        )) {
      return true;
    }
    return false;
  }

  void listenForConnectivityChanges() {
    Connectivity().onConnectivityChanged.listen((result) {
      if (result.any((element) => element == ConnectivityResult.mobile) ||
          result.any((element) => element == ConnectivityResult.wifi)) {
        // Internet connection restored, sync cached data
      }
    });
  }
}
