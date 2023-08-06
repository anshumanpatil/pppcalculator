class AsyncResponseStatus {
  bool success;
  String errorTitle;
  String errorDesc;

  AsyncResponseStatus({
    required this.success,
    required this.errorTitle,
    required this.errorDesc,
  });

  Map<String, dynamic> toJson() => {
        "success": success,
        "errorTitle": errorTitle,
        "errorDesc": errorDesc,
      };
}
