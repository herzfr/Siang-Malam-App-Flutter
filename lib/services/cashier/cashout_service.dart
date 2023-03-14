import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response hide FormData hide MultipartFile;
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/dio_http.dart';
import 'package:siangmalam/commons/functions/dio_exception.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/url_values.dart';
import 'package:siangmalam/models/cashier/cashout.dart';
import 'package:siangmalam/models/general_response.dart';
import 'package:siangmalam/widgets/snack_bar.dart';

class CashoutService {
  static Future<bool> cashoutEmpl(CashOutEmpl cashout) async {
    Response response;
    Dio dio = await DioConfig.getDio();
    try {
      response = await dio.post(cashoutUrl + 'kasbon/apply', data: cashout);
      var generalResponse = GeneralResponse.fromJson(response.data);

      if (generalResponse.statusCode == 0) {
        Snackbar.show("Success", "Pengeluaran Kasbon Karyawan Berhasil",
            primaryGreen, textColor);
        return true;
      }
      return false;
    } on DioError catch (error) {
      var message = DioExceptions().fromDioError(error);
      Snackbar.show("Gagal", message, mtRed600, mtGrey50);
      return false;
    } catch (error) {
      Snackbar.show("Gagal", "Oops ada yang salah", mtRed600, mtGrey50);
      return false;
    }
  }
}
