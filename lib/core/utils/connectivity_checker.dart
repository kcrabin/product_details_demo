import 'package:internet_connection_checker/internet_connection_checker.dart';

Future<bool> checkInternetConnection() async {
  var connectivityResult = await InternetConnectionChecker().hasConnection;
  if (connectivityResult == false) {
    return false;
  } else {
    return true;
  }
}
