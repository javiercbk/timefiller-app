class SummaryResponse {
  List<Data> data;
  DateTime start;
  DateTime end;

  SummaryResponse({this.data, this.start, this.end});

  SummaryResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    if (json['start'] != null) {
      try {
        start = DateTime.parse(json['start']);
      } on FormatException {
        // do nothing
      }
    }
    if (json['end'] != null) {
      try {
        end = DateTime.parse(json['end']);
      } on FormatException {
        // do nothing
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.start != null) {
      data['start'] = this.start.toIso8601String();
    }
    if (this.end != null) {
      data['end'] = this.end.toIso8601String();
    }
    return data;
  }
}

class Data {
  GrandTotal grandTotal;
  List<Projects> projects;
  List<Languages> languages;
  List<Editors> editors;
  List<OperatingSystems> operatingSystems;
  List<Dependencies> dependencies;
  List<Branches> branches;
  List<Entities> entities;
  Range range;

  Data(
      {this.grandTotal,
      this.projects,
      this.languages,
      this.editors,
      this.operatingSystems,
      this.dependencies,
      this.branches,
      this.entities,
      this.range});

  Data.fromJson(Map<String, dynamic> json) {
    grandTotal = json['grand_total'] != null
        ? new GrandTotal.fromJson(json['grand_total'])
        : null;
    if (json['projects'] != null) {
      projects = new List<Projects>();
      json['projects'].forEach((v) {
        projects.add(new Projects.fromJson(v));
      });
    }
    if (json['languages'] != null) {
      languages = new List<Languages>();
      json['languages'].forEach((v) {
        languages.add(new Languages.fromJson(v));
      });
    }
    if (json['editors'] != null) {
      editors = new List<Editors>();
      json['editors'].forEach((v) {
        editors.add(new Editors.fromJson(v));
      });
    }
    if (json['operating_systems'] != null) {
      operatingSystems = new List<OperatingSystems>();
      json['operating_systems'].forEach((v) {
        operatingSystems.add(new OperatingSystems.fromJson(v));
      });
    }
    if (json['dependencies'] != null) {
      dependencies = new List<Dependencies>();
      json['dependencies'].forEach((v) {
        dependencies.add(new Dependencies.fromJson(v));
      });
    }
    if (json['branches'] != null) {
      branches = new List<Branches>();
      json['branches'].forEach((v) {
        branches.add(new Branches.fromJson(v));
      });
    }
    if (json['entities'] != null) {
      entities = new List<Entities>();
      json['entities'].forEach((v) {
        entities.add(new Entities.fromJson(v));
      });
    }
    range = json['range'] != null ? new Range.fromJson(json['range']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.grandTotal != null) {
      data['grand_total'] = this.grandTotal.toJson();
    }
    if (this.projects != null) {
      data['projects'] = this.projects.map((v) => v.toJson()).toList();
    }
    if (this.languages != null) {
      data['languages'] = this.languages.map((v) => v.toJson()).toList();
    }
    if (this.editors != null) {
      data['editors'] = this.editors.map((v) => v.toJson()).toList();
    }
    if (this.operatingSystems != null) {
      data['operating_systems'] =
          this.operatingSystems.map((v) => v.toJson()).toList();
    }
    if (this.dependencies != null) {
      data['dependencies'] = this.dependencies.map((v) => v.toJson()).toList();
    }
    if (this.branches != null) {
      data['branches'] = this.branches.map((v) => v.toJson()).toList();
    }
    if (this.entities != null) {
      data['entities'] = this.entities.map((v) => v.toJson()).toList();
    }
    if (this.range != null) {
      data['range'] = this.range.toJson();
    }
    return data;
  }
}

class GrandTotal {
  String digital;
  int hours;
  int minutes;
  String text;
  int totalSeconds;

  GrandTotal(
      {this.digital, this.hours, this.minutes, this.text, this.totalSeconds});

  GrandTotal.fromJson(Map<String, dynamic> json) {
    digital = json['digital'];
    hours = json['hours'];
    minutes = json['minutes'];
    text = json['text'];
    totalSeconds = json['total_seconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['digital'] = this.digital;
    data['hours'] = this.hours;
    data['minutes'] = this.minutes;
    data['text'] = this.text;
    data['total_seconds'] = this.totalSeconds;
    return data;
  }
}

class Projects {
  String name;
  int totalSeconds;
  double percent;
  String digital;
  String text;
  int hours;
  int minutes;

  Projects(
      {this.name,
      this.totalSeconds,
      this.percent,
      this.digital,
      this.text,
      this.hours,
      this.minutes});

  Projects.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    totalSeconds = json['total_seconds'];

    percent = json['percent'];
    digital = json['digital'];
    text = json['text'];
    hours = json['hours'];
    minutes = json['minutes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['total_seconds'] = this.totalSeconds;
    data['percent'] = this.percent;
    data['digital'] = this.digital;
    data['text'] = this.text;
    data['hours'] = this.hours;
    data['minutes'] = this.minutes;
    return data;
  }
}

class Languages {
  String name;
  int totalSeconds;
  double percent;
  String digital;
  String text;
  int hours;
  int minutes;
  int seconds;

  Languages(
      {this.name,
      this.totalSeconds,
      this.percent,
      this.digital,
      this.text,
      this.hours,
      this.minutes,
      this.seconds});

  Languages.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    totalSeconds = json['total_seconds'];
    percent = json['percent'];
    digital = json['digital'];
    text = json['text'];
    hours = json['hours'];
    minutes = json['minutes'];
    seconds = json['seconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['total_seconds'] = this.totalSeconds;
    data['percent'] = this.percent;
    data['digital'] = this.digital;
    data['text'] = this.text;
    data['hours'] = this.hours;
    data['minutes'] = this.minutes;
    data['seconds'] = this.seconds;
    return data;
  }
}

class Editors {
  String name;
  int totalSeconds;
  double percent;
  String digital;
  String text;
  int hours;
  int minutes;
  int seconds;

  Editors(
      {this.name,
      this.totalSeconds,
      this.percent,
      this.digital,
      this.text,
      this.hours,
      this.minutes,
      this.seconds});

  Editors.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    totalSeconds = json['total_seconds'];
    percent = json['percent'];
    digital = json['digital'];
    text = json['text'];
    hours = json['hours'];
    minutes = json['minutes'];
    seconds = json['seconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['total_seconds'] = this.totalSeconds;
    data['percent'] = this.percent;
    data['digital'] = this.digital;
    data['text'] = this.text;
    data['hours'] = this.hours;
    data['minutes'] = this.minutes;
    data['seconds'] = this.seconds;
    return data;
  }
}

class OperatingSystems {
  String name;
  int totalSeconds;
  double percent;
  String digital;
  String text;
  int hours;
  int minutes;
  int seconds;

  OperatingSystems(
      {this.name,
      this.totalSeconds,
      this.percent,
      this.digital,
      this.text,
      this.hours,
      this.minutes,
      this.seconds});

  OperatingSystems.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    totalSeconds = json['total_seconds'];
    percent = json['percent'];
    digital = json['digital'];
    text = json['text'];
    hours = json['hours'];
    minutes = json['minutes'];
    seconds = json['seconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['total_seconds'] = this.totalSeconds;
    data['percent'] = this.percent;
    data['digital'] = this.digital;
    data['text'] = this.text;
    data['hours'] = this.hours;
    data['minutes'] = this.minutes;
    data['seconds'] = this.seconds;
    return data;
  }
}

class Dependencies {
  String name;
  int totalSeconds;
  double percent;
  String digital;
  String text;
  int hours;
  int minutes;
  int seconds;

  Dependencies(
      {this.name,
      this.totalSeconds,
      this.percent,
      this.digital,
      this.text,
      this.hours,
      this.minutes,
      this.seconds});

  Dependencies.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    totalSeconds = json['total_seconds'];
    percent = json['percent'];
    digital = json['digital'];
    text = json['text'];
    hours = json['hours'];
    minutes = json['minutes'];
    seconds = json['seconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['total_seconds'] = this.totalSeconds;
    data['percent'] = this.percent;
    data['digital'] = this.digital;
    data['text'] = this.text;
    data['hours'] = this.hours;
    data['minutes'] = this.minutes;
    data['seconds'] = this.seconds;
    return data;
  }
}

class Branches {
  String name;
  int totalSeconds;
  double percent;
  String digital;
  String text;
  int hours;
  int minutes;
  int seconds;

  Branches(
      {this.name,
      this.totalSeconds,
      this.percent,
      this.digital,
      this.text,
      this.hours,
      this.minutes,
      this.seconds});

  Branches.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    totalSeconds = json['total_seconds'];
    percent = json['percent'];
    digital = json['digital'];
    text = json['text'];
    hours = json['hours'];
    minutes = json['minutes'];
    seconds = json['seconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['total_seconds'] = this.totalSeconds;
    data['percent'] = this.percent;
    data['digital'] = this.digital;
    data['text'] = this.text;
    data['hours'] = this.hours;
    data['minutes'] = this.minutes;
    data['seconds'] = this.seconds;
    return data;
  }
}

class Entities {
  String name;
  int totalSeconds;
  double percent;
  String digital;
  String text;
  int hours;
  int minutes;
  int seconds;

  Entities(
      {this.name,
      this.totalSeconds,
      this.percent,
      this.digital,
      this.text,
      this.hours,
      this.minutes,
      this.seconds});

  Entities.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    totalSeconds = json['total_seconds'];
    percent = json['percent'];
    digital = json['digital'];
    text = json['text'];
    hours = json['hours'];
    minutes = json['minutes'];
    seconds = json['seconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['total_seconds'] = this.totalSeconds;
    data['percent'] = this.percent;
    data['digital'] = this.digital;
    data['text'] = this.text;
    data['hours'] = this.hours;
    data['minutes'] = this.minutes;
    data['seconds'] = this.seconds;
    return data;
  }
}

class Range {
  String date;
  DateTime start;
  DateTime end;
  String text;
  String timezone;

  Range({this.date, this.start, this.end, this.text, this.timezone});

  Range.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['start'] != null) {
      try {
        start = DateTime.parse(json['start']);
      } on FormatException {
        // do nothing
      }
    }
    if (json['end'] != null) {
      try {
        end = DateTime.parse(json['end']);
      } on FormatException {
        // do nothing
      }
    }
    text = json['text'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.start != null) {
      data['start'] = this.start.toIso8601String();
    }
    if (this.end != null) {
      data['end'] = this.end.toIso8601String();
    }
    data['text'] = this.text;
    data['timezone'] = this.timezone;
    return data;
  }
}
