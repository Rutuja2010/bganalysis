import 'package:bganalysis/ModelClass/salesDTLListModel.dart';
import 'package:bganalysis/ModelClass/salesMTRListModel.dart';

class SalesInvoiceGn {
  late List<SalesMTRListModel> salesMTRListModel;
  late List<SalesDTLListModel> salesDTLListModel;
  SalesInvoiceGn({
    required this.salesMTRListModel,
    required this.salesDTLListModel,
  });

  Map<String, dynamic> toMap() {
    return {
      'salesMTRListModel': salesMTRListModel.asMap(),
      'salesDTLListModel': salesDTLListModel.asMap(),
    };
  }
}
