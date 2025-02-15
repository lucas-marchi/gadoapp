import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityService {
  static final Connectivity _connectivity = Connectivity();
  static final InternetConnectionChecker connectionChecker = InternetConnectionChecker();

  static Stream<bool> get connectionStream => _connectivity.onConnectivityChanged
      .asyncMap((result) => result != ConnectivityResult.none)
      .asyncMap((hasConnection) async => hasConnection && await connectionChecker.hasConnection);
}