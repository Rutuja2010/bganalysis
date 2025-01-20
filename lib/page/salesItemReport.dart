// ignore_for_file: unused_local_variable, unused_import, unused_element, unnecessary_brace_in_string_interps

import 'dart:io';

//import 'package:bganalysis/billPdf/billDesignPart.dart';
import 'package:bganalysis/billPdf/billDesignPart.dart';
import 'package:bganalysis/billPdf/pdfPreviewScreen.dart';

import 'package:bganalysis/commonWidgets/arithmeticClass.dart';
import 'package:bganalysis/globalVariables.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:pdf/pdf.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:universal_html/html.dart' as html;

import '../databaseFunction.dart';
import '../loadding.dart';
import 'MyDrawarCard.dart';

class SalesItemReport extends StatefulWidget {
  final String invoiceNo;
  SalesItemReport({Key? key, required this.invoiceNo}) : super(key: key);

  @override
  State<SalesItemReport> createState() => _SalesItemReportState(this.invoiceNo);
}

class _SalesItemReportState extends State<SalesItemReport> {
  String invoiceNo;
  _SalesItemReportState(this.invoiceNo);
  List saleItemList = []; // list3;
  List filterList = [];
  List? printConfigList = [];
  ArithmeticClass arithmeticClass = ArithmeticClass();

  void initState() {
    super.initState();
    fetchSales();
  }

  void fetchSales() async {
    saleItemList = await getSalesItemReport(invoiceNo);
    printConfigList = await printConfig("Display_Operation", "", "");
    //print(printConfigList);
    setState(() {});
  }

  @override
  void dispose() {
    saleItemList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              generatePdf();
            },
            icon: Icon(Icons.share),
          ),
        ],
      ),
      body: saleItemList.isNotEmpty
          ? saleItemReportListView()
          : Center(
              child: Loadding(),
            ),
      drawer: MyDrawarCard(),
    );
  }

  Future<void> generatePdf() async {
    final pdf = pw.Document();
    final pdfPages;
    pdfPages = await buildPdfContent(saleItemList, printConfigList);

    for (final page in pdfPages) {
      pdf.addPage(page);
    }
    String filename = arithmeticClass.generateRandomFilename();
    if (kIsWeb) {
      final Uint8List pdfBytes = await pdf.save();
      final blob = html.Blob([pdfBytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', filename)
        ..text = 'Download PDF';
      html.document.body!.append(anchor);
      anchor.click();
      html.Url.revokeObjectUrl(url); // Use revokeObjectUrl directly from html
      print('PDF generated successfully at: $url');
    } else {
      final output = await getTemporaryDirectory();
      final file = File('${output.path}/$filename.pdf');
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
  }

  saleItemReportListView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Customer & Business Info.",
                      style: TextStyle(
                          color: Color.fromARGB(255, 19, 152, 240),
                          fontSize: 18)),
                  const SizedBox(height: 9),
                  Text(
                      "Invoice No    :" + saleItemList[0]["Bill_No"].toString(),
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                  const SizedBox(height: 5),
                  Text(
                      "Date               :" +
                          saleItemList[0]["Invoice_Date"].toString(),
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                  const SizedBox(height: 5),
                  Text(
                      "Customer Name :\n" +
                          saleItemList[0]["Ledger_Name"].toString(),
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                  const SizedBox(height: 5),
                  Text(
                      "Mobile No    :" +
                          saleItemList[0]["Mobile_No"].toString(),
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                  const SizedBox(height: 5),
                  Text(
                      "Address        :" +
                          saleItemList[0]["Area_Name"].toString(),
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                  const SizedBox(height: 5),
                  Text("GST No.        :" + saleItemList[0]["gst"].toString(),
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                  const SizedBox(height: 5),
                  Text("Sum Amt.    :" + saleItemList[0]["S_Amt"].toString(),
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                  const SizedBox(height: 5),
                  Text(
                      "Total GST.    :" + saleItemList[0]["Tax_Amt"].toString(),
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                  const SizedBox(height: 5),
                  Text("Total Amt.    :" + saleItemList[0]["S_GAmt"].toString(),
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                  const SizedBox(height: 18),
                  Text("Product List",
                      style: TextStyle(
                          color: Color.fromARGB(255, 19, 152, 240),
                          fontSize: 18)),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            ListView.builder(
              itemCount: saleItemList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return salesItemReportCardLayout(index);
              },
            )
          ],
        ),
      ),
    );
  }

  salesItemReportCardLayout(int index) {
    return Card(
      elevation: 1,
      child: salesItemReportListTileLayout(index),
    );
  }

  ListTile salesItemReportListTileLayout(int index) {
    return ListTile(
      title: Text(
        'P.Name  : ' + saleItemList[index]["Item_Name"].toString(),
        style: TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
            'Qty            : ' +
                saleItemList[index]["Qty"].toString() +
                " " +
                saleItemList[index]["Unit"].toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold)),
        Text(
          'Rate        : ' + saleItemList[index]["Selling_Rate"].toString(),
        ),
        Text(
          'GST        : ' + saleItemList[index]["Tax"].toString() + '%',
        ),
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Color.fromARGB(255, 241, 247, 241)),
            child: Text(
                "Amt  ₹  : " + saleItemList[index]["Item_Net_Amt"].toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ))),
      ]),
      onTap: () {},
    );
  }
}
