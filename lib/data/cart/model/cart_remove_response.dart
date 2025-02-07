class CartRemoveResponse {
    CartRemoveResponse({
        required this.message,
    });

    final String? message;

    factory CartRemoveResponse.fromJson(Map<String, dynamic> json){ 
        return CartRemoveResponse(
            message: json["message"],
        );
    }

    Map<String, dynamic> toJson() => {
        "message": message,
    };

}
