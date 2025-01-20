import 'dart:convert';

class SalesDTLListModel {
  String? itemCode;
  String? itemName;
  String? unit;
  String? size1;
  String? qty;
  String? purRate;
  String? sellingRate;
  String? mrp;
  String? itemAmt;
  String? itemNetAmt;
  String? roundOff;
  String? tax;
  String? taxAmt;
  String? discount;
  String? discountAmt;
  String? rateType;
  String? remark;
  String? auditRow;
  String? firmCode;
  String? newUnit;
  String? height;
  String? width;
  String? val;
  String? totSquareFeet;
  String? sALEGSTSTATUS;
  String? userId;
  String? userName;

  SalesDTLListModel({
    required this.itemCode,
    required this.itemName,
    required this.unit,
    required this.size1,
    required this.qty,
    required this.purRate,
    required this.sellingRate,
    required this.mrp,
    required this.itemAmt,
    required this.itemNetAmt,
    required this.roundOff,
    required this.tax,
    required this.taxAmt,
    required this.discount,
    required this.discountAmt,
    required this.rateType,
    this.remark,
    this.auditRow,
    required this.firmCode,
    this.newUnit,
    this.height,
    this.width,
    this.val,
    this.totSquareFeet,
    this.sALEGSTSTATUS,
    this.userId,
    this.userName,
  });
  Map<String, dynamic> toMap() {
    return {
      'itemCode': itemCode,
      'itemName': itemName,
      'unit': unit,
      'size1': size1,
      'qty': qty,
      'purRate': purRate,
      'sellingRate': sellingRate,
      'mrp': mrp,
      'itemAmt': itemAmt,
      'itemNetAmt': itemNetAmt,
      'roundOff': roundOff,
      'tax': tax,
      'taxAmt': taxAmt,
      'discount': discount,
      'discountAmt': discountAmt,
      'rateType': rateType,
      'remark': remark,
      'auditRow': auditRow,
      'firmCode': firmCode,
      'newUnit': newUnit,
      'height': height,
      'width': width,
      'val': val,
      'totSquareFeet': totSquareFeet,
      'sALEGSTSTATUS': sALEGSTSTATUS,
      'userId': userId,
      'userName': userName,
    };
  }

  // /*factory ProductListModel.fromJson(Map<String, dynamic> json) {
  //   return ProductListModel(
  //     itemCode: json["Product_Code"],
  //     itemName: json["Product_Name"],
  //     groupCode: json["Group_Code"],
  //     groupName: json["Group_Name"],
  //     costPrice: json["Cost_Price"],
  //     unit: json["Unit"],
  //     sellingRate: json["Selling_Rate"],
  //     stock: json["Stock"],
  //   );
  // }*/

  factory SalesDTLListModel.fromMap(Map<String, dynamic> map) {
    return SalesDTLListModel(
      itemCode: map['itemCode'],
      itemName: map['itemName'],
      unit: map['unit'],
      size1: map['size1'],
      qty: map['qty'],
      purRate: map['purRate'],
      sellingRate: map['sellingRate'],
      mrp: map['mrp'],
      itemAmt: map['itemAmt'],
      itemNetAmt: map['itemNetAmt'],
      roundOff: map['roundOff'],
      tax: map['tax'],
      taxAmt: map['taxAmt'],
      discount: map['discount'],
      discountAmt: map['discountAmt'],
      rateType: map['rateType'],
      remark: map['remark'],
      auditRow: map['auditRow'],
      firmCode: map['firmCode'],
      newUnit: map['newUnit'],
      height: map['height'],
      width: map['width'],
      val: map['val'],
      totSquareFeet: map['totSquareFeet'],
      sALEGSTSTATUS: map['sALEGSTSTATUS'],
      userId: map['userId'],
      userName: map['userName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SalesDTLListModel.fromJson(String source) =>
      SalesDTLListModel.fromMap(json.decode(source));
}
