import 'package:bganalysis/commonWidgets/arithmeticClass.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../globalVariables.dart';

Future<List<pw.Page>> buildPdfContent(
  final salesDTLList,
  final printConfigList1,
) async {
  ArithmeticClass arithmeticClass = ArithmeticClass();
  final pdfPages = <pw.Page>[];
  final itemsPerPage = 25;
  int serialNumber = 1;
  String firmMobileGlobal = firmMobile1Global + "," + firmMobile2Global;
  List saleItemList = salesDTLList;
  List printConfigList = printConfigList1;
  final fontData = await rootBundle.load('fonts/Cambriab.ttf');
  pw.Font fontCambria = pw.Font.ttf(fontData.buffer.asByteData());
  print(salesDTLList);
  final totalItems = salesDTLList.length;
  // Split the List into chunks of size 'itemsPerPage'
  for (int startIndex = 0;
      startIndex < totalItems;
      startIndex += itemsPerPage) {
    final endIndex = (startIndex + itemsPerPage) < totalItems
        ? (startIndex + itemsPerPage)
        : totalItems;
    final pageItemList = saleItemList.sublist(startIndex, endIndex);

    // final isLastPage = endIndex == totalItems;

    pdfPages.add(
      pw.Page(
        pageFormat: PdfPageFormat.a4.copyWith(
          marginBottom: 20.0,
          marginTop: 10.0,
          marginLeft: 10.0,
          marginRight: 10.0,
        ),
        build: (context) {
          return pw.Stack(
            children: [
              pw.Container(
                padding: pw.EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColors.black,
                    width: 2.0,
                  ),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Padding(
                      padding: pw.EdgeInsets.only(right: 20),
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.end,
                        children: [
                          pw.Text(
                            'GST Tax Invoice',
                            style: pw.TextStyle(
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                              font: fontCambria,
                            ),
                          ),
                        ],
                      ),
                    ),
                    pw.SizedBox(height: 2),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Text(
                          firmNameGlobal,
                          style: pw.TextStyle(
                            fontSize: 24,
                            fontWeight: pw.FontWeight.bold,
                            font: fontCambria,
                          ),
                        ),
                        pw.SizedBox(height: 1),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Text(
                              ' ${arithmeticClass.getFormattedAddress(firmAddressGlobal)}, ${firmCiryGlobal}',
                              style: pw.TextStyle(
                                fontSize: 10,
                                font: fontCambria,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 1),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Text(
                              'Phone No.: ${firmMobileGlobal}',
                              style: pw.TextStyle(
                                fontSize: 10,
                                font: fontCambria,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(width: 12),
                            pw.Text(
                              'Email: ${firmEmailGlobal}',
                              style: pw.TextStyle(
                                fontSize: 10,
                                font: fontCambria,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        pw.Text(
                          firmGSTGlobal,
                          style: pw.TextStyle(
                            fontSize: 11,
                            font: fontCambria,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Divider(
                          height: 5,
                          thickness: 1,
                          color: PdfColors.black,
                        ),
                      ],
                    ),
                    pw.Container(
                      padding:
                          pw.EdgeInsets.symmetric(vertical: 1, horizontal: 3),
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          children: [
                            pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Expanded(
                                  flex: 8,
                                  child: pw.Text(
                                    '${saleItemList[0]['Ledger_Name']}',
                                    style: pw.TextStyle(
                                      fontSize: 9,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                ),
                                pw.Expanded(
                                  flex: 2, // 70% of the width
                                  child: pw.Text(
                                    'Invoice  :    ${saleItemList[0]['Bill_No']}',
                                    style: pw.TextStyle(fontSize: 8),
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(height: 2),
                            pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Expanded(
                                  flex: 8,
                                  child: pw.Text(
                                      '${saleItemList[0]['Address']}',
                                      style: pw.TextStyle(fontSize: 8)),
                                ),
                                pw.Expanded(
                                  flex: 2,
                                  child: pw.Text(
                                      'Date  :   ${saleItemList[0]['Invoice_Date']}',
                                      style: pw.TextStyle(fontSize: 8)),
                                ),
                              ],
                            ),
                            pw.SizedBox(height: 2),
                            pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Expanded(
                                  flex: 8,
                                  child: pw.Text(
                                    '${saleItemList[0]['Area_Name']}',
                                    style: pw.TextStyle(fontSize: 8),
                                    softWrap: true,
                                  ),
                                ),
                                pw.Expanded(
                                  flex: 2,
                                  child: pw.Text(
                                      'Po No.  :    ${saleItemList[0]['Spng_State']}',
                                      style: pw.TextStyle(fontSize: 8)),
                                ),
                              ],
                            ),
                            pw.SizedBox(height: 2),
                            pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Expanded(
                                  flex: 8,
                                  child: pw.Text(
                                      '${saleItemList[0]['City']}${" "}${saleItemList[0]['Pin_Code']}',
                                      style: pw.TextStyle(fontSize: 8)),
                                ),
                                pw.Expanded(
                                  flex: 2,
                                  child: pw.Text(
                                      'Po Date  :    ${saleItemList[0]['Rate_Type']}',
                                      style: pw.TextStyle(fontSize: 8)),
                                ),
                              ],
                            ),
                            pw.SizedBox(height: 2),
                            pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Expanded(
                                  flex: 8,
                                  child: pw.Text(
                                    'Mobile No.: ${saleItemList[0]['Mobile_No']}',
                                    style: pw.TextStyle(
                                      fontSize: 8,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                ),
                                pw.Expanded(
                                  flex: 2,
                                  child: pw.Text(
                                      'Chalan No  :    ${saleItemList[0]['Dely_Chrg_Pre']}',
                                      style: pw.TextStyle(fontSize: 8)),
                                ),
                              ],
                            ),
                            pw.SizedBox(height: 2),
                            pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Expanded(
                                  flex: 8,
                                  child: pw.Text(
                                    'GST No.: ${saleItemList[0]['gst']}',
                                    style: pw.TextStyle(
                                      fontSize: 9,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                ),
                                pw.Expanded(
                                  flex: 2,
                                  child: pw.Text(
                                      'Transport  :    ${saleItemList[0]['Transport']}',
                                      style: pw.TextStyle(fontSize: 8)),
                                ),
                              ],
                            ),
                          ]),
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.SizedBox(height: 10),
                        pw.Table.fromTextArray(
                          data: [
                            // Header row
                            stlItemHeaderName(printConfigList),
                            // Data rows
                            for (var i = 0; i < pageItemList.length; i++)
                              stlItemRowValue(pageItemList, i, serialNumber,
                                  printConfigList),
                          ],
                          border: pw.TableBorder.all(
                              width: 1, color: PdfColors.grey700),
                          headerStyle: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 8,
                          ),
                          headerDecoration:
                              pw.BoxDecoration(color: PdfColors.grey300),
                          cellHeight: 18.0,
                          cellAlignments: generateCellAlignments(
                              stlItemHeaderName(printConfigList)),
                          columnWidths: generateColumnWidths(
                              stlItemHeaderName(printConfigList)),
                          cellPadding: const pw.EdgeInsets.all(2),
                          cellStyle: pw.TextStyle(
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              pw.Positioned(
                left: 5,
                bottom: 9,
                right: 5,
                child: pw.Container(
                  // Display totals only on the last page
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.SizedBox(height: 8),
                      pw.Divider(),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Amount Chargable (In Words)',
                            style: pw.TextStyle(fontSize: 8),
                          ),
                          pw.Text(
                            'Sub Total : ${double.parse(saleItemList[0]['S_Amt'])}',
                            style: pw.TextStyle(
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            '${arithmeticClass.getAmountInWords(saleItemList[0]['S_GAmt'])}',
                            style: pw.TextStyle(
                              fontSize: 8,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                            'CGST: ${(double.tryParse(saleItemList[0]['Tax_Amt'])! / 2).toStringAsFixed(2)}', // Assuming taxAmt is in percentage
                            style: pw.TextStyle(fontSize: 8),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.end,
                        children: [
                          pw.Text(
                            'SGST: ${(double.tryParse(saleItemList[0]['Tax_Amt'])! / 2).toStringAsFixed(2)}', // Assuming taxAmt is in percentage
                            style: pw.TextStyle(fontSize: 8),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.end,
                        children: [
                          pw.Text(
                            'Grand Total: ${double.parse(saleItemList[0]['S_GAmt'])}',
                            style: pw.TextStyle(
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        'TERMS AND CONDITIONS\n\n'
                        '1) Order once taken will not be cancelled.\n'
                        '2) Payment 50% Advance and balance 50% before delivery.\n'
                        '3) Guarantee only manufacturing defect guarantee.',
                        style: pw.TextStyle(
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  return pdfPages;
}

List<String> stlItemHeaderName(List printConfigList) {
  List<String> headerName = ['SN.'];

  for (int i = 0; i < printConfigList.length; i++) {
    if (printConfigList[i]["Hide"] == "N") {
      String fieldName = printConfigList[i]["Field_Name"];
      switch (fieldName) {
        case "Particulars":
          headerName.add('Particulars');
          break;
        case "SeprateDescription":
          headerName.add('Description');
          break;
        case "HSN CODE(GST)":
          headerName.add('HSN CODE(GST)');
          break;
        case "Qty":
          headerName.add('Qty');
          break;
        case "Unit":
          headerName.add('Unit');
          break;
        case "Rate":
          headerName.add('Rate');
          break;
        case "Tax":
          headerName.add('GST(%)');
          break;
        case "Amount":
          headerName.add('Amount');
          break;
        case "FinalAmt":
          headerName.add('FinalAmt');
          break;
        case "Size":
          headerName.add('Size');
          break;
        case "Discount":
          headerName.add('Dis');
          break;
        case "SellingRate":
          headerName.add('Rate');
          break;
      }
    }
  }

  return sortHeaders(headerName);
}

List<String> desiredOrder = [
  'SN.',
  'Particulars',
  'Description',
  'HSN CODE(GST)',
  'Size',
  'Qty',
  'Unit',
  'Rate',
  'Dis',
  'GST(%)',
  'Amount',
  'FinalAmt',
];

List<String> sortHeaders(List<String> headerNames) {
  List<String> sortedHeaders = [];

  for (var header in desiredOrder) {
    if (headerNames.contains(header)) {
      sortedHeaders.add(header);
    }
  }
  return sortedHeaders;
}

List<String> stlItemRowValue(
    final pageItemList, int i, int serialNumber, List printConfigList) {
  //List<String> rowValues = [(serialNumber).toString()];
  List<String> rowValues = [(i + 1).toString()];

  // Create a temporary map to hold the field values
  Map<String, String> fieldValues = {};

  for (int j = 0; j < printConfigList.length; j++) {
    String fieldName = printConfigList[j]["Field_Name"];
    if (printConfigList[j]["Hide"] == "N") {
      switch (fieldName) {
        case "Particulars":
          String itemName = pageItemList[i]['Item_Name']?.toString() ?? '';

          for (var config in printConfigList) {
            if (config["Field_Name"] == "Description" &&
                config["Hide"] == 'N') {
              String remark =
                  (pageItemList[i]['Description']?.toString() ?? '0') == '0'
                      ? ''
                      : pageItemList[i]['Description']?.toString() ?? '';

              if (remark.isEmpty) {
              } else {
                itemName = itemName + " " + remark;
              }
            }
            if (config["Field_Name"] == "Height" && config["Hide"] == 'N') {
              String height =
                  (pageItemList[i]['Height']?.toString() ?? '0') == '0'
                      ? ''
                      : pageItemList[i]['Height']?.toString() ?? '';
              String width =
                  (pageItemList[i]['Width']?.toString() ?? '0') == '0'
                      ? ''
                      : pageItemList[i]['Width']?.toString() ?? '';
              if (height.isEmpty && width.isEmpty) {
              } else {
                itemName = itemName + " " + width + "*" + height;
              }
            }
          }
          fieldValues['Particulars'] = itemName;

          break;
        case "SeprateDescription":
          fieldValues['Description'] =
              pageItemList[i]['Description'].toString();
          break;
        case "HSN CODE(GST)":
          fieldValues['HSN CODE(GST)'] = pageItemList[i]['HSN_Code'].toString();
          break;
        case "Qty":
          fieldValues['Qty'] = pageItemList[i]['Qty'].toString();
          break;
        case "Unit":
          fieldValues['Unit'] = pageItemList[i]['Qty'].toString() +
              " " +
              pageItemList[i]['Unit'].toString();
          break;
        case "Rate":
          fieldValues['Rate'] = pageItemList[i]['Selling_Rate'].toString();
          break;
        case "Tax":
          fieldValues['GST(%)'] = pageItemList[i]['Tax'].toString();
          break;

        case "Amount":
          fieldValues['Amount'] = pageItemList[i]['Item_Amt'].toString();
          break;
        case "FinalAmt":
          fieldValues['FinalAmt'] = pageItemList[i]['Item_Net_Amt'].toString();
          break;
        case "Size":
          fieldValues['Size'] = pageItemList[i]['Size1'].toString();
          break;
        case "Discount":
          fieldValues['Dis'] = pageItemList[i]['Discount'].toString();
          break;
        case "SellingRate":
          fieldValues['Rate'] = pageItemList[i]['Selling_Rate'].toString();
          break;
      }
    }
  }

  // Use the sorted header order to populate the row values
  List<String> sortedHeaders = sortHeaders(stlItemHeaderName(printConfigList));
  for (var header in sortedHeaders) {
    if (header != 'SN.') {
      rowValues.add(fieldValues[header] ?? '');
    }
  }

  return rowValues;
}

Map<int, pw.Alignment> generateCellAlignments(List<String> headers) {
  Map<int, pw.Alignment> cellAlignments = {};
  for (int i = 0; i < headers.length; i++) {
    cellAlignments[i] =
        i == 0 || i == 1 ? pw.Alignment.centerLeft : pw.Alignment.centerRight;
  }
  return cellAlignments;
}

Map<int, pw.FlexColumnWidth> generateColumnWidths(List<String> headers) {
  Map<int, pw.FlexColumnWidth> columnWidths = {};
  for (int i = 0; i < headers.length; i++) {
    switch (headers[i]) {
      case 'Particulars':
        columnWidths[i] = pw.FlexColumnWidth(4);
        break;
      case 'Description':
      case 'HSN CODE(GST)':
        columnWidths[i] = pw.FlexColumnWidth(1);
        break;
      case 'Size':
      case 'Qty':
        columnWidths[i] = pw.FlexColumnWidth(1);
        break;
      case 'Unit':
        columnWidths[i] = pw.FlexColumnWidth(1);
        break;
      case 'Rate':
        columnWidths[i] = pw.FlexColumnWidth(1);
        break;
      case 'Dis':
        columnWidths[i] = pw.FlexColumnWidth(0.5);
        break;
      case 'GST(%)':
        columnWidths[i] = pw.FlexColumnWidth(0.6);
        break;
      case 'Amount':
        columnWidths[i] = pw.FlexColumnWidth(1);
        break;
      case 'FinalAmt':
        columnWidths[i] = pw.FlexColumnWidth(1);
        break;
    }
  }
  return columnWidths;
}
