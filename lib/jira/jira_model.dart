class JiraRestException implements Exception {
  int _statusCode;
  String _message;

  int get statusCode => _statusCode;
  String get message => _message;

  JiraRestException(this._statusCode, this._message);

  String toString() => '$statusCode: $message';
}

class AddWorklogRequest {
  DateTime started;
  int timeSpentSeconds;

  AddWorklogRequest({this.started, this.timeSpentSeconds});

  AddWorklogRequest.fromJson(Map<String, dynamic> json) {
    if (json['started'] != null) {
      try {
        started = DateTime.parse(json['started']);
      } on FormatException {
        // do nothing
      }
    }
    timeSpentSeconds = json['timeSpentSeconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.started != null) {
      final formattedDate =
          "${this.started.year.toString()}/${this.started.month.toString().padLeft(2,'0')}/${this.started.day.toString().padLeft(2,'0')}";
      data['started'] = formattedDate;
    }
    data['timeSpentSeconds'] = this.timeSpentSeconds;
    return data;
  }
}

class AddWorklogResponse {
  Author author;
  String comment;
  String created;
  String id;
  String issueId;
  Map<String, dynamic> properties;
  String self;
  String started;
  String timeSpent;
  int timeSpentSeconds;
  Author updateAuthor;
  String updated;
  Visibility visibility;

  AddWorklogResponse(
      {this.author,
      this.comment,
      this.created,
      this.id,
      this.issueId,
      this.properties,
      this.self,
      this.started,
      this.timeSpent,
      this.timeSpentSeconds,
      this.updateAuthor,
      this.updated,
      this.visibility});

  AddWorklogResponse.fromJson(Map<String, dynamic> json) {
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    comment = json['comment'];
    created = json['created'];
    id = json['id'];
    issueId = json['issueId'];
    properties = json['properties'];
    self = json['self'];
    started = json['started'];
    timeSpent = json['timeSpent'];
    timeSpentSeconds = json['timeSpentSeconds'];
    updateAuthor = json['updateAuthor'] != null
        ? new Author.fromJson(json['updateAuthor'])
        : null;
    updated = json['updated'];
    visibility = json['visibility'] != null
        ? new Visibility.fromJson(json['visibility'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    data['comment'] = this.comment;
    data['created'] = this.created;
    data['id'] = this.id;
    data['issueId'] = this.issueId;
    data['properties'] = this.properties;
    data['self'] = this.self;
    data['started'] = this.started;
    data['timeSpent'] = this.timeSpent;
    data['timeSpentSeconds'] = this.timeSpentSeconds;
    if (this.updateAuthor != null) {
      data['updateAuthor'] = this.updateAuthor.toJson();
    }
    data['updated'] = this.updated;
    if (this.visibility != null) {
      data['visibility'] = this.visibility.toJson();
    }
    return data;
  }
}

class AvatarUrls {
  String s48x48;
  String s24x24;
  String s16x16;
  String s32x32;

  AvatarUrls({this.s48x48, this.s24x24, this.s16x16, this.s32x32});

  AvatarUrls.fromJson(Map<String, dynamic> json) {
    s48x48 = json['48x48'];
    s24x24 = json['24x24'];
    s16x16 = json['16x16'];
    s32x32 = json['32x32'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['48x48'] = this.s48x48;
    data['24x24'] = this.s24x24;
    data['16x16'] = this.s16x16;
    data['32x32'] = this.s32x32;
    return data;
  }
}

class Author {
  String self;
  String name;
  String key;
  String accountId;
  String emailAddress;
  AvatarUrls avatarUrls;
  String displayName;
  bool active;
  String timeZone;

  Author(
      {this.self,
      this.name,
      this.key,
      this.accountId,
      this.emailAddress,
      this.avatarUrls,
      this.displayName,
      this.active,
      this.timeZone});

  Author.fromJson(Map<String, dynamic> json) {
    self = json['self'];
    name = json['name'];
    key = json['key'];
    accountId = json['accountId'];
    emailAddress = json['emailAddress'];
    avatarUrls = json['avatarUrls'] != null
        ? new AvatarUrls.fromJson(json['avatarUrls'])
        : null;
    displayName = json['displayName'];
    active = json['active'];
    timeZone = json['timeZone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['self'] = this.self;
    data['name'] = this.name;
    data['key'] = this.key;
    data['accountId'] = this.accountId;
    data['emailAddress'] = this.emailAddress;
    if (this.avatarUrls != null) {
      data['avatarUrls'] = this.avatarUrls.toJson();
    }
    data['displayName'] = this.displayName;
    data['active'] = this.active;
    data['timeZone'] = this.timeZone;
    return data;
  }
}

class Visibility {
  String type;
  String value;

  Visibility({this.type, this.value});

  Visibility.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }
}

class SearchIssueRequest {
  String jql;
  int startAt;
  int maxResults;
  List<String> fields;

  SearchIssueRequest({this.jql, this.startAt, this.maxResults, this.fields});

  SearchIssueRequest.fromJson(Map<String, dynamic> json) {
    jql = json['jql'];
    startAt = json['startAt'];
    maxResults = json['maxResults'];
    fields = json['fields'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jql'] = this.jql;
    data['startAt'] = this.startAt;
    data['maxResults'] = this.maxResults;
    data['fields'] = this.fields;
    return data;
  }
}

class SearchIssueResponse {
  String expand;
  int startAt;
  int maxResults;
  int total;
  List<Issues> issues;

  SearchIssueResponse(
      {this.expand, this.startAt, this.maxResults, this.total, this.issues});

  SearchIssueResponse.fromJson(Map<String, dynamic> json) {
    expand = json['expand'];
    startAt = json['startAt'];
    maxResults = json['maxResults'];
    total = json['total'];
    if (json['issues'] != null) {
      issues = new List<Issues>();
      json['issues'].forEach((v) {
        issues.add(new Issues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expand'] = this.expand;
    data['startAt'] = this.startAt;
    data['maxResults'] = this.maxResults;
    data['total'] = this.total;
    if (this.issues != null) {
      data['issues'] = this.issues.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Issues {
  String expand;
  String id;
  String self;
  String key;
  Fields fields;

  Issues({this.expand, this.id, this.self, this.key, this.fields});

  Issues.fromJson(Map<String, dynamic> json) {
    expand = json['expand'];
    id = json['id'];
    self = json['self'];
    key = json['key'];
    fields =
        json['fields'] != null ? new Fields.fromJson(json['fields']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expand'] = this.expand;
    data['id'] = this.id;
    data['self'] = this.self;
    data['key'] = this.key;
    if (this.fields != null) {
      data['fields'] = this.fields.toJson();
    }
    return data;
  }
}

class Fields {
  Worklog worklog;
  Status status;

  Fields({this.worklog, this.status});

  Fields.fromJson(Map<String, dynamic> json) {
    worklog =
        json['worklog'] != null ? new Worklog.fromJson(json['worklog']) : null;
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.worklog != null) {
      data['worklog'] = this.worklog.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    return data;
  }
}

class Worklog {
  int startAt;
  int maxResults;
  int total;
  List<Worklogs> worklogs;

  Worklog({this.startAt, this.maxResults, this.total, this.worklogs});

  Worklog.fromJson(Map<String, dynamic> json) {
    startAt = json['startAt'];
    maxResults = json['maxResults'];
    total = json['total'];
    if (json['worklogs'] != null) {
      worklogs = new List<Worklogs>();
      json['worklogs'].forEach((v) {
        worklogs.add(new Worklogs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startAt'] = this.startAt;
    data['maxResults'] = this.maxResults;
    data['total'] = this.total;
    if (this.worklogs != null) {
      data['worklogs'] = this.worklogs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Worklogs {
  String self;
  Author author;
  Author updateAuthor;
  String created;
  String updated;
  String started;
  String timeSpent;
  int timeSpentSeconds;
  String id;
  String issueId;

  Worklogs(
      {this.self,
      this.author,
      this.updateAuthor,
      this.created,
      this.updated,
      this.started,
      this.timeSpent,
      this.timeSpentSeconds,
      this.id,
      this.issueId});

  Worklogs.fromJson(Map<String, dynamic> json) {
    self = json['self'];
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    updateAuthor = json['updateAuthor'] != null
        ? new Author.fromJson(json['updateAuthor'])
        : null;
    created = json['created'];
    updated = json['updated'];
    started = json['started'];
    timeSpent = json['timeSpent'];
    timeSpentSeconds = json['timeSpentSeconds'];
    id = json['id'];
    issueId = json['issueId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['self'] = this.self;
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    if (this.updateAuthor != null) {
      data['updateAuthor'] = this.updateAuthor.toJson();
    }
    data['created'] = this.created;
    data['updated'] = this.updated;
    data['started'] = this.started;
    data['timeSpent'] = this.timeSpent;
    data['timeSpentSeconds'] = this.timeSpentSeconds;
    data['id'] = this.id;
    data['issueId'] = this.issueId;
    return data;
  }
}

class Status {
  String self;
  String description;
  String iconUrl;
  String name;
  String id;
  StatusCategory statusCategory;

  Status(
      {this.self,
      this.description,
      this.iconUrl,
      this.name,
      this.id,
      this.statusCategory});

  Status.fromJson(Map<String, dynamic> json) {
    self = json['self'];
    description = json['description'];
    iconUrl = json['iconUrl'];
    name = json['name'];
    id = json['id'];
    statusCategory = json['statusCategory'] != null
        ? new StatusCategory.fromJson(json['statusCategory'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['self'] = this.self;
    data['description'] = this.description;
    data['iconUrl'] = this.iconUrl;
    data['name'] = this.name;
    data['id'] = this.id;
    if (this.statusCategory != null) {
      data['statusCategory'] = this.statusCategory.toJson();
    }
    return data;
  }
}

class StatusCategory {
  String self;
  int id;
  String key;
  String colorName;
  String name;

  StatusCategory({this.self, this.id, this.key, this.colorName, this.name});

  StatusCategory.fromJson(Map<String, dynamic> json) {
    self = json['self'];
    id = json['id'];
    key = json['key'];
    colorName = json['colorName'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['self'] = this.self;
    data['id'] = this.id;
    data['key'] = this.key;
    data['colorName'] = this.colorName;
    data['name'] = this.name;
    return data;
  }
}
