import "dart:convert";
import "./lib/remote_services/wakatime/wakatime_model.dart";

const bodyStr = """
{
  "data": [
    {
      "categories": [
        {
          "digital": "0:18:15",
          "hours": 0,
          "minutes": 18,
          "name": "Coding",
          "percent": 100,

          "seconds": 15,
          "text": "18 mins",
          "total_seconds": 1095
        }
      ],
      "dependencies": [],
      "editors": [
        {
          "digital": "0:18:15",
          "hours": 0,
          "minutes": 18,
          "name": "VS Code",
          "percent": 100,
          "seconds": 15,
          "text": "18 mins",
          "total_seconds": 1095
        }
      ],
      "grand_total": {
        "digital": "0:18",
        "hours": 0,
        "minutes": 18,
        "text": "18 mins",
        "total_seconds": 1096
      },
      "languages": [
        {
          "digital": "0:17:42",
          "hours": 0,
          "minutes": 17,
          "name": "Dart",
          "percent": 96.99,
          "seconds": 42,
          "text": "17 mins",
          "total_seconds": 1062
        },
        {
          "digital": "0:00:33",
          "hours": 0,
          "minutes": 0,
          "name": "YAML",
          "percent": 3.01,
          "seconds": 33,
          "text": "33 secs",
          "total_seconds": 33
        }
      ],
      "operating_systems": [
        {
          "digital": "0:18:15",
          "hours": 0,
          "minutes": 18,
          "name": "Mac",
          "percent": 100.0,
          "seconds": 15,
          "text": "18 mins",
          "total_seconds": 1095
        }
      ],
      "projects": [
        {
          "digital": "0:14:27",
          "hours": 0,
          "minutes": 14,
          "name": "json_to_dart",
          "percent": 79.11,
          "seconds": 27,
          "text": "14 mins",
          "total_seconds": 867
        }
      ],
      "range": {
        "date": "2018-04-23",
        "end": "2018-04-24T02:59:59Z",
        "start": "2018-04-23T03:00:00Z",
        "text": "Mon Apr 23rd 2018",
        "timezone": "America/Argentina/Buenos_Aires"
      }
    },
    {
      "categories": [
        {
          "digital": "3:49:15",
          "hours": 3,
          "minutes": 49,
          "name": "Coding",
          "percent": 100.0,
          "seconds": 15,
          "text": "3 hrs 49 mins",
          "total_seconds": 13755
        }
      ],
      "dependencies": [
        {
          "digital": "0:13:40",
          "hours": 0,
          "minutes": 13,
          "name": "bluebird",
          "percent": 10.12,
          "seconds": 40,
          "text": "13 mins",
          "total_seconds": 820
        },
        {
          "digital": "0:13:40",
          "hours": 0,
          "minutes": 13,
          "name": "testcafe",
          "percent": 10.12,
          "seconds": 40,
          "text": "13 mins",
          "total_seconds": 820
        },
        {
          "digital": "0:02:29",
          "hours": 0,
          "minutes": 2,
          "name": "browser",
          "percent": 1.84,
          "seconds": 29,
          "text": "2 mins",
          "total_seconds": 149
        },
        {
          "digital": "0:00:03",
          "hours": 0,
          "minutes": 0,
          "name": "Flutter",
          "percent": 0.04,
          "seconds": 3,
          "text": "3 secs",
          "total_seconds": 3
        },
        {
          "digital": "0:00:03",
          "hours": 0,
          "minutes": 0,
          "name": "UIKit",
          "percent": 0.04,
          "seconds": 3,
          "text": "3 secs",
          "total_seconds": 3
        }
      ],
      "editors": [
        {
          "digital": "3:49:15",
          "hours": 3,
          "minutes": 49,
          "name": "VS Code",
          "percent": 100.0,
          "seconds": 15,
          "text": "3 hrs 49 mins",
          "total_seconds": 13755
        }
      ],
      "grand_total": {
        "digital": "3:48",
        "hours": 3,
        "minutes": 48,
        "text": "3 hrs 48 mins",
        "total_seconds": 13680
      },
      "languages": [
        {
          "digital": "2:11:32",
          "hours": 2,
          "minutes": 11,
          "name": "Dart",
          "percent": 57.38,
          "seconds": 32,
          "text": "2 hrs 11 mins",
          "total_seconds": 7892
        },
        {
          "digital": "1:24:09",
          "hours": 1,
          "minutes": 24,
          "name": "JavaScript",
          "percent": 36.71,
          "seconds": 9,
          "text": "1 hr 24 mins",
          "total_seconds": 5049
        },
        {
          "digital": "0:10:36",
          "hours": 0,
          "minutes": 10,
          "name": "YAML",
          "percent": 4.62,
          "seconds": 36,
          "text": "10 mins",
          "total_seconds": 636
        },
        {
          "digital": "0:01:46",
          "hours": 0,
          "minutes": 1,
          "name": "JSON",
          "percent": 0.77,
          "seconds": 46,
          "text": "1 min",
          "total_seconds": 106
        },
        {
          "digital": "0:01:00",
          "hours": 0,
          "minutes": 1,
          "name": "HTML",
          "percent": 0.44,
          "seconds": 0,
          "text": "1 min",
          "total_seconds": 60
        },
        {
          "digital": "0:00:07",
          "hours": 0,
          "minutes": 0,
          "name": "Other",
          "percent": 0.05,
          "seconds": 7,
          "text": "7 secs",
          "total_seconds": 7
        },
        {
          "digital": "0:00:03",
          "hours": 0,
          "minutes": 0,
          "name": "Swift",
          "percent": 0.02,
          "seconds": 3,
          "text": "3 secs",
          "total_seconds": 3
        }
      ],
      "operating_systems": [
        {
          "digital": "3:49:15",
          "hours": 3,
          "minutes": 49,
          "name": "Mac",
          "percent": 100.0,
          "seconds": 15,
          "text": "3 hrs 49 mins",
          "total_seconds": 13755
        }
      ],
      "projects": [
        {
          "digital": "1:26:14",
          "hours": 1,
          "minutes": 26,
          "name": "json_to_dart",
          "percent": 37.82,
          "seconds": 14,
          "text": "1 hr 26 mins",
          "total_seconds": 5174
        },
        {
          "digital": "0:54:09",
          "hours": 0,
          "minutes": 54,
          "name": "timefiller-app",
          "percent": 23.75,
          "seconds": 9,
          "text": "54 mins",
          "total_seconds": 3249
        },
        {
          "digital": "0:00:57",
          "hours": 0,
          "minutes": 0,
          "name": "flutter",
          "percent": 0.42,
          "seconds": 57,
          "text": "57 secs",
          "total_seconds": 57
        },
        {
          "digital": "0:00:09",
          "hours": 0,
          "minutes": 0,
          "name": "timefiller-script",
          "percent": 0.07,
          "seconds": 9,
          "text": "9 secs",
          "total_seconds": 9
        }
      ],
      "range": {
        "date": "2018-04-24",
        "end": "2018-04-25T02:59:59Z",
        "start": "2018-04-24T03:00:00Z",
        "text": "Tue Apr 24th 2018",
        "timezone": "America/Argentina/Buenos_Aires"
      }
    },
    {
      "categories": [
        {
          "digital": "0:39:55",
          "hours": 0,
          "minutes": 39,
          "name": "Coding",
          "percent": 100.0,
          "seconds": 55,
          "text": "39 mins",
          "total_seconds": 2395
        }
      ],
      "dependencies": [],
      "editors": [
        {
          "digital": "0:39:55",
          "hours": 0,
          "minutes": 39,
          "name": "VS Code",
          "percent": 100.0,
          "seconds": 55,
          "text": "39 mins",
          "total_seconds": 2395
        }
      ],
      "grand_total": {
        "digital": "0:39",
        "hours": 0,
        "minutes": 39,
        "text": "39 mins",
        "total_seconds": 2396
      },
      "languages": [
        {
          "digital": "0:37:13",
          "hours": 0,
          "minutes": 37,
          "name": "Dart",
          "percent": 93.2,
          "seconds": 13,
          "text": "37 mins",
          "total_seconds": 2233
        },
        {
          "digital": "0:01:41",
          "hours": 0,
          "minutes": 1,
          "name": "JSON",
          "percent": 4.22,
          "seconds": 41,
          "text": "1 min",
          "total_seconds": 101
        },
        {
          "digital": "0:01:02",
          "hours": 0,
          "minutes": 1,
          "name": "JavaScript",
          "percent": 2.59,
          "seconds": 2,
          "text": "1 min",
          "total_seconds": 62
        }
      ],
      "operating_systems": [
        {
          "digital": "0:39:55",
          "hours": 0,
          "minutes": 39,
          "name": "Mac",
          "percent": 100.0,
          "seconds": 55,
          "text": "39 mins",
          "total_seconds": 2395
        }
      ],
      "projects": [
        {
          "digital": "0:38:49",
          "hours": 0,
          "minutes": 38,
          "name": "timefiller-app",
          "percent": 97.2,
          "seconds": 49,
          "text": "38 mins",
          "total_seconds": 2329
        },
        {
          "digital": "0:01:02",
          "hours": 0,
          "minutes": 1,
          "name": "timefiller-script",
          "percent": 2.59,
          "seconds": 2,
          "text": "1 min",
          "total_seconds": 62
        },
        {
          "digital": "0:00:05",
          "hours": 0,
          "minutes": 0,
          "name": "flutter",
          "percent": 0.21,
          "seconds": 5,
          "text": "5 secs",
          "total_seconds": 5
        }
      ],
      "range": {
        "date": "2018-04-28",
        "end": "2018-04-29T02:59:59Z",
        "start": "2018-04-28T03:00:00Z",
        "text": "Today",
        "timezone": "America/Argentina/Buenos_Aires"
      }
    }
  ],
  "end": "2018-04-29T02:59:59Z",
  "start": "2018-04-23T03:00:00Z"
}

""";

void main() {
  final decodedJson = json.decode(bodyStr);
  final summaryResponse = new SummaryResponse.fromJson(decodedJson);
  print(summaryResponse.data[0].editors[0].percent);
}
