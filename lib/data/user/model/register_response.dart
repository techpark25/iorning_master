import 'user.dart';

class RegisterResponse {
    RegisterResponse({
        required this.status,
        required this.code,
        required this.message,
        required this.data,
    });

    final bool? status;
    final int? code;
    final String? message;
    final Data? data;

    factory RegisterResponse.fromJson(Map<String, dynamic> json){ 
        return RegisterResponse(
            status: json["status"],
            code: json["code"],
            message: json["message"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "data": data?.toJson(),
    };

}

class Data {
    Data({
        required this.user,
        required this.token,
    });

    final User? user;
    final String? token;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            user: json["user"] == null ? null : User.fromJson(json["user"]),
            token: json["token"],
        );
    }

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "token": token,
    };

}


