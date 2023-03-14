import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/models/attendance/user_presence_list.dart';
import 'package:siangmalam/models/general/general_request.dart';
import 'package:siangmalam/services/attendance/attendance_service.dart';

/* Created By Dwi Sutrisno */

class AttendanceHistoryController extends GetxController {
  // var log = Logger();
  var startDate = ''.obs;
  var endDate = ''.obs;
  var reqStartDate = ''.obs;
  var reqEndDate = ''.obs;
  var presenceData = UserPresenceResponse().obs;
  var isDataLoad = false.obs;
  var isError = false.obs;

  DateFormat dateFormat = DateFormat("dd MMMM yyyy");
  DateFormat reqDateFormat = DateFormat("yyyy-MM-dd");

  @override
  void onInit() {
    super.onInit();
    initTimeFilter();
    getUserPresenceDataInitial();
  }

  /*Init time filter function*/
  initTimeFilter() {
    // startDate.value = dateFormat.format(DateTime.now());
    startDate.value = dateFormat.format(DateTime.now().subtract(const Duration(days: 7)));
    endDate.value = dateFormat.format(
      DateTime.now().add(
        const Duration(days: 7),
      ),
    );

    reqStartDate.value = reqDateFormat.format(DateTime.now().subtract(const Duration(days: 7)));
    reqEndDate.value = reqDateFormat.format(
      DateTime.now().add(
        const Duration(days: 7),
      ),
    );
  }

  /*Set Date Function*/
  setDate(DateTime start, DateTime end) {
    startDate.value = dateFormat.format(start);
    endDate.value = dateFormat.format(end);
    reqStartDate.value = reqDateFormat.format(start);
    reqEndDate.value = reqDateFormat.format(end);
    getUserPresenceData(reqStartDate.value, reqEndDate.value);
  }

  getUserPresenceData(String start, String end) async {
    var request = GeneralRequest.presenceRequest(1000, 0, '', 'PRESENCE', reqStartDate.value, reqEndDate.value, 'desc');
    await AttendanceService().getUserPresenceData(request).then((value) {
      isDataLoad.value = true;
      presenceData.value = value;
    }).catchError((error) {
      isError.value = true;
      isDataLoad.value = false;
    });
  }

  /*Get UserPresence Data */
  getUserPresenceDataInitial() async {
    var request = GeneralRequest.presenceRequest(1000, 0, '', 'PRESENCE', reqStartDate.value, reqEndDate.value, 'desc');
    await AttendanceService().getUserPresenceData(request).then((value) {
      isDataLoad.value = true;
      presenceData.value = value;
    }).catchError((error) {
      isError.value = true;
      isDataLoad.value = false;
    });
  }
}
