import 'package:siangmalam/constans/values.dart';

//authentication
const loginUrl = serverHost + 'mobile/auth/login';
const refreshUrl = serverHost + 'mobile/auth/refresh';
const changePassUrl = serverHost + 'users/changepass';
const changeProfileImgUrl = serverHost + 'user-profile/changepic';
const getUserProfileUrl = serverHost + 'user-profile/byid/';
const updateUserProfileUrl = serverHost + 'user-profile/update';
const getCurrTimeByCoordinateUrl = timeApiHost + 'api/Time/current/coordinate';
const getBranchDataUrl = serverHost + 'branch/data';
const getSubBranchDataUrl = serverHost + 'subbranch/list';
const getUserByIdUrl = serverHost + 'users/byid/';

//master
const itemUrl = serverHost + 'items';
const warehouseUrl = serverHost + 'warehouse';
const tranferprodUrl = serverHost + 'transfer/products';
const stockProductUrl = serverHost + 'stock-product';
const stockItemUrl = serverHost + 'stock-item';
const tranferitemUrl = serverHost + 'transfer/items';
const suplierUrl = serverHost + 'suplier';
const suplierByIdUrl = serverHost + 'suplier/byid/';
const customerUrl = serverHost + 'customer';
const productUrl = serverHost + 'product';

//PO ITEM
const purchaseItemUrl = serverHost + 'purchase-order/items';
const purchaseProductUrl = serverHost + 'purchase-order/product';
const purchaseItemImageUrl = serverHost + 'purchase-order/items/image';
const purchaseItemWithNoOrder = serverHost + 'purchase-order/items/byorderno/';
const purchaseItemUpdate = serverHost + 'purchase-order/items/status';
const purchaseItemCancel = serverHost + 'purchase-order/items/cancel/';
const purchaseItemApproval = serverHost + 'purchase-order/items/approval';
const purchaseItemCreate = serverHost + 'purchase-order/items/create';
//PO  PRODUCT
const purchaseproductUrl = serverHost + 'purchase-order/product';
const purchaseproductImageUrl = serverHost + 'purchase-order/product/image';
const purchaseproductWithNoOrder =
    serverHost + 'purchase-order/product/byorderno/';
const purchaseproductUpdate = serverHost + 'purchase-order/product/status';
const purchaseproductCancel = serverHost + 'purchase-order/product/cancel/';
const purchaseproductApproval = serverHost + 'purchase-order/product/approval';
const purchaseproductCreate = serverHost + 'purchase-order/product/create';

// PO V2 PROD
const purchaseProdUrlV2 = serverHost + 'purchase-order/product/v2';
const purchaseProdUrlById = serverHost + 'purchase-order/product/byid/';
const purchaseProdUrlByOrderNo =
    serverHost + 'purchase-order/product/byorderno/';
const purchaseProdUrlUpsert = serverHost + 'purchase-order/product/';
const purchaseProdUrlCancel = serverHost + 'purchase-order/product/cancel/v2/';
const purchaseProdUrlImage = serverHost + 'purchase-order/product/image';
const purchaseProdUrlApprove =
    serverHost + 'purchase-order/product/approval/v2';
const purchaseProdUrlPayment = serverHost + 'purchase-order/product/payment';
const purchaseProdUrlDetailePayment =
    serverHost + 'purchase-order/product/payment';
// PO V2 ITEM
const purchaseItemUrlV2 = serverHost + 'purchase-order/items/v2';
const purchaseItemUrlById = serverHost + 'purchase-order/items/byid/';
const purchaseItemUrlByOrderNo = serverHost + 'purchase-order/items/byorderno/';
const purchaseItemUrlUpsert = serverHost + 'purchase-order/items/';
const purchaseItemUrlCancel = serverHost + 'purchase-order/items/cancel/v2/';
const purchaseItemUrlImage = serverHost + 'purchase-order/items/image';
const purchaseItemUrlApprove = serverHost + 'purchase-order/items/approval/v2';
const purchaseItemUrlPayment = serverHost + 'purchase-order/items/payment';
const purchaseItemUrlDetailePayment =
    serverHost + 'purchase-order/items/payment';

// DISCOUNT
const dicountUrl = serverHost + 'discount';
const dicountByIdUrl = serverHost + 'discount/';
const dicountCreateUrl = serverHost + 'discount/create';
const dicountUpdateUrl = serverHost + 'discount/update';
const dicountDeleteUrl = serverHost + 'discount/';

// BRANCH & SUBBRANCH
const branchUrl = serverHost + 'branch';
const subbranchhUrl = serverHost + 'subbranch';

// STO
const stoUrl = serverHost + 'stock-item/out';
const stoUrlCreate = serverHost + 'stock-item/out/create';

//presence
const presence = 'presence';
const getUserPresenceDataUrl = serverHost + presence;
const getPresenceStatusUrl = serverHost + presence + '/status';
const checkInUrl = serverHost + presence + '/checkin';
const checkOutUrl = serverHost + presence + '/checkout';

// cashier
const cashierUrl = serverHost + 'cashier';

// general
const generalUrl = serverHost + 'general/parameter/';

// ================================================================
// POS | Point Of Sales
// ================================================================
const categoryProductUrl = serverHost + 'product-category';
const tableUrl = serverHost + 'pos/tables/';
const urlMenu = serverHost + 'pos/menu/';
const priceCategoriesUrl = serverHost + 'price-category';
const orderTempSales = serverHost + 'pos/tempsales/';
const shiftUrl = serverHost + 'pos/shift/';
const paymentUrl = serverHost + 'pos/sales/checkout';
const paymentCustomUrl = serverHost + 'general/paymenttype/';

const salesCustomUrl = serverHost + 'pos/sales/';

// TRANSFER PRODUCT
const transferProductUrl = serverHost + 'pos/prodtransfer/';
const spaUrl = serverHost + 'stock/kitchen/product/';

// ================================================================
// REPORT
// ================================================================
const emplCashbonUrl = serverHost + 'pos/employee/';
const savingUrl = serverHost + 'pos/saving/';
const cashoutUrl = serverHost + 'pos/employee/';

// SOCKET
const triggerUrl = serverSocketHost;
