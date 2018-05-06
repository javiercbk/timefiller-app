import 'dart:async';
import 'dart:io';
import 'dart:convert' as Convert;
import '../model/models.dart';
import 'package:path_provider/path_provider.dart';

abstract class EntityStorage<T> {
  Future<File> write(T data);
  Future<T> read();
}

abstract class FileEntityStorate<T> implements EntityStorage<T> {
  final String _fileName;

  FileEntityStorate(this._fileName);

  String get fileName => this._fileName;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _file async {
    final path = await _localPath;
    return new File('$path/$_fileName.txt');
  }

  Future<File> writeString(String data) async {
    final file = await _file;
    return file.writeAsString('$data');
  }

  Future<String> get readString async {
    final file = await _file;
    final fileExists = await file.exists();
    if (fileExists) {
      final data = await file.readAsString();
      return data;
    }
    return null;
  }
}

class CachedEntityStorage<T> implements EntityStorage<T> {
  final EntityStorage<T> _storage;
  T _cache;

  CachedEntityStorage(this._storage);

  Future<File> write(T data) {
    this._cache = data;
    return this._storage.write(data);
  }

  Future<T> read() async {
    if (this._cache != null) {
      return this._cache;
    }
    return await this._storage.read();
  }
}

class UserStorage extends FileEntityStorate<User> {
  UserStorage(String filename) : super(filename);

  Future<File> write(User data) async {
    final stringData = Convert.jsonEncode(data);
    return await this.writeString(stringData);
  }

  Future<User> read() async {
    final strData = await this.readString;
    if (strData != null) {
      final Map<String, dynamic> rawData = Convert.jsonDecode(strData);
      final obj = new User.fromJson(rawData);
      return obj;
    }
    return null;
  }
}

class WorklogStorage extends FileEntityStorate<List<Worklog>> {
  WorklogStorage(String filename) : super(filename);

  Future<File> write(List<Worklog> data) async {
    final stringData = Convert.jsonEncode(data);
    return await this.writeString(stringData);
  }

  Future<List<Worklog>> read() async {
    final strData = await this.readString;
    if (strData != null) {
      final List<Map<String, dynamic>> rawData = Convert.jsonDecode(strData);
      final obj = rawData.map((rawObject) {
        return new Worklog.fromJson(rawObject);
      });
      return obj;
    }
    return null;
  }
}

final userStorage =
    new CachedEntityStorage<User>(new UserStorage('user-data.json'));
final worklogStorage =
    new CachedEntityStorage<List<Worklog>>(new WorklogStorage('worklogs.json'));
