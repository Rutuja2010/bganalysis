import 'package:bganalysis/databaseFunction.dart';
import 'package:bganalysis/provider/salesProvider.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  late Database _database;
  SalesProvider providerSales = new SalesProvider();
  Future<void> initDatabase() async {
    if (kIsWeb) {
    } else {
      try {
        _database = await openDatabase(
          join(await getDatabasesPath(), 'MaverickDB.db'),
          onCreate: (db, version) {
            return db.execute('''
            CREATE TABLE Data_Grid_Config (
              Data_Grid_Id INTEGER PRIMARY KEY,
              Frm_Name TEXT,
              Field_Name TEXT,
              Value_Type TEXT,
              Column_Readonly INTEGER,
              Column_Width TEXT
            )
          ''');
          },
          version: 1,
        );
        print('Database initialized successfully');
        await insertInitialSettings(); // Insert initial settings upon database creation
      } catch (e) {
        print("Error initializing database: $e");
      }
    }
  }

  Future<void> insertInitialSettings() async {
    try {
      List<Map<String, dynamic>> initialSettingsData = [
        {
          'Frm_Name': 'purRate',
          'Field_Name': 'purRate',
          'Value_Type': null,
          'Column_Readonly': 0
        },
        {
          'Frm_Name': 'MRP',
          'Field_Name': 'MRP',
          'Value_Type': null,
          'Column_Readonly': 0
        },
        {
          'Frm_Name': 'sellingRate',
          'Field_Name': 'sellingRate',
          'Value_Type': null,
          'Column_Readonly': 0
        },
        {
          'Frm_Name': 'tax',
          'Field_Name': 'tax',
          'Value_Type': null,
          'Column_Readonly': 1
        },
        {
          'Frm_Name': 'taxAmt',
          'Field_Name': 'taxAmt',
          'Value_Type': null,
          'Column_Readonly': 0
        },
        {
          'Frm_Name': 'discount',
          'Field_Name': 'discount',
          'Value_Type': null,
          'Column_Readonly': 0
        },
        {
          'Frm_Name': 'discountAmt',
          'Field_Name': 'discountAmt',
          'Value_Type': null,
          'Column_Readonly': 0
        },
        {
          'Frm_Name': 'ItemAmt',
          'Field_Name': 'ItemAmt',
          'Value_Type': null,
          'Column_Readonly': 0
        },
        {
          'Frm_Name': 'Unit',
          'Field_Name': 'Unit',
          'Value_Type': null,
          'Column_Readonly': 0
        },
        {
          'Frm_Name': 'SalesMan',
          'Field_Name': 'SalesMan',
          'Value_Type': null,
          'Column_Readonly': 0
        },
        {
          'Frm_Name': 'ItemNetAmt',
          'Field_Name': 'ItemNetAmt',
          'Value_Type': null,
          'Column_Readonly': 0
        },
        {
          'Frm_Name': 'Size',
          'Field_Name': 'Size',
          'Value_Type': null,
          'Column_Readonly': 0
        },
        {
          'Frm_Name': 'Challan No',
          'Field_Name': 'Challan No',
          'Value_Type': null,
          'Column_Readonly': 0
        },
        {
          'Frm_Name': 'Description',
          'Field_Name': 'Description',
          'Value_Type': null,
          'Column_Readonly': 0
        },
        {
          'Frm_Name': 'VatMargin',
          'Field_Name': 'VatMargin',
          'Value_Type': null,
          'Column_Readonly': 0
        },
        {
          'Frm_Name': 'Height',
          'Field_Name': 'Height',
          'Value_Type': null,
          'Column_Readonly': 0
        },
        {
          'Frm_Name': 'Unit111',
          'Field_Name': 'Unit111',
          'Value_Type': null,
          'Column_Readonly': 0
        },
        {
          'Frm_Name': 'Width',
          'Field_Name': 'Width',
          'Value_Type': null,
          'Column_Readonly': 0
        },
        {
          'Frm_Name': 'Val',
          'Field_Name': 'Val',
          'Value_Type': null,
          'Column_Readonly': 0
        },
        {
          'Frm_Name': 'TotSqFt',
          'Field_Name': 'TotSqFt',
          'Value_Type': null,
          'Column_Readonly': 0
        },
        {
          'Frm_Name': 'BatteryNo',
          'Field_Name': 'BatteryNo',
          'Value_Type': null,
          'Column_Readonly': 0
        },
        {
          'Frm_Name': 'ChargerNo',
          'Field_Name': 'ChargerNo',
          'Value_Type': null,
          'Column_Readonly': 0
        },
        {
          'Frm_Name': 'Imei2',
          'Field_Name': 'Imei2',
          'Value_Type': null,
          'Column_Readonly': 0
        },
        {
          'Frm_Name': 'ExpiryDateBatch',
          'Field_Name': 'ExpiryDateBatch',
          'Value_Type': null,
          'Column_Readonly': 0
        },
        {
          'Frm_Name': 'ManufactureDateBatch',
          'Field_Name': 'ManufactureDateBatch',
          'Value_Type': null,
          'Column_Readonly': 0
        },
        {
          'Frm_Name': 'BatchNo',
          'Field_Name': 'BatchNo',
          'Value_Type': null,
          'Column_Readonly': 0
        },
        {
          'Frm_Name': 'FreeQty',
          'Field_Name': 'FreeQty',
          'Value_Type': null,
          'Column_Readonly': 0
        },
        {
          'Frm_Name': 'Add_Discount',
          'Field_Name': 'Add_Discount',
          'Value_Type': null,
          'Column_Readonly': 0
        },
        {
          'Frm_Name': 'Add_Disc_Amt',
          'Field_Name': 'Add_Disc_Amt',
          'Value_Type': null,
          'Column_Readonly': 0
        },
        {
          'Frm_Name': 'Batch_Wise_Barcode',
          'Field_Name': 'Batch_Wise_Barcode',
          'Value_Type': null,
          'Column_Readonly': 0
        },
      ];

      for (int i = 0; i < initialSettingsData.length; i++) {
        Map<String, dynamic> settingData = initialSettingsData[i];
        await _database.insert(
          'Data_Grid_Config',
          {
            'Frm_Name': settingData['Frm_Name'],
            'Field_Name': settingData['Field_Name'],
            'Value_Type': settingData['Value_Type'],
            'Column_Readonly': settingData['Column_Readonly'],
            'Column_Width': null,
          },
          conflictAlgorithm:
              ConflictAlgorithm.ignore, // Ignore if setting already exists
        );
      }

      print('Initial settings inserted into database');
    } catch (e) {
      print('Error inserting initial settings: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getDataGridViweSetting() async {
    print("js333... getDataGridViweSetting");
    if (kIsWeb) {
      return [];
    } else {
      return await _database.query('Data_Grid_Config');
    }
  }

  updateDataGridViweSetting(String itemName, bool enabled) async {
    if (kIsWeb) {
      await getDataGridViewSetting(
          "Update_Operation", (enabled ? 1 : 0).toString(), "", itemName);
      providerSales.getDataGridViewSettingByProvider();
    } else {
      await _database.update(
        'Data_Grid_Config',
        {'Column_Readonly': enabled ? 1 : 0},
        where: 'Frm_Name = ?',
        whereArgs: [itemName],
      );
    }
  }

  Future<void> updateDataGridViweFieldName(
      String itemName, String fieldNName) async {
    if (kIsWeb) {
    } else {
      await _database.update(
        'Data_Grid_Config',
        {'Field_Name': fieldNName},
        where: 'Frm_Name = ?',
        whereArgs: [itemName],
      );
    }
  }

  Future<List<Map<String, dynamic>>> getPrintConfigSetting() async {
    print("js333... getPrintConfigSetting");
    if (kIsWeb) {
      return [];
    } else {
      return await _database.query('Data_Grid_Config');
    }
  }

  updatePrintConfigSetting(String itemName, bool enabled) async {
    // if (kIsWeb) {
    //   await printConfig(
    //       "Update_Operation", (enabled ? "N" : "Y").toString(), itemName);
    // } else {
    //   await _database.update(
    //     'Data_Grid_Config',
    //     {'Column_Readonly': enabled ? 1 : 0},
    //     where: 'Frm_Name = ?',
    //     whereArgs: [itemName],
    //   );
    // }
    await printConfig(
        "Update_Operation", (enabled ? "N" : "Y").toString(), itemName);
  }
}
