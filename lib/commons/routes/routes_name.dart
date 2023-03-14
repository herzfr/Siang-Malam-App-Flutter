/* Created By Dwi Sutrisno */
// import 'package:siangmalam/screens/home/pages/cashier/components/c_invoice_screen.dart';
// import 'package:siangmalam/screens/home/pages/cashier/components/c_order_screen.dart';
// import 'package:siangmalam/screens/home/pages/cashier/sales/sales_screen.dart';

abstract class RouteName {
  static const intro = '/intro';
  static const splashScreen = '/splash';
  static const signInScreen = '/signin';
  static const unknownScreen = '/unknown';
  static const dashboardScreen = '/dashboard';
  static const home = '/home';
  static const productDetailScreen = '/product/detail';
  static const cartScreen = '/cart';
  static const acountScreen = '/account';
  static const accountProfileScreen = '/account/profile';
  static const accountChangePass = '/account/changePass';
  static const attendanceScreen = '/home/attendance';
  static const attendanceHistoryScreen = '/home/attendance/history';
  static const stockProductScreen = '/stockproduct';
  static const stockProductTransferScreen = '/stockproduct/transfer';
  static const stockItemScreen = '/stockitem';
  static const stockItemTransferScreen = '/stockitem/transfer';
  static const printerScreen = '/printer';
  static const suplierScreen = '/suplier';
  static const suplierFormScreen = '/suplier/form';
  static const customerScreen = '/customer';
  static const customerFormScreen = '/customer/form';
  static const poItemScreen = '/po-item';
  static const poItemDetailsScreen = '/po-item/details';
  static const poItemCreateScreen = '/po-item/create';
  static const poProductScreen = '/po-pruduct';
  static const poProductDetailsScreen = '/po-pruduct/details';
  static const poProductCreateScreen = '/po-pruduct/create';
  static const leavePermissionScreen = '/home/attendance/leave';
  static const discountScreen = '/discount';
  static const discountFormScreen = '/discount/form';
  static const stoScreen = '/sto';
  static const stoFormScreen = '/sto/form';
  static const orderScreen = '/order';
  static const orderTableFormScreen = '/tableform';
  static const deviceInfoScreen = '/deviceInfo';

  static const poproductScreenV2 = '/v2/po-pruduct/';
  static const poproductFormScreenV2 = '/v2/po-pruduct/form';
  static const poproductUploadScreenV2 = '/v2/po-pruduct/upload';
  static const poproductCreditScreenV2 = '/v2/po-pruduct/credit';

  static const poitemScreenV2 = '/v2/po-item/';
  static const poitemFormScreenV2 = '/v2/po-item/form';
  static const poitemUploadScreenV2 = '/v2/po-item/upload';
  static const poitemCreditScreenV2 = '/v2/po-item/credit';

  static const cashierScreen = '/cashier';
  static const cashierOrderListScreen = '/orderlist';
  static const cashierInvoiceListScreen = '/invoicelist';
  static const cashierSplitFormScreen = '/splitForm';
  static const cashierQrCodeScreen = '/qrcode';
  static const cashierSalesScreen = '/sales';
  static const cashierSettingsScreen = '/cashier_settings';

  static const reportBillScreen = '/report-bill';
  static const reportCashbonScreen = '/report-cashbon';
  static const outCashScreen = '/out-cash-screen';
  static const savingScreen = '/saving';
  static const transferProductScreen = '/transfer-products';
  static const transferProductFormScreen = '/transfer-products/form';
  static const transferProductReceiveScreen = '/transfer-products/receive';
  static const spaScreen = '/stock-product-adjustment';
  static const spaFormScreen = '/stock-product-adjustment/form';
}
