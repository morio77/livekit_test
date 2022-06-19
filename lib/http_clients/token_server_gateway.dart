class TokenServerGateway {
  static Future<String> generateToken() async {
    await Future.delayed(const Duration(seconds: 1));
    return '';
  }
}
