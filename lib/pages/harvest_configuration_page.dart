import 'package:flutter/material.dart';
import '../model/models.dart';
import './user_configuration.dart';

class HarvestConfigurationPage extends StatefulWidget {
  @override
  _HarvestConfigurationPage createState() => new _HarvestConfigurationPage();
}

class _HarvestConfigurationPage
    extends UserConfigurationPage<HarvestConfigurationPage> {
  _HarvestConfigurationPage() : super('Harvest');
  final Harvest _harvest = new Harvest(accountId: '', subdomain: '', token: '');

  @override
  setToUser() {
    if (user.harvest == null) {
      user.harvest = new Harvest();
    }
    user.harvest.accountId = _harvest.accountId;
    user.harvest.subdomain = _harvest.subdomain;
    user.harvest.token = _harvest.token;
  }

  @override
  void deleteAccount() {
    user.harvest = null;
    saveUser();
    super.deleteAccount();
  }

  bool hasPreviousValue() {
    return user.harvest != null;
  }

  @override
  initialize() async {
    await super.initialize();
    setState(() {
      if (user.harvest != null) {
        if (user.harvest.accountId != null) {
          _harvest.accountId = user.harvest.accountId;
        }
        if (user.harvest.subdomain != null) {
          _harvest.subdomain = user.harvest.subdomain;
        }
      }
      formProperties.add(new FormProperty<String>(
          icon: Icons.home,
          name: 'Subdomain',
          keyboardType: TextInputType.url,
          initialValue: _harvest.subdomain,
          isPassword: false,
          onChange: (String subdomain) {
            _harvest.subdomain = subdomain;
          }));
      formProperties.add(new FormProperty<String>.account(
          name: 'Account id',
          initialValue: _harvest.accountId,
          onChange: (String accountId) {
            _harvest.accountId = accountId;
          }));
      formProperties.add(new FormProperty<String>.token(
          name: 'Token',
          initialValue: _harvest.token,
          onChange: (String token) {
            _harvest.token = token;
          }));
    });
  }
}
