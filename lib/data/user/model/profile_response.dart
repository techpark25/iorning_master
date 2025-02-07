import 'user.dart';

class ProfileResponse {
    ProfileResponse({
        required this.status,
        required this.code,
        required this.message,
        required this.user,
    });

    final bool? status;
    final int? code;
    final String? message;
    final User? user;

    factory ProfileResponse.fromJson(Map<String, dynamic> json){ 
        return ProfileResponse(
            status: json["status"],
            code: json["code"],
            message: json["message"],
            user: json["user"] == null ? null : User.fromJson(json["user"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "user": user?.toJson(),
    };

}


