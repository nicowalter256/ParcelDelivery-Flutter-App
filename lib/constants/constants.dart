class Constants {
  String url;
  String defaultBG;
  Constants({required this.url, required this.defaultBG});
}

List<Constants> constants = [
  Constants(
      url: 'http://192.168.5.192/v1/delivery/public/api/', //0
      defaultBG: 'assets/images/server.png') //1
];
