import 'package:flutter/material.dart';

import './user_configuration.dart';

class HarvestConfigurationPage extends StatefulWidget {
  @override
  _HarvestConfigurationPage createState() => new _HarvestConfigurationPage();
}

class _HarvestConfigurationPage
    extends UserConfigurationPage<HarvestConfigurationPage> {
  _HarvestConfigurationPage() : super();

  @override
  initialize() {
    controllers.add(new ControllableFormProperty(new FormProperty<String>(
        icon: Icons.home,
        name: 'Subdomain',
        keyboardType: TextInputType.url,
        initialValue: user.harvest.subdomain,
        isPassword: false,
        onChange: (String subdomain) {
          user.harvest.subdomain = subdomain;
        })));
    controllers
        .add(new ControllableFormProperty(new FormProperty<String>.account(
            name: 'Account id',
            initialValue: user.harvest.accountId,
            onChange: (String accountId) {
              user.harvest.accountId = accountId;
            })));
    controllers.add(new ControllableFormProperty(new FormProperty<String>.token(
        name: 'Token',
        initialValue: user.harvest.token,
        onChange: (String token) {
          user.harvest.token = token;
        })));
    super.initialize();
  }
}
