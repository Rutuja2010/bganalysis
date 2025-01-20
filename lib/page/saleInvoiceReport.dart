// ignore_for_file: unused_import
import 'dart:io';

import 'package:bganalysis/commonWidgets/dateTimeWidget.dart';
import 'package:bganalysis/page/MyDrawarCard.dart';

import 'package:bganalysis/page/salesItemReport.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import '../databaseFunction.dart';
import '../globalVariables.dart';
import '../loadding.dart';

class SaleInvoiceSaleReport extends StatefulWidget {
  const SaleInvoiceSaleReport({super.key});

  @override
  State<SaleInvoiceSaleReport> createState() => _SaleInvoiceSaleReportState();
}

class _SaleInvoiceSaleReportState extends State<SaleInvoiceSaleReport> {
  List? list = []; // list3;
  List? salesMTRList = [];

  TextEditingController fillterFromDate = TextEditingController();
  TextEditingController fillterFromTo = TextEditingController();

  Icon custIcon = Icon(Icons.search);
  Widget custSearchBar = Text('Sales Report');
  String fillterSearchBar = '';
  @override
  void initState() {
    super.initState();
    checkNetConnectivity();
    fetchSalesMTR();
  }

  void fetchSalesMTR() async {
    salesMTRList =
        await getSalesMTR(fillterFromDate.text, fillterFromTo.text, '');
    list = salesMTRList!;
    setState(() {});
  }

  saleReportListView() {
    return ListView.builder(
      itemCount: salesMTRList!.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return saleReportCardLayout(index);
      },
    );
  }

  saleReportCardLayout(int index) {
    return Card(
      elevation: 1,
      child: saleReportListTileLayout(index),
    );
  }

  ListTile saleReportListTileLayout(int index) {
    return ListTile(
      title: Text(
        salesMTRList![index]["Cust_Name"].toString(),
        style: TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(salesMTRList![index]["Payment_Type"].toString()),
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Color.fromARGB(255, 241, 247, 241)),
            child: Text("₹ " + salesMTRList![index]["S_GAmt"].toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ))),
      ]),
      trailing: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: Color.fromARGB(255, 225, 250, 226)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Invoice " + salesMTRList![index]["Bill_No"].toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
          Text(salesMTRList![index]["Invoice_Date"].toString()),
          salesMTRList![index]["Vat_Status"].toString() == "VAT"
              ? Expanded(child: Text("GST"))
              : Expanded(child: Text("COMP")),
        ]),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SalesItemReport(
                    invoiceNo: salesMTRList![index]["Invoice_No"].toString(),
                  )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: salesMTRList!.isNotEmpty
          ? saleReportListView()
          : Center(
              child: Loadding(),
            ),
      drawer: MyDrawarCard(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionButton(
            child: Icon(
              Icons.add,
              size: 33,
            ),
            backgroundColor: Colors.amber,
            onPressed: () async {
              fetchSalesMTR();
            }),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      toolbarHeight: 60.0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          custSearchBar,
          SizedBox(height: 5),
          Text(
            fillterSearchBar,
            style: TextStyle(fontSize: 12.0),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              searchAppbar();
            });
          },
          icon: custIcon,
        ),
        IconButton(
          onPressed: () async {
            // generatePdf();
            filterReportFuction();
          },
          icon: const Icon(Icons.filter_alt_outlined),
        ),
      ],
    );
  }

  Future<void> generatePdf() async {
    final pdf = pw.Document();

    final pdfPages = _buildPdfContent();
    for (final page in pdfPages) {
      pdf.addPage(page);
    }

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/example.pdf');
    await file.writeAsBytes(await pdf.save());

    if (await file.exists()) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PdfPreviewScreen(pdfPath: file),
        ),
      );
    }

    print('PDF generated successfully!');
  }

  List<pw.Page> _buildPdfContent() {
    const rowsPerPage = 25; // Number of rows per page
    List<pw.Page> pdfPages = [];

    // Split the salesMTRList into chunks of size 'rowsPerPage'
    for (int startIndex = 0;
        startIndex < salesMTRList!.length;
        startIndex += rowsPerPage) {
      final endIndex = (startIndex + rowsPerPage < salesMTRList!.length)
          ? (startIndex + rowsPerPage)
          : salesMTRList!.length;
      final pageItemList = salesMTRList!.sublist(startIndex, endIndex);

      pdfPages.add(
        pw.Page(
          build: (context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Table(
                  border: pw.TableBorder.all(),
                  children: [
                    // Table Header
                    pw.TableRow(
                      children: [
                        pw.Text('Invoice No.'),
                        pw.Text('Date'),
                        pw.Text('Customer'),
                        pw.Text('Amount'),
                      ],
                    ),
                    // Data Rows
                    for (var item in pageItemList)
                      pw.TableRow(
                        children: [
                          pw.Text(item['Invoice_No'].toString()),
                          pw.Text(item['Invoice_Date'].toString()),
                          pw.Text(item['Cust_Name'].toString()),
                          pw.Text('₹ ' + item['S_GAmt'].toString()),
                        ],
                      ),
                  ],
                ),
              ],
              // )
            );
          },
        ),
      );
    }

    return pdfPages;
  }

  searchAppbar() {
    if (custIcon.icon == Icons.search) {
      custIcon = Icon(Icons.cancel);
      custSearchBar = TextField(
        onChanged: (value) {
          salesMTRList = list!
              .where((user) =>
                  user['Cust_Name'].toLowerCase().contains(value.toLowerCase()))
              .toList();
          setState(() {});
        },
        autofocus: true,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
        decoration: InputDecoration(fillColor: Colors.white60, filled: true),
      );
    } else {
      custIcon = Icon(Icons.search);
      custSearchBar = Text('Sales Invoice');
      salesMTRList = list;
    }
  }

  filterReportFuction() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter'),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align widgets to the left
              mainAxisSize:
                  MainAxisSize.min, // Reduce vertical space as much as possible
              children: [
                //typeAheadFieldForCustomer(),
                const SizedBox(
                  height: 10,
                ),
                Flexible(
                  child: datePicker(fillterFromDate, 'Date From'),
                ),
                Flexible(
                  child: datePicker(fillterFromTo, 'Date To'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                fillterSearchBar =
                    fillterFromDate.text + ' --> ' + fillterFromTo.text;
                fetchSalesMTR();
                Navigator.of(context).pop(); // Close the popup screen

                setState(() {});
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  datePicker(TextEditingController controllerdate, String labelName) {
    return DateTimeWidget(
      controllerdate: controllerdate,
      labelName: labelName,
    );
  }
}

class PdfPreviewScreen extends StatelessWidget {
  final File pdfPath; // Path to the PDF file

  PdfPreviewScreen({required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            // boxdecoration border for all page
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
              child: PDFView(
                filePath: pdfPath.path,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Share.shareXFiles([XFile(pdfPath.path)],
                      text: 'Great picture');
                },
                icon: const Icon(Icons.share),
                label: const Text('Share PDF'),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: () async {
                  var Printing;
                  await Printing.layoutPdf(onLayout: (_) => pdfPath.path);
                },
                icon: const Icon(Icons.print),
                label: const Text('Print PDF'),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
