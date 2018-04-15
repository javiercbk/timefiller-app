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
    controllers.add(new ControllableFormProperty(new FormProperty<String>.email(
        name: 'Email',
        initialValue: user.harvest.email,
        onChange: (String email) {
          user.harvest.email = email;
        })));
    controllers
        .add(new ControllableFormProperty(new FormProperty<String>.password(
            name: 'Password',
            onChange: (String password) {
              user.harvest.password = password;
            })));
    super.initialize();
  }
}
