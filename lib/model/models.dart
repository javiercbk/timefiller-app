abstract class JSONSerializable {
  JSONSerializable();
  JSONSerializable.fromJSON(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}

class Jira extends JSONSerializable {
  String host;
  String username;
  String password;

  Jira() {
    host = '';
    username = '';
    password = '';
  }

  Jira.fromJson(Map<String, dynamic> json)
      : host = json['host'],
        username = json['username'],
        password = json['password'];

  Map<String, dynamic> toJson() =>
      {host: 'host', username: 'username', password: 'password'};

  bool get completed {
    final completedHost = host != null && host.isNotEmpty;
    final completedUsername = username != null && username.isNotEmpty;
    final completedPassword = password != null && password.isNotEmpty;
    return completedHost && completedUsername && completedPassword;
  }
}

class Harvest extends JSONSerializable {
  String subdomain;
  String accountId;
  String token;

  Harvest() {
    subdomain = '';
    accountId = '';
    token = '';
  }

  Harvest.fromJson(Map<String, dynamic> json)
      : subdomain = json['subdomain'],
        accountId = json['accountId'],
        token = json['token'];

  Map<String, dynamic> toJson() =>
      {subdomain: 'subdomain', accountId: 'accountId', token: 'token'};

  bool get completed {
    final completedSubdomain = subdomain != null && subdomain.isNotEmpty;
    final completedEmail = accountId != null && accountId.isNotEmpty;
    final completedPassword = accountId != null && accountId.isNotEmpty;
    return completedSubdomain && completedEmail && completedPassword;
  }
}

class Waka extends JSONSerializable {
  String apiKey;

  Waka() {
    apiKey = '';
  }

  Waka.fromJson(Map<String, dynamic> json) : apiKey = json['apiKey'];

  Map<String, dynamic> toJson() => {apiKey: 'apiKey'};

  bool get completed {
    return apiKey != null && apiKey.isNotEmpty;
  }
}

class User extends JSONSerializable {
  Jira jira;
  Harvest harvest;
  Waka waka;

  User() {
    jira = new Jira();
    harvest = new Harvest();
    waka = new Waka();
  }

  User.fromJson(Map<String, dynamic> json) {
    this.jira = new Jira.fromJson(json['jira']);
    this.harvest = new Harvest.fromJson(json['harvest']);
    this.waka = new Waka.fromJson(json['waka']);
  }

  Map<String, dynamic> toJson() => {
        'jira': this.jira.toJson(),
        'harvest': this.harvest.toJson(),
        'waka': this.waka.toJson()
      };

  bool get completed {
    final jiraCompleted = jira != null && jira.completed;
    final harvestCompleted = harvest != null && harvest.completed;
    final wakaCompleted = waka != null && waka.completed;
    return jiraCompleted && harvestCompleted && wakaCompleted;
  }
}

class Worklog extends JSONSerializable {
  int id;
  String ticket;
  int hours;
  DateTime date;

  Worklog.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id'], radix: 10),
        ticket = json['ticket'],
        hours = int.parse(json['hours'], radix: 10),
        date = DateTime.parse(json['date']);

  Map<String, dynamic> toJson() => {
        id.toString(): 'id',
        ticket: 'ticket',
        hours.toString(): 'hours',
        date.toIso8601String(): 'date'
      };
}
