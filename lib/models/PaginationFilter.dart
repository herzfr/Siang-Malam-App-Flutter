class PaginationFilter {
  int? page;
  int? size;
  String? search;

  @override
  String toString() =>
      'PaginationFilter(page: $page, limit: $size, search: $search)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PaginationFilter &&
        o.page == page &&
        o.size == size &&
        o.search == search;
  }

  @override
  int get hashCode => page.hashCode ^ size.hashCode ^ search.hashCode;
}
