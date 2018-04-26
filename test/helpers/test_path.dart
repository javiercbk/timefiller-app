String testFilePath(String scriptPath) {
  if (scriptPath.startsWith("file://")) {
    return scriptPath.substring(7);
  }
  final idx = scriptPath.indexOf("file:/");
  return scriptPath.substring(idx + 5);
}
