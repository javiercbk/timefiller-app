class SearchTimeEntryResponse {
  List<TimeEntry> timeEntries;
  int perPage;
  int totalPages;
  int totalEntries;
  int nextPage;
  int previousPage;
  int page;
  Links links;

  SearchTimeEntryResponse(
      {this.timeEntries,
      this.perPage,
      this.totalPages,
      this.totalEntries,
      this.nextPage,
      this.previousPage,
      this.page,
      this.links});

  SearchTimeEntryResponse.fromJson(Map<String, dynamic> json) {
    if (json['time_entries'] != null) {
      timeEntries = new List<TimeEntry>();
      json['time_entries'].forEach((v) {
        timeEntries.add(new TimeEntry.fromJson(v));
      });
    }
    perPage = json['per_page'];
    totalPages = json['total_pages'];
    totalEntries = json['total_entries'];
    nextPage = json['next_page'];
    previousPage = json['previous_page'];
    page = json['page'];
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.timeEntries != null) {
      data['time_entries'] = this.timeEntries.map((v) => v.toJson()).toList();
    }
    data['per_page'] = this.perPage;
    data['total_pages'] = this.totalPages;
    data['total_entries'] = this.totalEntries;
    data['next_page'] = this.nextPage;
    data['previous_page'] = this.previousPage;
    data['page'] = this.page;
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    return data;
  }
}

class TimeEntry {
  int id;
  String spentDate;
  HarvestIdName user;
  HarvestIdName client;
  HarvestIdName project;
  HarvestIdName task;
  UserAssignment userAssignment;
  TaskAssignment taskAssignment;
  double hours;
  String notes;
  String createdAt;
  String updatedAt;
  bool isLocked;
  String lockedReason;
  bool isClosed;
  bool isBilled;
  String timerStartedAt;
  String startedTime;
  String endedTime;
  bool isRunning;
  Invoice invoice;
  // Null externalReference;
  bool billable;
  bool budgeted;
  double billableRate;
  double costRate;

  TimeEntry(
      {this.id,
      this.spentDate,
      this.user,
      this.client,
      this.project,
      this.task,
      this.userAssignment,
      this.taskAssignment,
      this.hours,
      this.notes,
      this.createdAt,
      this.updatedAt,
      this.isLocked,
      this.lockedReason,
      this.isClosed,
      this.isBilled,
      this.timerStartedAt,
      this.startedTime,
      this.endedTime,
      this.isRunning,
      this.invoice,
      // this.externalReference,
      this.billable,
      this.budgeted,
      this.billableRate,
      this.costRate});

  TimeEntry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    spentDate = json['spent_date'];
    user =
        json['user'] != null ? new HarvestIdName.fromJson(json['user']) : null;
    client = json['client'] != null
        ? new HarvestIdName.fromJson(json['client'])
        : null;
    project = json['project'] != null
        ? new HarvestIdName.fromJson(json['project'])
        : null;
    task =
        json['task'] != null ? new HarvestIdName.fromJson(json['task']) : null;
    userAssignment = json['user_assignment'] != null
        ? new UserAssignment.fromJson(json['user_assignment'])
        : null;
    taskAssignment = json['task_assignment'] != null
        ? new TaskAssignment.fromJson(json['task_assignment'])
        : null;
    hours = json['hours'];
    notes = json['notes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isLocked = json['is_locked'];
    lockedReason = json['locked_reason'];
    isClosed = json['is_closed'];
    isBilled = json['is_billed'];
    timerStartedAt = json['timer_started_at'];
    startedTime = json['started_time'];
    endedTime = json['ended_time'];
    isRunning = json['is_running'];
    invoice =
        json['invoice'] != null ? new Invoice.fromJson(json['invoice']) : null;
    // externalReference = json['external_reference'];
    billable = json['billable'];
    budgeted = json['budgeted'];
    billableRate = json['billable_rate'];
    costRate = json['cost_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['spent_date'] = this.spentDate;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.client != null) {
      data['client'] = this.client.toJson();
    }
    if (this.project != null) {
      data['project'] = this.project.toJson();
    }
    if (this.task != null) {
      data['task'] = this.task.toJson();
    }
    if (this.userAssignment != null) {
      data['user_assignment'] = this.userAssignment.toJson();
    }
    if (this.taskAssignment != null) {
      data['task_assignment'] = this.taskAssignment.toJson();
    }
    data['hours'] = this.hours;
    data['notes'] = this.notes;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_locked'] = this.isLocked;
    data['locked_reason'] = this.lockedReason;
    data['is_closed'] = this.isClosed;
    data['is_billed'] = this.isBilled;
    data['timer_started_at'] = this.timerStartedAt;
    data['started_time'] = this.startedTime;
    data['ended_time'] = this.endedTime;
    data['is_running'] = this.isRunning;
    if (this.invoice != null) {
      data['invoice'] = this.invoice.toJson();
    }
    // data['external_reference'] = this.externalReference;
    data['billable'] = this.billable;
    data['budgeted'] = this.budgeted;
    data['billable_rate'] = this.billableRate;
    data['cost_rate'] = this.costRate;
    return data;
  }
}

class HarvestIdName {
  int id;
  String name;

  HarvestIdName({this.id, this.name});

  HarvestIdName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class UserAssignment {
  int id;
  bool isProjectManager;
  bool isActive;
  // Null budget;
  String createdAt;
  String updatedAt;
  double hourlyRate;

  UserAssignment(
      {this.id,
      this.isProjectManager,
      this.isActive,
      // this.budget,
      this.createdAt,
      this.updatedAt,
      this.hourlyRate});

  UserAssignment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isProjectManager = json['is_project_manager'];
    isActive = json['is_active'];
    // budget = json['budget'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    hourlyRate = json['hourly_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_project_manager'] = this.isProjectManager;
    data['is_active'] = this.isActive;
    // data['budget'] = this.budget;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['hourly_rate'] = this.hourlyRate;
    return data;
  }
}

class TaskAssignment {
  int id;
  bool billable;
  bool isActive;
  String createdAt;
  String updatedAt;
  double hourlyRate;
  // Null budget;

  TaskAssignment(
      {this.id,
      this.billable,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      // this.budget,
      this.hourlyRate});

  TaskAssignment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    billable = json['billable'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    hourlyRate = json['hourly_rate'];
    // budget = json['budget'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['billable'] = this.billable;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['hourly_rate'] = this.hourlyRate;
    // data['budget'] = this.budget;
    return data;
  }
}

class Invoice {
  int id;
  String number;

  Invoice({this.id, this.number});

  Invoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['number'] = this.number;
    return data;
  }
}

class Links {
  String first;
  String next;
  String previous;
  String last;

  Links({this.first, this.next, this.previous, this.last});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    next = json['next'];
    previous = json['previous'];
    last = json['last'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['next'] = this.next;
    data['previous'] = this.previous;
    data['last'] = this.last;
    return data;
  }
}

class CreateTimeEntryRequest {
  int userId;
  int projectId;
  int taskId;
  DateTime spentDate;
  double hours;

  CreateTimeEntryRequest(
      {this.userId, this.projectId, this.taskId, this.spentDate, this.hours});

  CreateTimeEntryRequest.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    projectId = json['project_id'];
    taskId = json['task_id'];
    try {
      spentDate = DateTime.parse(json['spent_date']);
    } on FormatException {
      // do nothing
    }
    hours = json['hours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['project_id'] = this.projectId;
    data['task_id'] = this.taskId;
    if (this.spentDate != null) {
      data['spent_date'] = this.spentDate.toIso8601String().substring(0, 10);
    }
    data['hours'] = this.hours;
    return data;
  }
}

class CreateTimeEntryResponse {
  int id;
  String spentDate;
  HarvestIdName user;
  HarvestIdName client;
  HarvestIdName project;
  HarvestIdName task;
  UserAssignment userAssignment;
  TaskAssignment taskAssignment;
  double hours;
  String notes;
  String createdAt;
  String updatedAt;
  bool isLocked;
  String lockedReason;
  bool isClosed;
  bool isBilled;
  String timerStartedAt;
  String startedTime;
  String endedTime;
  bool isRunning;
  Invoice invoice;
  // Null externalReference;
  bool billable;
  bool budgeted;
  double billableRate;
  double costRate;

  CreateTimeEntryResponse(
      {this.id,
      this.spentDate,
      this.user,
      this.client,
      this.project,
      this.task,
      this.userAssignment,
      this.taskAssignment,
      this.hours,
      this.notes,
      this.createdAt,
      this.updatedAt,
      this.isLocked,
      this.lockedReason,
      this.isClosed,
      this.isBilled,
      this.timerStartedAt,
      this.startedTime,
      this.endedTime,
      this.isRunning,
      this.invoice,
      // this.externalReference,
      this.billable,
      this.budgeted,
      this.billableRate,
      this.costRate});

  CreateTimeEntryResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    spentDate = json['spent_date'];
    user =
        json['user'] != null ? new HarvestIdName.fromJson(json['user']) : null;
    client = json['client'] != null
        ? new HarvestIdName.fromJson(json['client'])
        : null;
    project = json['project'] != null
        ? new HarvestIdName.fromJson(json['project'])
        : null;
    task =
        json['task'] != null ? new HarvestIdName.fromJson(json['task']) : null;
    userAssignment = json['user_assignment'] != null
        ? new UserAssignment.fromJson(json['user_assignment'])
        : null;
    taskAssignment = json['task_assignment'] != null
        ? new TaskAssignment.fromJson(json['task_assignment'])
        : null;
    hours = json['hours'];
    notes = json['notes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isLocked = json['is_locked'];
    lockedReason = json['locked_reason'];
    isClosed = json['is_closed'];
    isBilled = json['is_billed'];
    timerStartedAt = json['timer_started_at'];
    startedTime = json['started_time'];
    endedTime = json['ended_time'];
    isRunning = json['is_running'];
    invoice =
        json['invoice'] != null ? new Invoice.fromJson(json['invoice']) : null;
    // externalReference = json['external_reference'];
    billable = json['billable'];
    budgeted = json['budgeted'];
    billableRate = json['billable_rate'];
    costRate = json['cost_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['spent_date'] = this.spentDate;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.client != null) {
      data['client'] = this.client.toJson();
    }
    if (this.project != null) {
      data['project'] = this.project.toJson();
    }
    if (this.task != null) {
      data['task'] = this.task.toJson();
    }
    if (this.userAssignment != null) {
      data['user_assignment'] = this.userAssignment.toJson();
    }
    if (this.taskAssignment != null) {
      data['task_assignment'] = this.taskAssignment.toJson();
    }
    data['hours'] = this.hours;
    data['notes'] = this.notes;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_locked'] = this.isLocked;
    data['locked_reason'] = this.lockedReason;
    data['is_closed'] = this.isClosed;
    data['is_billed'] = this.isBilled;
    data['timer_started_at'] = this.timerStartedAt;
    data['started_time'] = this.startedTime;
    data['ended_time'] = this.endedTime;
    data['is_running'] = this.isRunning;
    if (this.invoice != null) {
      data['invoice'] = this.invoice.toJson();
    }
    // data['external_reference'] = this.externalReference;
    data['billable'] = this.billable;
    data['budgeted'] = this.budgeted;
    data['billable_rate'] = this.billableRate;
    data['cost_rate'] = this.costRate;
    return data;
  }
}
