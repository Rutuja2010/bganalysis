// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:bganalysis/ModelClass/salesDTLListModel.dart';

class SalesMTRListModel {
  String? invoiceDate;
  String? custCode;
  String? custName;
  String? totItem;
  String? sAmt;
  String? sGAmt;
  String? roundOff;
  String? disc;
  String? discAmt;
  String? tax;
  String? taxAmt;
  String? cashAmt;
  String? chequeAmt;
  String? cardAmt;
  String? creditAmt;
  String? advanceAmount;
  String? gstType;
  String? narrationValue;
  String? firmCodeKey;
  String? appKeyCodeKey;
  String? userId;
  String? userName;
  String? invoiceType;
  String? vatStatus;
  String? paymentType;

  String? delyChrgPre;
  String? transport;
  String? spngName;
  String? spngState;
  String? rateType;
  String? remark;

  String? projectName;
  String? projectTeam;
  String? voucharNo;
  String? auditRow;
  String? paymentCreditDays;
  String? paymentCreditDate;
  // String? stNo; //gst no
  // String? ST_NO;

  List<SalesDTLListModel>? salesDTLList;

  String mobileNo;
  SalesMTRListModel({
    required this.invoiceDate,
    required this.custCode,
    required this.custName,
    required this.mobileNo,
    required this.totItem,
    required this.sAmt,
    required this.sGAmt,
    this.roundOff,
    required this.disc,
    required this.discAmt,
    required this.tax,
    required this.taxAmt,
    this.cashAmt,
    this.chequeAmt,
    this.cardAmt,
    this.creditAmt,
    this.advanceAmount,
    this.gstType,
    this.narrationValue,
    required this.firmCodeKey,
    required this.appKeyCodeKey,
    required this.vatStatus,
    required this.paymentType,
    this.userId,
    this.userName,
    this.invoiceType,
    this.salesDTLList,
    this.delyChrgPre,
    this.transport,
    this.spngName,
    this.spngState,
    this.rateType,
    this.remark,
    this.voucharNo,
    this.auditRow,
    this.projectName,
    this.projectTeam,
    this.paymentCreditDays,
    this.paymentCreditDate,

    // required this.stNo,
    // this.ST_NO,
    // String? STNO,
  });

  Map<String, dynamic> toMap() {
    return {
      'invoiceDate': invoiceDate,
      'custCode': custCode,
      'custName': custName,
      'mobileNo': mobileNo,
      'totItem': totItem,
      'sAmt': sAmt,
      'sGAmt': sGAmt,
      'roundOff': roundOff,
      'disc': disc,
      'discAmt': discAmt,
      'tax': tax,
      'taxAmt': taxAmt,
      'cashAmt': cashAmt,
      'chequeAmt': chequeAmt,
      'cardAmt': cardAmt,
      'creditAmt': creditAmt,
      'advanceAmount': advanceAmount,
      'gstType': gstType,
      'narrationValue': narrationValue,
      'firmCodeKey': firmCodeKey,
      'appKeyCodeKey': appKeyCodeKey,
      'userId': userId,
      'userName': userName,
      'vatStatus': vatStatus,
      'paymentType': paymentType,
      'invoiceType': invoiceType,

      'delyChrgPre': delyChrgPre,
      'transport': transport,
      'spngName': spngName,
      'spngState': spngState,
      'rateType': rateType,
      'remark': remark,
      'voucharNo': voucharNo,
      'auditRow': auditRow,
      'projectName': projectName,
      'projectTeam': projectTeam,
      'paymentCreditDays': paymentCreditDays,
      'paymentCreditDate': paymentCreditDate,

      // 'stNo': stNo,
      // 'ST_NO': ST_NO,
      'salesDTLList': salesDTLList?.map((x) => x.toMap()).toList(),
    };
  }

  factory SalesMTRListModel.fromMap(Map<String, dynamic> map) {
    return SalesMTRListModel(
      invoiceDate: map['invoiceDate'],
      custCode: map['custCode'],
      custName: map['custName'],
      mobileNo: map['mobileNo'],
      totItem: map['totItem'],
      sAmt: map['sAmt'],
      sGAmt: map['sGAmt'],
      roundOff: map['roundOff'],
      disc: map['disc'],
      discAmt: map['discAmt'],
      tax: map['tax'],
      taxAmt: map['taxAmt'],
      cashAmt: map['cashAmt'],
      chequeAmt: map['chequeAmt'],
      cardAmt: map['cardAmt'],
      creditAmt: map['creditAmt'],
      advanceAmount: map['advanceAmount'],
      gstType: map['gstType'],
      narrationValue: map['narrationValue'],
      firmCodeKey: map['firmCodeKey'],
      appKeyCodeKey: map['appKeyCodeKey'],
      userId: map['userId'],
      userName: map['userName'],
      invoiceType: map['invoiceType'],
      vatStatus: map['vatStatus'],
      paymentType: map['paymentType'],
      delyChrgPre: map['delyChrgPre'],
      transport: map['transport'],
      spngName: map['spngName'],
      spngState: map['spngState'],
      rateType: map['rateType'],
      remark: map['remark'],
      voucharNo: map['voucharNo'],
      auditRow: map['auditRow'],
      projectName: map['projectName'],
      projectTeam: map['projectTeam'],
      paymentCreditDays: map['paymentCreditDays'],
      paymentCreditDate: map['paymentCreditDate'],
      // stNo: map['stNo'],
      // ST_NO: map['ST_NO'],
      salesDTLList: map['salesDTLList'] != null
          ? List<SalesDTLListModel>.from(
              map['salesDTLList']?.map((x) => SalesDTLListModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SalesMTRListModel.fromJson(String source) =>
      SalesMTRListModel.fromMap(json.decode(source));
}
