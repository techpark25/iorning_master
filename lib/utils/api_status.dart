class ApiResponse<T> {
  final ApiStatus status;
  T? data;
  String? message;
  Exception? exception;

  ApiResponse.idle() : status = ApiStatus.idle;

  ApiResponse.loading(String s) : status = ApiStatus.loading;

  ApiResponse.success(this.data) : status = ApiStatus.success;

  ApiResponse.error(this.exception, this.message) : status = ApiStatus.error;
}

enum ApiStatus {
  idle,
  loading,
  success,
  error,
}
