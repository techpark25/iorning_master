import 'user.dart';

class LoginResponse {
    LoginResponse({
        required this.code,
        required this.message,
        required this.user,
        required this.token,
    });

    final int? code;
    final String? message;
    final User? user;
    final String? token;

    factory LoginResponse.fromJson(Map<String, dynamic> json){ 
        return LoginResponse(
            code: json["code"],
            message: json["message"],
            user: json["user"] == null ? null : User.fromJson(json["user"]),
            token: json["token"],
        );
    }

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "user": user?.toJson(),
        "token": token,
    };

}


