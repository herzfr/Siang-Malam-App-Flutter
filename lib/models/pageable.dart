class Pageable {
  int? totalElements;
  int? totalPage;
  int? pageNumber;
  int? pageSize;

  Pageable(
      {this.totalElements, this.totalPage, this.pageNumber, this.pageSize});

  Pageable.fromJson(Map<String, dynamic> json) {
    totalElements = json['totalElements'];
    totalPage = json['totalPage'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalElements'] = totalElements;
    data['totalPage'] = totalPage;
    data['pageNumber'] = pageNumber;
    data['pageSize'] = pageSize;
    return data;
  }
}
