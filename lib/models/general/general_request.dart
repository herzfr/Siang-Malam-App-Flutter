/*Created By Dwi Sutrisno*/
class GeneralRequest {
  int size;
  int page;
  String search;
  String type;
  String startDate;
  String endDate;
  String sortBy;

  GeneralRequest.presenceRequest(this.size, this.page, this.search, this.type, this.startDate, this.endDate, this.sortBy);

  @override
  String toString() {
    return 'GeneralRequest{size: $size, page: $page, search: $search, type: $type, startDate: $startDate, endDate: $endDate, sortBy: $sortBy}';
  }
}
