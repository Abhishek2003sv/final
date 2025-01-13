library default_connector;

// ignore: depend_on_referenced_packages
import 'package:firebase_data_connect/firebase_data_connect.dart';

class DefaultConnector {
  static final ConnectorConfig connectorConfig = ConnectorConfig(
    'asia-south1', // Firebase region
    'firebase_data_connect', // Connector name
    'backend-ab512', // Firebase project ID
  );

  static final DefaultConnector _instance = DefaultConnector._internal();

  factory DefaultConnector() => _instance;

  DefaultConnector._internal()
      : dataConnect = FirebaseDataConnect.instanceFor(
          connectorConfig: connectorConfig,
          sdkType: CallerSDKType.generated,
        );

  final FirebaseDataConnect dataConnect;
}
