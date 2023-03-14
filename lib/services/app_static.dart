import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:siangmalam/models/cashier/shift.dart';
import 'package:siangmalam/models/user.dart';
import 'package:siangmalam/models/branch/branch.dart';
import 'package:siangmalam/models/user/user_profile.dart';
import 'package:siangmalam/models/attendance/presence_status.dart';
import 'package:siangmalam/models/attendance/coordinate.dto.dart';

/* Created By Dwi Sutrisno */

class AppStatic {
  //users
  static UserDto userData = UserDto();
  static UserProfileDto userProfile = UserProfileDto();
  static BranchDto userBranchData = BranchDto();
  static PresenceStatusDto userPresenceStatus = PresenceStatusDto(
    presenceId: 0,
    date: '',
    isHasCheckout: false,
    isHashCheckIn: false,
    checkInTime: 0,
  );
  static int presenceId = 0;

  static ShiftObj shiftData = ShiftObj();

  //Location
  static List<BranchData> workPlaceList = <BranchData>[];
  static CoordinateDto workPlaceLocation = CoordinateDto();
  static CoordinateDto currentDeviceLocation = CoordinateDto();
  static BlueThermalPrinter printerThermalInstance =
      BlueThermalPrinter.instance;
  static BluetoothDevice? device;
  static bool? isConnected = false;
}
