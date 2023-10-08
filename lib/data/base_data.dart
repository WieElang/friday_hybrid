class BaseData<T> {
  final T? data;
  final String? errorMessage;
  final Exception? exception;

  BaseData(this.data, this.errorMessage, {this.exception});
}