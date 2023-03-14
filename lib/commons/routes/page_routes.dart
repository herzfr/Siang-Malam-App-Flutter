import 'package:get/get.dart';
import 'package:siangmalam/commons/bindings/account/change_pass.dart';
import 'package:siangmalam/commons/bindings/account/device_info_binding.dart';
import 'package:siangmalam/commons/bindings/account/profile_binding.dart';
import 'package:siangmalam/commons/bindings/account/profile_form_binding.dart';
import 'package:siangmalam/commons/bindings/cashier/cashier_binding.dart';
import 'package:siangmalam/commons/bindings/customer/customer_binding.dart';
import 'package:siangmalam/commons/bindings/customer/customer_form_binding.dart';
import 'package:siangmalam/commons/bindings/dashboard/dashboard_bindings.dart';
import 'package:siangmalam/commons/bindings/discount/discount_binding.dart';
import 'package:siangmalam/commons/bindings/discount/discount_form_binding.dart';
import 'package:siangmalam/commons/bindings/home/attendance_binding.dart';
import 'package:siangmalam/commons/bindings/home/attendance_history_binding.dart';
import 'package:siangmalam/commons/bindings/home/home_binding.dart';
import 'package:siangmalam/commons/bindings/home/leave_permission_binding.dart';
import 'package:siangmalam/commons/bindings/item/stcok_item_binding.dart';
import 'package:siangmalam/commons/bindings/item/stock_item_form_binding.dart';
import 'package:siangmalam/commons/bindings/order/order_binding.dart';
import 'package:siangmalam/commons/bindings/order/table_form_binding.dart';
import 'package:siangmalam/commons/bindings/po-product/po_product_binding.dart';
import 'package:siangmalam/commons/bindings/po-product/po_product_create_binding.dart';
import 'package:siangmalam/commons/bindings/po-product/po_product_details_binding.dart';
import 'package:siangmalam/commons/bindings/po/po_all.binding.dart';
import 'package:siangmalam/commons/bindings/po/po_item_binding.dart';
import 'package:siangmalam/commons/bindings/po/po_item_create_binding.dart';
import 'package:siangmalam/commons/bindings/po/po_item_details_binding.dart';
import 'package:siangmalam/commons/bindings/printer/printer_binding.dart';
import 'package:siangmalam/commons/bindings/product/spa_binding.dart';
import 'package:siangmalam/commons/bindings/product/stock_product_binding.dart';
import 'package:siangmalam/commons/bindings/product/stock_product_form_binding.dart';
import 'package:siangmalam/commons/bindings/product/transfer_product_binding.dart';
import 'package:siangmalam/commons/bindings/report/report_bindings.dart';
import 'package:siangmalam/commons/bindings/saving/saving_bindings.dart';
import 'package:siangmalam/commons/bindings/splash/splash_binding.dart';
import 'package:siangmalam/commons/bindings/sto/sto_binding.dart';
import 'package:siangmalam/commons/bindings/sto/sto_form_binding.dart';
import 'package:siangmalam/commons/bindings/suplier/suplier_binding.dart';
import 'package:siangmalam/commons/bindings/suplier/suplier_form_binding.dart';
import 'package:siangmalam/commons/controllers/cashier/orderlist_controller.dart';
import 'package:siangmalam/commons/controllers/dashboard/dashboard_controller.dart';
import 'package:siangmalam/screens/account/account_screen.dart';
import 'package:siangmalam/screens/account/pages/change_pass/change_pass_screen.dart';
import 'package:siangmalam/screens/account/pages/device_info/device_info_screen.dart';
import 'package:siangmalam/screens/account/pages/profile/profile_form_screen.dart';
import 'package:siangmalam/screens/cart/cart_screen.dart';
import 'package:siangmalam/screens/dashboard/dashboard_screen.dart';
import 'package:siangmalam/screens/home/home_screen.dart';
import 'package:siangmalam/commons/routes/routes_name.dart';
import 'package:siangmalam/screens/home/pages/attendance/attendance_screen.dart';
import 'package:siangmalam/screens/home/pages/attendance/pages/attendance_history_screen.dart.dart';
import 'package:siangmalam/screens/home/pages/cashier/cashier_screen.dart';
import 'package:siangmalam/screens/home/pages/cashier/components/c_invoice_screen.dart';
import 'package:siangmalam/screens/home/pages/cashier/components/c_order_screen.dart';
import 'package:siangmalam/screens/home/pages/cashier/components/c_qrcode_screen.dart';
import 'package:siangmalam/screens/home/pages/cashier/components/c_split_screen.dart';
import 'package:siangmalam/screens/home/pages/cashier/out_cashier_cash/out_cash_screen.dart';
import 'package:siangmalam/screens/home/pages/cashier/sales/sales_screen.dart';
import 'package:siangmalam/screens/home/pages/cashier/settings_cashier/cashier_settings_screen.dart';
import 'package:siangmalam/screens/home/pages/customer/components/customer_form_screen.dart';
import 'package:siangmalam/screens/home/pages/customer/customer_screen.dart';
import 'package:siangmalam/screens/home/pages/discount/discount_form_screen.dart';
import 'package:siangmalam/screens/home/pages/discount/discount_screen.dart';
import 'package:siangmalam/screens/home/pages/leave_permission/leave_permission_screen.dart';
import 'package:siangmalam/screens/home/pages/order/component/table_form_screen.dart';
import 'package:siangmalam/screens/home/pages/order/order_screen.dart';
import 'package:siangmalam/screens/home/pages/po_item/components/details_po_item_screen.dart';
import 'package:siangmalam/screens/home/pages/po_item/components/po_item_create_screen.dart';
import 'package:siangmalam/screens/home/pages/po_item/po_item_screen.dart';
import 'package:siangmalam/screens/home/pages/po_product/components/po_prod_create_screen.dart';
import 'package:siangmalam/screens/home/pages/po_product/components/po_prod_details_screen.dart';
import 'package:siangmalam/screens/home/pages/po_product/po_product_screen.dart';
import 'package:siangmalam/screens/home/pages/printer/printer_screen.dart';
import 'package:siangmalam/screens/home/pages/purchase_item/item_credit_screen/purchase_item_credit_screen.dart';
import 'package:siangmalam/screens/home/pages/purchase_item/item_form_screen/purchase_item_form_screen.dart';
import 'package:siangmalam/screens/home/pages/purchase_item/item_main_screen/purchase_item_screen.dart';
import 'package:siangmalam/screens/home/pages/purchase_item/item_upload_screen/purchase_item_upload_screen.dart';
import 'package:siangmalam/screens/home/pages/purchase_product/product_credit_screen/purchase_prod_credit_screen.dart';
import 'package:siangmalam/screens/home/pages/purchase_product/product_form_screen/purchase_prod_form_screen.dart';
import 'package:siangmalam/screens/home/pages/purchase_product/product_main_screen/purchase_product_screen.dart';
import 'package:siangmalam/screens/home/pages/purchase_product/product_upload_screen/purchase_prod_upload_screen.dart';
import 'package:siangmalam/screens/home/pages/report_cashbon/report_cashbon_screen.dart';
import 'package:siangmalam/screens/home/pages/reportbill/reportbill_screen.dart';
import 'package:siangmalam/screens/home/pages/saving/saving_screen.dart';
import 'package:siangmalam/screens/home/pages/spa/spa_form_screen.dart';
import 'package:siangmalam/screens/home/pages/spa/spa_screen.dart';
import 'package:siangmalam/screens/home/pages/stock_item/components/stock_item_form.dart';
import 'package:siangmalam/screens/home/pages/stock_item/stock_item_screen.dart';
import 'package:siangmalam/screens/home/pages/stock_item_out/sto_form_screen.dart';
import 'package:siangmalam/screens/home/pages/stock_item_out/sto_screen.dart';
import 'package:siangmalam/screens/home/pages/stock_product/components/stock_product_form.dart';
import 'package:siangmalam/screens/home/pages/stock_product/stock_product_screen.dart';
import 'package:siangmalam/screens/home/pages/suplier/components/suplier_form_screen.dart';
import 'package:siangmalam/screens/home/pages/suplier/suplier_screen.dart';
import 'package:siangmalam/screens/home/pages/transfer_product/transfer_form_screen.dart';
import 'package:siangmalam/screens/home/pages/transfer_product/transfer_product_screen.dart';
import 'package:siangmalam/screens/home/pages/transfer_product/transfer_receive_screen.dart';
import 'package:siangmalam/screens/notfound/not_found.dart';
import 'package:siangmalam/screens/splash/splash_screen.dart';
import 'package:siangmalam/screens/signin/sign_in_screen.dart';
import 'package:siangmalam/screens/product_detail/details_screen.dart';

/* Created By Dwi Sutrisno */

class PageRoutes {
  static final pages = [
    GetPage(
      name: RouteName.splashScreen,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(name: RouteName.signInScreen, page: () => const SignInScreen()),
    GetPage(name: RouteName.unknownScreen, page: () => const UnknownScreen()),
    GetPage(
        name: RouteName.dashboardScreen,
        page: () => const DashboardScreen(),
        binding: DashboardBinding()),
    GetPage(
        name: RouteName.home,
        page: () => const HomeScreen(),
        binding: HomeBinding()),
    // GetPage(name: RouteName.cashierScreen, page: () => const CashierScreen()),
    GetPage(
      name: RouteName.productDetailScreen,
      page: () => const ProductDetailsScreen(),
    ),
    GetPage(name: RouteName.cartScreen, page: () => const CartScreen()),

    //Account Screen Page Route
    GetPage(
      name: RouteName.acountScreen,
      page: () => const AccountScreen(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: RouteName.accountProfileScreen,
      page: () => const ProfileFormScreen(),
      binding: ProfileFormBinding(),
    ),
    GetPage(
      name: RouteName.accountChangePass,
      page: () => const ChangePasswordScreen(),
      binding: ChangePassBinding(),
    ),
    GetPage(
      name: RouteName.deviceInfoScreen,
      page: () => const DeviceInfoScreen(),
      binding: DeviceInfoBinding(),
    ),
    //End Account Screen Route

    /* Home Screen Pages */
    GetPage(
      name: RouteName.attendanceScreen,
      page: () => const AttendanceScreen(),
      binding: AttendanceBinding(),
    ),
    GetPage(
      name: RouteName.attendanceHistoryScreen,
      page: () => const AttendanceHistoryScreen(),
      binding: AttendanceHistoryBinding(),
    ),
    GetPage(
      name: RouteName.leavePermissionScreen,
      page: () => const LeavePermissionScreen(),
      binding: LeavePermissionBinding(),
    ),
    /* Home Screen Pages */

    /* Purchase Screen Pages */
    GetPage(
      name: RouteName.poitemScreenV2,
      page: () => const PurchaseItemScreen(),
      binding: PoItemBindingV2(),
    ),
    GetPage(
      name: RouteName.poitemFormScreenV2,
      page: () => const PurchaseItemFormScreen(),
      binding: PoItemFormBindingV2(),
    ),
    GetPage(
      name: RouteName.poproductScreenV2,
      page: () => const PurchaseProductScreen(),
      binding: PoProductBindingV2(),
    ),
    GetPage(
      name: RouteName.poproductFormScreenV2,
      page: () => const PurchaseProductFormScreen(),
      binding: PoProductFormBindingV2(),
    ),
    GetPage(
      name: RouteName.poproductUploadScreenV2,
      page: () => PurchaseProductUploadScreen(),
      binding: PoProdUploadBinding(),
    ),
    GetPage(
      name: RouteName.poproductCreditScreenV2,
      page: () => PurchaseProductCreditScreen(),
      binding: PoProdCreditBinding(),
    ),
    GetPage(
      name: RouteName.poitemUploadScreenV2,
      page: () => PurchaseItemUploadScreen(),
      binding: PoItemUploadBinding(),
    ),
    GetPage(
      name: RouteName.poitemCreditScreenV2,
      page: () => PurchaseItemCreditScreen(),
      binding: PoItemCreditBinding(),
    ),
    /* Purchase Screen Pages */

    /* Stock Product Screen Pages */
    GetPage(
      name: RouteName.stockProductScreen,
      page: () => const StockProductScreen(),
      binding: StockProductBinding(),
    ),
    GetPage(
      name: RouteName.stockProductTransferScreen,
      page: () => const StockProductFormScreen(),
      binding: StockProductFormBinding(),
    ),
    /* Stock Product Screen Pages */
    /* Stock Items Screen Pages */
    GetPage(
      name: RouteName.stockItemScreen,
      page: () => const StockItemScreen(),
      binding: StockItemBinding(),
    ),
    GetPage(
      name: RouteName.stockItemTransferScreen,
      page: () => const StockItemFormScreen(),
      binding: StockItemFormBinding(),
    ),
    /* Stock Items Screen Pages */
    /* Printer Screen Pages */
    GetPage(
      name: RouteName.printerScreen,
      page: () => const PrinterScreen(),
      binding: PrinterBinding(),
    ),
    /* Printer Screen Pages */
    /* Suplier Screen Pages */
    GetPage(
      name: RouteName.suplierScreen,
      page: () => const SuplierScreen(),
      binding: SuplierBinding(),
    ),
    GetPage(
      name: RouteName.suplierFormScreen,
      page: () => const SuplierFormScreen(),
      binding: SuplierFormBinding(),
    ),
    /* Customer Screen Pages */
    GetPage(
      name: RouteName.customerScreen,
      page: () => const CustomerScreen(),
      binding: CustomerBinding(),
    ),
    GetPage(
      name: RouteName.customerFormScreen,
      page: () => const CustomerFormScreen(),
      binding: CustomerFormBinding(),
    ),
    /* PO Item Screen Pages */
    GetPage(
      name: RouteName.poItemScreen,
      page: () => const PoItemScreen(),
      binding: PoItemBinding(),
    ),
    GetPage(
      name: RouteName.poItemDetailsScreen,
      page: () => const DetailsPoItemScreen(),
      binding: PoItemDetailsBinding(),
    ),
    GetPage(
      name: RouteName.poItemCreateScreen,
      page: () => const PoItemCreateScreen(),
      binding: PoItemCreateBinding(),
    ),
    GetPage(
      name: RouteName.poProductScreen,
      page: () => const PoProductScreen(),
      binding: PoProductBinding(),
    ),
    GetPage(
      name: RouteName.poProductDetailsScreen,
      page: () => const DetailsPoProductScreen(),
      binding: PoProductDetailsBinding(),
    ),
    GetPage(
      name: RouteName.poProductCreateScreen,
      page: () => const PoProductCreateScreen(),
      binding: PoProductCreateBinding(),
    ),
    GetPage(
      name: RouteName.discountScreen,
      page: () => const DiscountScreen(),
      binding: DiscountBinding(),
    ),
    GetPage(
      name: RouteName.discountFormScreen,
      page: () => const DiscountFormScreen(),
      binding: DiscountFormBinding(),
    ),
    GetPage(
      name: RouteName.stoScreen,
      page: () => const StoScreen(),
      binding: StoBinding(),
    ),
    GetPage(
      name: RouteName.stoFormScreen,
      page: () => const StoFormScreen(),
      binding: StoFormBinding(),
    ),
    GetPage(
      name: RouteName.cashierScreen,
      page: () => const CashierScreen(),
      binding: CashierBinding(),
      // bindings: [CashierBinding(), OrderListBinding(), InvoiceListBinding()],
      // children: [
      //   GetPage(
      //     name: RouteName.CashierOrderListScreen,
      //     page: () => const CashierOrderListScreen(),
      //     binding: OrderListBinding(),
      //   ),
      //   GetPage(
      //     name: RouteName.CashierInvoiceListScreen,
      //     page: () => const CashierInvoiceListScreen(),
      //     binding: InvoiceListBinding(),
      //   ),
      // ],
    ),
    GetPage(
      name: RouteName.cashierOrderListScreen,
      page: () => const CashierOrderListScreen(),
      binding: OrderListBinding(),
    ),
    GetPage(
      name: RouteName.cashierSplitFormScreen,
      page: () => const SplitFormScreen(),
      binding: SplitFormBinding(),
    ),
    GetPage(
      name: RouteName.cashierQrCodeScreen,
      page: () => const CashierQrCodeScreen(),
      binding: QrCodeBinding(),
    ),
    GetPage(
      name: RouteName.cashierSalesScreen,
      page: () => const SalesScreen(),
      binding: SalesBinding(),
    ),
    GetPage(
      name: RouteName.cashierInvoiceListScreen,
      page: () => const CashierInvoiceListScreen(),
      binding: InvoiceListBinding(),
    ),
    GetPage(
      name: RouteName.orderScreen,
      page: () => const OrderScreen(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: RouteName.orderTableFormScreen,
      page: () => const TableFormScreen(),
      binding: TableFormBinding(),
    ),
    GetPage(
      name: RouteName.cashierSettingsScreen,
      page: () => const CashierSettingScreen(),
      binding: CashierSettingsBinding(),
    ),
    GetPage(
      name: RouteName.outCashScreen,
      page: () => const OutCashScreen(),
      binding: OutCashBinding(),
    ),
    GetPage(
      name: RouteName.reportBillScreen,
      page: () => const ReportBillScreen(),
      binding: ReportBillBinding(),
    ),
    GetPage(
      name: RouteName.savingScreen,
      page: () => const SavingScreen(),
      binding: SavingBinding(),
    ),
    GetPage(
      name: RouteName.reportCashbonScreen,
      page: () => const ReportCashbonScreen(),
      binding: ReportCashbonBinding(),
    ),
    GetPage(
      name: RouteName.transferProductScreen,
      page: () => const TransferProductScreen(),
      binding: TransferProductBinding(),
    ),
    GetPage(
      name: RouteName.transferProductFormScreen,
      page: () => const TransferProductFormScreen(),
      binding: TransferFormProductBinding(),
    ),
    GetPage(
      name: RouteName.transferProductReceiveScreen,
      page: () => const TransferProductReceiveScreen(),
      binding: TransferReceiveProductBinding(),
    ),
    GetPage(
      name: RouteName.spaScreen,
      page: () => const SpaScreen(),
      binding: SpaBinding(),
    ),
    GetPage(
      name: RouteName.spaFormScreen,
      page: () => const SpaFormScreen(),
      binding: SpaFormBinding(),
    ),
  ];
}
