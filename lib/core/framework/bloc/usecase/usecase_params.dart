class NoParams {}

class ParamsPaggining {
  int page;
  int pageSize;
  String? orderField;
  bool? orderDescending;

  ParamsPaggining({
    required this.page,
    required this.pageSize,
    this.orderField,
    this.orderDescending = false,
  });
}
