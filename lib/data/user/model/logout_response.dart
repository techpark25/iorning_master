class LogoutResponse {
    LogoutResponse({
        required this.status,
        required this.code,
        required this.message,
    });

    final bool? status;
    final int? code;
    final String? message;

    factory LogoutResponse.fromJson(Map<String, dynamic> json){ 
        return LogoutResponse(
            status: json["status"],
            code: json["code"],
            message: json["message"],
        );
    }

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
    };

}
