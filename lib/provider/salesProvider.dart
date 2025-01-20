import 'package:flutter/material.dart';

import '../ModelClass/salesDTLListModel.dart';
import '../ModelClass/salesMTRListModel.dart';
import '../commonWidgets/arithmeticClass.dart';
import '../databaseFunction.dart';
import '../globalVariables.dart';

class SalesProvider extends ChangeNotifier {
  List<SalesDTLListModel>? salesDTLListModelProvider = [];
  List productListMode = [];
  List groupListMode = [];
  ArithmeticClass arithmeticClass = ArithmeticClass();
  List gstVatConfigList = [];

  SalesMTRListModel _salesMTRListModelProvider = SalesMTRListModel(
    invoiceDate: '0',
    custCode: '0',
    custName: '',
    mobileNo: '',
    totItem: '0',
    sAmt: '0',
    sGAmt: '0',
    roundOff: '0',
    disc: '0',
    discAmt: '0',
    tax: '0',
    taxAmt: '0',
    firmCodeKey: '0',
    appKeyCodeKey: '0',
    vatStatus: '0',
    paymentType: '0',
    // STNO: '0',
    // stNo: '0',
    // ST_NO: '0'
  );

  SalesMTRListModel get salesMTRListModelProvider => _salesMTRListModelProvider;

  void setSalesDTLItemList(SalesDTLListModel salesDTLListModel) {
    this.salesDTLListModelProvider!.add(salesDTLListModel);
    notifyListeners();
  }

  void setSalesMTRItemList(SalesMTRListModel salesMTRListModel) {
    this._salesMTRListModelProvider = salesMTRListModel;
    notifyListeners();
  }

  // Method to update the customer details in the SalesMTRListModel
  void updateCustomerDetailsInSalesMTR(String customerName, String mobileNo) {
    _salesMTRListModelProvider.custName = customerName;
    _salesMTRListModelProvider.mobileNo = mobileNo;
    notifyListeners();
  }

  void clearSalesDTLItemList() {
    this.salesDTLListModelProvider!.clear();
    //notifyListeners();
  }

  void clearSalesMTRItemList() {
    SalesMTRListModel salesMTRListModelProvider = SalesMTRListModel(
      invoiceDate: '0',
      custCode: '0',
      custName: '',
      totItem: '0',
      sAmt: '0',
      sGAmt: '0',
      roundOff: '0',
      disc: '0',
      discAmt: '0',
      tax: '0',
      taxAmt: '0',
      creditAmt: '0',
      firmCodeKey: '0',
      appKeyCodeKey: '0',
      mobileNo: '0',
      vatStatus: '0',
      paymentType: '0',
      // STNO: '0',
      // stNo: '0'
      // ST_NO: '0'
    );
    this._salesMTRListModelProvider = salesMTRListModelProvider;
  }

  int lengthSalesDTLItemList() {
    return salesDTLListModelProvider!.length;
  }

  void salesMTRBillTotal(isGSTSelected) {
    double billTotItem = 0,
        billSAmt = 0,
        billNetSAmt = 0,
        billDisc = 0,
        billDiscAmt = 0,
        billTaxAmt = 0,
        billTax = 0;
    String gstAmt, itemNetAmt;

    for (int i = 0; i < salesDTLListModelProvider!.length; i++) {
      final product = salesDTLListModelProvider![i];
      if (isGSTSelected == true) {
        gstAmt = product.taxAmt.toString();

        itemNetAmt =
            arithmeticClass.netItemAmt(product.itemAmt.toString(), gstAmt);

        product.taxAmt = gstAmt.toString();
        product.itemNetAmt = itemNetAmt.toString();
        salesDTLListModelProvider![i] = product;
      } else {
        product.taxAmt = "0";
        itemNetAmt =
            arithmeticClass.netItemAmt(product.itemAmt.toString(), "0");
        product.itemNetAmt = itemNetAmt.toString();
        salesDTLListModelProvider![i] = product;
        salesDTLListModelProvider![i] = product;
      }

      billSAmt = billSAmt + double.parse(product.itemAmt.toString());
      billNetSAmt = billNetSAmt + double.parse(product.itemNetAmt.toString());
      billTotItem = billTotItem + double.parse(product.qty.toString());
      billDiscAmt = billDiscAmt + double.parse(product.discountAmt.toString());
      billDisc = billDisc + double.parse(product.discount.toString());
      billTaxAmt = billTaxAmt + double.parse(product.taxAmt.toString());

      billTax = billTax + double.parse(product.itemAmt.toString());
    }
    setSalesMTRItemList(
      SalesMTRListModel(
        invoiceDate: '0',
        custCode: '0',
        custName: '',
        totItem: billTotItem.toStringAsFixed(2),
        sAmt: billSAmt.toStringAsFixed(2),
        roundOff: 0.toString(),
        disc: billDisc.toStringAsFixed(2),
        discAmt: billDiscAmt.toStringAsFixed(2),
        tax: billTax.toString(),
        taxAmt: billTaxAmt.toStringAsFixed(2),
        sGAmt: arithmeticClass.roundUp(billNetSAmt.toString()),
        firmCodeKey: firmCodeGlobal,
        appKeyCodeKey: appKeyCodeGlobal,
        mobileNo: '0',
        vatStatus: '',
        paymentType: '',
        // STNO: '0',
        // stNo: '0'
        // ST_NO: '0'
      ),
    );
    notifyListeners();
  }

  void salesBillTotalRefresh(isGSTSelected, gstInOutOption) {
    double billTotItem = 0,
        billSAmt = 0,
        billNetSAmt = 0,
        billDisc = 0,
        billDiscAmt = 0,
        billTaxAmt = 0,
        billTax = 0;

    for (int i = 0; i < salesDTLListModelProvider!.length; i++) {
      final product = salesDTLListModelProvider![i];
      product.totSquareFeet = arithmeticClass.totSqFeet(
          product.qty.toString(), product.size1.toString());
      product.discountAmt = arithmeticClass.discAmt(product.mrp.toString(),
          product.discount.toString(), product.qty.toString());
      product.itemAmt = arithmeticClass.itemAmt(
          product.mrp.toString(),
          product.qty.toString(),
          product.size1.toString(),
          product.discountAmt.toString());
      if (isGSTSelected == true) {
        product.taxAmt = arithmeticClass.gstAmtFind(
            product.itemAmt.toString(),
            "1",
            '1',
            product.tax.toString(),
            isGSTSelected.toString(),
            gstInOutOption!);
        if (gstInOutOption == "GST IN") {
          product.itemAmt = arithmeticClass.afterMrpGST(
              product.itemAmt.toString(), product.taxAmt.toString());
        }
        product.itemNetAmt = arithmeticClass.netItemAmt(
            product.itemAmt.toString(), product.taxAmt.toString());

        salesDTLListModelProvider![i] = product;
      } else {
        product.taxAmt = arithmeticClass.gstAmtFind(
            product.itemAmt.toString(),
            "1",
            '1',
            product.tax.toString(),
            isGSTSelected.toString(),
            gstInOutOption!);
        product.itemNetAmt =
            arithmeticClass.netItemAmt(product.itemAmt.toString(), "0");
        salesDTLListModelProvider![i] = product;
      }

      billSAmt = billSAmt + double.parse(product.itemAmt.toString());
      billNetSAmt = billNetSAmt + double.parse(product.itemNetAmt.toString());
      billTotItem = billTotItem + double.parse(product.qty.toString());
      billDiscAmt = billDiscAmt + double.parse(product.discountAmt.toString());
      billDisc = billDisc + double.parse(product.discount.toString());
      billTaxAmt = billTaxAmt + double.parse(product.taxAmt.toString());

      billTax = billTax + double.parse(product.itemAmt.toString());
    }
    setSalesMTRItemList(
      SalesMTRListModel(
        invoiceDate: '0',
        custCode: '0',
        custName: '',
        totItem: billTotItem.toStringAsFixed(2),
        sAmt: billSAmt.toStringAsFixed(2),
        roundOff: 0.toString(),
        disc: billDisc.toStringAsFixed(2),
        discAmt: billDiscAmt.toStringAsFixed(2),
        tax: billTax.toString(),
        taxAmt: billTaxAmt.toStringAsFixed(2),
        sGAmt: arithmeticClass
            .roundUp(billNetSAmt.toString()), //billNetSAmt.toStringAsFixed(2),
        firmCodeKey: firmCodeGlobal,
        appKeyCodeKey: appKeyCodeGlobal,
        mobileNo: '0',
        vatStatus: '',
        paymentType: '',
        // STNO: '0',
        // stNo: '0'
        // ST_NO: '0'
      ),
    );
    notifyListeners();
  }

  Future<void> allProductListWithStock(BuildContext context) async {
    productListMode =
        await getAllProductstockList(context, appKeyCodeGlobal, firmCodeGlobal);

    notifyListeners();
  }

  List dispalyAllProductListWithStock() {
    return productListMode;
  }

  Future<void> groupListDisplayByProvider(BuildContext context) async {
    groupListMode =
        await getGroupList(context, appKeyCodeGlobal, firmCodeGlobal);

    notifyListeners();
  }

  List displayGrouplist() {
    return groupListMode;
  }

  void removeGoodIssueDTListIndex(int index) {
    salesDTLListModelProvider!.removeAt(index);
    notifyListeners();
  }

  gstVatConfigSetByProvider(
    BuildContext context,
  ) async {
    gstVatConfigList =
        await getGSTVATConfig(context, "Display_Operation", "", "");

    await _shouldShowColumn("ProductSelectType");
    notifyListeners();
  }

  _shouldShowColumn(String headerName) {
    for (var item in gstVatConfigList) {
      if (item['Print_Type'] == "ProductSelectType") {
        productSelectTypeOption = item['Valuee'];
      }
      if (item['Print_Type'] == "selectGSTOption") {
        selectGSTOption = item['Valuee'];
      }
      if (item['Print_Type'] == "salesGstInOutOption") {
        salesGstInOutOption = item['Valuee'];
      }
      if (item['Print_Type'] == "salesGstInOutOption") {
        salesGstInOutOption = item['Valuee'];
      }
      if (item['Print_Type'] == "purchaseGstInOutOption") {
        purchaseGstInOutOption = item['Valuee'];
      }
      if (item['Print_Type'] == "saleConvertFromOption") {
        saleConvertFromOption = item['Valuee'];
        print("saleConvertFromOption");
        print(saleConvertFromOption);
      }
      if (item['Print_Type'] == "saleConvertToOption") {
        saleConvertToOption = item['Valuee'];
        print("saleConvertToOption");
        print(saleConvertToOption);
      }
      if (item['Print_Type'] == "purchaseConvertFromOption") {
        purchaseConvertFromOption = item['Valuee'];
      }
      if (item['Print_Type'] == "purchaseConvertToOption") {
        purchaseConvertToOption = item['Valuee'];
      }
      if (item['Print_Type'] == "purchaseDiscountInBill") {
        purchaseDiscountInBill = item['Valuee'];
      }
      if (item['Print_Type'] == "saleDiscountInBill") {
        saleDiscountInBill = item['Valuee'];
      }
      if (item['Print_Type'] == "GROUP WISE PRODUCT NAME") {
        groupWiseProductName = item['Valuee'];
      }
    }
  }

  void getDataGridViewSettingByProvider() async {
    dataGridViewGlobal =
        await getDataGridViewSetting("Display_Operation", "0", "", "");

    notifyListeners();
  }
}
