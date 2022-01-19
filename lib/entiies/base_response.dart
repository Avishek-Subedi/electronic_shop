class BaseResponse<T> {
  BaseResponse({
    this.data,
    this.success = false,
    this.error,
  });
  final T? data;
  final bool success;
  final String? error;
}
