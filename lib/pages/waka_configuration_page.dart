import 'package:flutter/material.dart';
import '../model/models.dart';
import './user_configuration.dart';

class WakaConfigurationPage extends StatefulWidget {
  @override
  _WakaConfigurationPage createState() => new _WakaConfigurationPage();
}

class _WakaConfigurationPage
    extends UserConfigurationPage<WakaConfigurationPage> {
  _WakaConfigurationPage() : super('Wakatime');
  final Waka _waka = new Waka(apiKey: '');

  @override
  onUserInitialized() {
    if (user.jira != null && user.waka.apiKey != null) {
      _waka.apiKey = user.waka.apiKey;
    }
  }

  @override
  setToUser() {
    if (user.waka == null) {
      user.waka = new Waka();
    }
    user.waka.apiKey = _waka.apiKey;
  }

  @override
  void deleteAccount() {
    user.waka = null;
    saveUser();
    super.deleteAccount();
  }

  bool hasPreviousValue() {
    return user.waka != null;
  }

  @override
  initialize() {
    formProperties.add(new FormProperty<String>(
        icon: Icons.fingerprint,
        name: 'API Key',
        initialValue: user.waka.apiKey,
        isPassword: false,
        onChange: (String apiKey) {
          user.waka.apiKey = apiKey;
        }));
    super.initialize();
  }
}
