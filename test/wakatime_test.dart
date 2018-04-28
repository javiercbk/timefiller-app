import "dart:io";
import "package:test/test.dart";
import "package:path/path.dart" show dirname, join, normalize;
import 'package:http/http.dart' as http;
import "../lib/remote_services/wakatime/api.dart";
import "./helpers/mock_http_client.dart";
import "./helpers/test_path.dart";

final _scriptPath = testFilePath(Platform.script.toString());
final currentDirectory = dirname(_scriptPath);

void main() {
  group("wakatime", () {
    test("Wakatime api should correctly parse a response from dayWorkSeconds",
        () async {
      final mockHttpClient = new MockHttpClient();
      final wakatimeAPI = new WakatimeAPI("123123", mockHttpClient);
      final filePath =
          normalize(join(currentDirectory, "data/summarizes.json"));
      final jsonRawData = await new File(filePath).readAsString();
      final responseBuilder =
          (String body) => new http.Response(jsonRawData, 200);
      final now = new DateTime.now();
      final nowParam = now.toIso8601String().substring(0, 10);
      String url =
          "https://${WakatimeAPI.HOST}/${WakatimeAPI.REST_V1_PATH}/users/current/summaries?start=$nowParam&end=$nowParam";
      mockHttpClient.addMockedResponse(
          new ResponseMock(RequestMethod.GET, url, responseBuilder));
      final response = await wakatimeAPI.dayWorkSeconds(now);
      expect(response, equals(11752));
    });
  });
}
