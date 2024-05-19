class ApiResponse<T> {
  final T? data;
  final String? errorMessage;
  final Exception? exception;

  ApiResponse(this.data, this.errorMessage, {this.exception});
}
