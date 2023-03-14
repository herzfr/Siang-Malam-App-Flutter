class MenuFilter {
  int? size;
  int? page;
  String? search;
  String? option;

  MenuFilter({this.size, this.page, this.search, this.option});

  MenuFilter.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    page = json['page'];
    search = json['search'];
    option = json['option'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['page'] = this.page;
    data['search'] = this.search;
    data['option'] = this.option;
    return data;
  }
}
