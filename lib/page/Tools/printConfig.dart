import 'package:bganalysis/databaseFunction.dart';
import 'package:bganalysis/provider/salesProvider.dart';
import 'package:bganalysis/sqlLiteDatabase/databaseHelper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PrintConfig extends StatefulWidget {
  const PrintConfig({super.key});

  @override
  State<PrintConfig> createState() => _PrintConfigState();
}

class _PrintConfigState extends State<PrintConfig> {
  SalesProvider providerSales = SalesProvider();
  late DatabaseHelper _databaseHelper;
  List pritConfigList = [];

  Map<String, bool> enableDisableMap = {};
  Map<String, TextEditingController?> editingControllers = {};

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    if (kIsWeb) {
      // Web specific initialization if needed
    } else {
      //await _databaseHelper.initDatabase();
    }
    await loadPrintConfigSetting();
  }

  loadPrintConfigSetting() async {
    if (kIsWeb) {
      // pritConfigList = await printConfig("Display_Operation", "", "");
    } else {
      //pritConfigList = await _databaseHelper.getPrintConfigSetting();
    }
    pritConfigList = await printConfig("Display_Operation", "", "");

    setState(() {
      for (var item in pritConfigList) {
        String itemName = item['Field_Name'];
        enableDisableMap[itemName] = item['Hide'] == "N";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Print Config'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount:
              pritConfigList.length, // Ensure itemCount matches list length
          itemBuilder: (context, index) {
            var item = pritConfigList[index];
            String itemName = item['Field_Name'];
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      itemName,
                      style: TextStyle(fontSize: 15),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            size: 20,
                          ),
                          onPressed: () {
                            // Handle edit action
                          },
                        ),
                        Switch(
                          value: enableDisableMap[itemName] ?? false,
                          onChanged: (value) {
                            setState(() {
                              enableDisableMap[itemName] = value;
                            });
                            _databaseHelper.updatePrintConfigSetting(
                                itemName, value);
                          },
                          activeColor: Colors.blue,
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(), // divider for each row
              ],
            );
          },
        ),
      ),
    );
  }
}
