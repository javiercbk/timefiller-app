import 'package:flutter/material.dart';

import './user_configuration.dart';

class WakaConfigurationPage extends StatefulWidget {
  @override
  _WakaConfigurationPage createState() => new _WakaConfigurationPage();
}

class _WakaConfigurationPage
    extends UserConfigurationPage<WakaConfigurationPage> {
  _WakaConfigurationPage() : super();

  @override
  initialize() {
    controllers.add(new ControllableFormProperty(new FormProperty<String>(
        icon: Icons.fingerprint,
        name: 'API Key',
        initialValue: user.waka.apiKey,
        isPassword: false,
        onChange: (String apiKey) {
          user.waka.apiKey = apiKey;
        })));
    super.initialize();
  }
}
