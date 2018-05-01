abstract class JSONSerializable {
  JSONSerializable();
  JSONSerializable.fromJSON(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}

class Jira extends JSONSerializable {
  String host;
  String username;
  String password;

  Jira({this.host, this.username, this.password});

  Jira.fromJson(Map<String, dynamic> json) {
    host = json['host'];
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['host'] = this.host;
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }
}

class Harvest extends JSONSerializable {
  String subdomain;
  String accountId;
  String token;

  Harvest({this.subdomain, this.accountId, this.token});

  Harvest.fromJson(Map<String, dynamic> json) {
    subdomain = json['subdomain'];
    accountId = json['accountId'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subdomain'] = this.subdomain;
    data['accountId'] = this.accountId;
    data['token'] = this.token;
    return data;
  }
}

class Waka extends JSONSerializable {
  String apiKey;

  Waka({this.apiKey});

  Waka.fromJson(Map<String, dynamic> json) {
    apiKey = json['apiKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apiKey'] = this.apiKey;
    return data;
  }
}

class User extends JSONSerializable {
  Jira jira;
  Harvest harvest;
  Waka waka;

  User();

  User.fromJson(Map<String, dynamic> json) {
    if (json['jira'] != null) {
      jira = new Jira.fromJson(json['jira']);
    }
    if (json['harvest'] != null) {
      harvest = new Harvest.fromJson(json['harvest']);
    }
    if (json['waka'] != null) {
      waka = new Waka.fromJson(json['waka']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (jira != null) {
      data['jira'] = jira.toJson();
    }
    if (harvest != null) {
      data['harvest'] = harvest.toJson();
    }
    if (waka != null) {
      data['waka'] = waka.toJson();
    }
    return data;
  }

  bool get hasTargetTimeTracker {
    return jira != null || harvest != null;
  }

  bool get hasSourceTimeTracker {
    return waka != null;
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
