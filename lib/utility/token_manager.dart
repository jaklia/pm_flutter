import 'package:jwt_decoder/jwt_decoder.dart';

class TokenManager {
  static int getUserId(token) {
    var decodedToken = JwtDecoder.decode(token);
    print(decodedToken);
    print(decodedToken['sub']);
    int id = int.parse(decodedToken['sub']);
    return id;
  }
}
