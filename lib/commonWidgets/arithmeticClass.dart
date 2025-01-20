import 'dart:math';

import 'package:flutter/material.dart';

class ArithmeticClass {
  //....................................................................START................................................................
  String itemAmt(String rate, String qty, String size, String discAmt) {
    String rate_ = rate;
    String qty_ = qty;
    String size_ = size;
    String discAmt_ = discAmt;

    if (rate == "" ||
        qty == "" ||
        size == "" ||
        discAmt == "" ||
        rate.length == 0 ||
        qty.length == 0 ||
        size.length == 0 ||
        discAmt.length == 0) {
      return "0";
    } else {
      double itemAmt =
          (double.parse(qty_) * double.parse(rate_) * double.parse(size_)) -
              double.parse(discAmt_);
      return itemAmt.toStringAsFixed(2);
    }
  }
  //..................................................................END..................................................................

  //....................................................................START................................................................
  String discAmt(String sp, String disc, String qty) {
    String _sp = sp;
    String _disc = disc;
    String _qty = qty;
    if (sp == "" ||
        disc == "" ||
        sp.length == 0 ||
        disc.length == 0 ||
        qty.length == 0 ||
        qty == "") {
      return '0';
    } else {
      double discAmt = (double.parse(_disc) * double.parse(_sp)) / 100;
      discAmt = discAmt * double.parse(_qty);

      if (discAmt.toString() == "" ||
          discAmt.toString() == "NaN" ||
          discAmt.toString() == "." ||
          discAmt.toString() == "Infinity" ||
          discAmt.toString() == "-Infinity") {
        discAmt = 0;
      }
      return discAmt.toStringAsFixed(2);
    }
  }
  //..................................................................END..................................................................

  //....................................................................START................................................................
  String gstAmtFind(String itemAmt, String qty, String size, String gst,
      String isGSTSelected, String gstInOutOption) {
    String itemAmt_ = itemAmt;
    String qty_ = qty;
    // String size_ = size;
    String gst_ = gst;
    double gstAmt;
    if (itemAmt == "" ||
        qty == "" ||
        size == "" ||
        gst == "" ||
        itemAmt.length == 0 ||
        qty.length == 0 ||
        size.length == 0 ||
        gst.length == 0) {
      return '0';
    } else {
      if (isGSTSelected == "true") {
        if (gstInOutOption == "GST OUT") {
          gstAmt = ((double.parse(qty_) *
                  double.parse(itemAmt_) *
                  double.parse(gst_)) /
              100);
        } else {
          gstAmt = ((((double.parse(qty_) * double.parse(itemAmt_)) *
                      100 /
                      (100 + double.parse(gst_))) *
                  double.parse(gst_)) /
              100);
        }
      } else {
        gstAmt = ((double.parse(qty_) * double.parse(itemAmt_) * 0) / 100);
      }

      return gstAmt.toStringAsFixed(2);
    }
  }
  //..................................................................END..................................................................

  //....................................................................START................................................................
  String netItemAmt(String itemAmt, String gstAmt) {
    String itemAmt_ = itemAmt;
    String gstAmt_ = gstAmt;
    if (itemAmt == "" ||
        gstAmt == "" ||
        itemAmt.length == 0 ||
        gstAmt.length == 0) {
      return '0';
    } else {
      double netItemAmt =
          double.parse(itemAmt_) + double.parse(gstAmt_); // vat out

      return netItemAmt.toStringAsFixed(2);
    }
  }

  //..................................................................END..................................................................

  //....................................................................START................................................................
  String afterMrpGST(String itemAmt, String gstAmt) {
    if (itemAmt == "" ||
        gstAmt == "" ||
        itemAmt.length == 0 ||
        gstAmt.length == 0) {
      return '0';
    } else {
      double totSqFeet =
          double.parse(itemAmt) - double.parse(gstAmt); // vat out

      return totSqFeet.toStringAsFixed(2);
    }
  }

  //..................................................................END..................................................................

  //....................................................................START................................................................
  String totSqFeet(String qty, String size) {
    if (qty == "" || size == "" || qty.length == 0 || size.length == 0) {
      return '0';
    } else {
      double totSqFeet = double.parse(qty) * double.parse(size); // vat out

      return totSqFeet.toStringAsFixed(2);
    }
  }

  //..................................................................END..................................................................
//....................................................................START................................................................
  String sizeFind(String totSqFeet, String qty) {
    if (totSqFeet == "" ||
        qty == "" ||
        totSqFeet.length == 0 ||
        qty.length == 0) {
      return '0';
    } else {
      double sizeFind = double.parse(totSqFeet) / double.parse(qty); // vat out

      return sizeFind.toStringAsFixed(2);
    }
  }

  //..................................................................END..................................................................
  String incToSqft(String height, String width, String val, String qty) {
    if (height.isEmpty ||
        width.isEmpty ||
        val.isEmpty ||
        height.length == 0 ||
        width.length == 0 ||
        val.length == 0) {
      return '0';
    } else {
      double sqft =
          (double.parse(width) * (double.parse(height) + double.parse(val))) /
              144;
      return sqft.toString();
    }
  }

  String incToCmt(String height, String width, String length, String qty) {
    if (height.isEmpty ||
        width.isEmpty ||
        length.isEmpty ||
        height.length == 0 ||
        width.length == 0 ||
        length.length == 0) {
      return '0';
    } else {
      double inchCmtValue = 0.0254;
      double inchCmt = ((double.parse(width) * inchCmtValue) *
              (double.parse(height) * inchCmtValue) *
              (double.parse(length) * inchCmtValue))
          .toDouble();

      return inchCmt.toString();
    }
  }

  String incToCft(String height, String width, String length, String qty) {
    if (height.isEmpty ||
        width.isEmpty ||
        length.isEmpty ||
        height.length == 0 ||
        width.length == 0 ||
        length.length == 0) {
      return '0';
    } else {
      double inchCftValue = 1728;
      double inchCft =
          (double.parse(width) * double.parse(height) * double.parse(length)) /
              inchCftValue;

      return inchCft.toString();
    }
  }

  String incToSqMtr(String height, String width, String length) {
    if (height.isEmpty ||
        width.isEmpty ||
        length.isEmpty ||
        height.length == 0 ||
        width.length == 0 ||
        length.length == 0) {
      return '0';
    } else {
      double inchSqMtrValue = 1550.0;
      double inchSqMtr =
          (double.parse(width) * double.parse(length)) / inchSqMtrValue;

      return inchSqMtr.toString();
    }
  }

  String incToRft(String height, String width, String length, String rftWidth,
      String rftHeight) {
    if (height.isEmpty ||
        width.isEmpty ||
        length.isEmpty ||
        rftWidth.isEmpty ||
        rftHeight.isEmpty ||
        height.length == 0 ||
        width.length == 0 ||
        length.length == 0 ||
        rftWidth.length == 0 ||
        rftHeight.length == 0) {
      return '0';
    } else {
      double inchRft = (double.parse(width) * double.parse(rftWidth) +
              double.parse(height) * double.parse(rftHeight)) /
          12;

      return inchRft.toString();
    }
  }

  String mtrToSqft(String height, String width, String qty) {
    if (height.isEmpty ||
        width.isEmpty ||
        height.length == 0 ||
        width.length == 0) {
      return '0';
    } else {
      double sqft = double.parse(width) * double.parse(height) * 10.764;
      return sqft.toString();
    }
  }

  String mtrToCmt(String height, String width, String length) {
    if (height.isEmpty ||
        width.isEmpty ||
        length.isEmpty ||
        height.length == 0 ||
        width.length == 0 ||
        length.length == 0) {
      return '0';
    } else {
      double mtrCmt = (double.parse(width)) *
          (double.parse(height)) *
          (double.parse(length));

      return mtrCmt.toString();
    }
  }

  String mtrToCft(String height, String width, String length) {
    if (height.isEmpty ||
        width.isEmpty ||
        length.isEmpty ||
        height.length == 0 ||
        width.length == 0 ||
        length.length == 0) {
      return '0';
    } else {
      double mtrCftValue = 3.2808399;
      double mtrCft = ((double.parse(width) * mtrCftValue) *
              (double.parse(height) * mtrCftValue) *
              (double.parse(length) * mtrCftValue))
          .toDouble();

      return mtrCft.toString();
    }
  }

  String mtrToSqMtr(String height, String width, String length) {
    if (height.isEmpty ||
        width.isEmpty ||
        length.isEmpty ||
        height.length == 0 ||
        width.length == 0 ||
        length.length == 0) {
      return '0';
    } else {
      double mtrSqMtr = ((double.parse(width)) * (double.parse(length)));

      return mtrSqMtr.toString();
    }
  }

  String feetToSqft(String height, String width, String qty) {
    if (height.isEmpty ||
        width.isEmpty ||
        qty.isEmpty ||
        height.length == 0 ||
        width.length == 0 ||
        qty.length == 0) {
      return '0';
    } else {
      double sqft = double.parse(width) * double.parse(height);
      return sqft.toString();
    }
  }

  String feetToCmt(String height, String width, String length) {
    if (height.isEmpty ||
        width.isEmpty ||
        length.isEmpty ||
        height.length == 0 ||
        width.length == 0 ||
        length.length == 0) {
      return '0';
    } else {
      double feetCmtValue = 0.3048;
      double feetCmt = ((double.parse(width) * feetCmtValue) *
              (double.parse(height) * feetCmtValue) *
              (double.parse(length) * feetCmtValue))
          .toDouble();

      return feetCmt.toString();
    }
  }

  String feetToCft(String height, String width, String length) {
    if (height.isEmpty ||
        width.isEmpty ||
        length.isEmpty ||
        height.length == 0 ||
        width.length == 0 ||
        length.length == 0) {
      return '0';
    } else {
      double feetCft = ((double.parse(width)) *
          (double.parse(height)) *
          (double.parse(length)));

      return feetCft.toString();
    }
  }

  String feetToSqMtr(String height, String width, String length) {
    if (height.isEmpty ||
        width.isEmpty ||
        length.isEmpty ||
        height.length == 0 ||
        width.length == 0 ||
        length.length == 0) {
      return '0';
    } else {
      double feetSqMtrValue = 10.764;
      double feetSqMtr =
          (double.parse(width) * double.parse(length)) / feetSqMtrValue;

      return feetSqMtr.toString();
    }
  }

  String cmToSqft(String height, String width, String qty) {
    if (height.isEmpty ||
        width.isEmpty ||
        qty.isEmpty ||
        height.length == 0 ||
        width.length == 0 ||
        qty.length == 0) {
      return '0';
    } else {
      double sqft = double.parse(width) * double.parse(height) * 0.00107639104;
      return sqft.toString();
    }
  }

  String cmToCmt(String height, String width, String length) {
    if (height.isEmpty ||
        width.isEmpty ||
        length.isEmpty ||
        height.length == 0 ||
        width.length == 0 ||
        length.length == 0) {
      return '0';
    } else {
      double cmCmtValue = 100;
      double cmCmt = ((double.parse(width) / cmCmtValue) *
              (double.parse(height) / cmCmtValue) *
              (double.parse(length) / cmCmtValue))
          .toDouble();

      return cmCmt.toString();
    }
  }

  String cmToCft(String height, String width, String length) {
    if (height.isEmpty ||
        width.isEmpty ||
        length.isEmpty ||
        height.length == 0 ||
        width.length == 0 ||
        length.length == 0) {
      return '0';
    } else {
      double cmCftValue = 0.03280399;
      double cmCft = ((double.parse(width) * cmCftValue) *
              (double.parse(height) * cmCftValue) *
              (double.parse(length) * cmCftValue))
          .toDouble();

      return cmCft.toString();
    }
  }

  String cmToSqMtr(String height, String width, String length) {
    if (height.isEmpty ||
        width.isEmpty ||
        length.isEmpty ||
        height.length == 0 ||
        width.length == 0 ||
        length.length == 0) {
      return '0';
    } else {
      double cmSqMtrValue = 10000;
      double cmSqMtr =
          (double.parse(width) * double.parse(length)) / cmSqMtrValue;

      return cmSqMtr.toString();
    }
  }

  String mmToSqft(String height, String width, String qty) {
    if (height.isEmpty ||
        width.isEmpty ||
        qty.isEmpty ||
        height.length == 0 ||
        width.length == 0 ||
        qty.length == 0) {
      return '0';
    } else {
      double sqft = double.parse(width) * double.parse(height) * 0.000010764;
      return sqft.toString();
    }
  }

  String mmToCmt(String height, String width, String length) {
    if (height.isEmpty ||
        width.isEmpty ||
        length.isEmpty ||
        height.length == 0 ||
        width.length == 0 ||
        length.length == 0) {
      return '0';
    } else {
      double mmCmtValue = 0.001;
      double mmCmt = ((double.parse(width) * mmCmtValue) *
              (double.parse(height) * mmCmtValue) *
              (double.parse(length) * mmCmtValue))
          .toDouble();

      return mmCmt.toString();
    }
  }

  String mmToCft(String height, String width, String length) {
    if (height.isEmpty ||
        width.isEmpty ||
        length.isEmpty ||
        height.length == 0 ||
        width.length == 0 ||
        length.length == 0) {
      return '0';
    } else {
      double mmCftValue = 0.0032808399;
      double mmCft = ((double.parse(width) * mmCftValue) *
              (double.parse(height) * mmCftValue) *
              (double.parse(length) * mmCftValue))
          .toDouble();

      return mmCft.toString();
    }
  }

  String mmToSqMtr(String height, String width, String length) {
    if (height.isEmpty ||
        width.isEmpty ||
        length.isEmpty ||
        height.length == 0 ||
        width.length == 0 ||
        length.length == 0) {
      return '0';
    } else {
      double mmSqMtrValue = 1000000;
      double mmSqMtr =
          (double.parse(width) * double.parse(length)) / mmSqMtrValue;

      return mmSqMtr.toString();
    }
  }

  String roundUp(String netAmount) {
    double itemAmt_ = double.parse(netAmount);
    if (itemAmt == "" || netAmount.length == 0) {
      return '0';
    } else {
      int netItemAmt = itemAmt_.floor();
      double decimalPart = itemAmt_ - netItemAmt;

      if (decimalPart > 0.49) {
        netItemAmt += 1;
      }

      print(netItemAmt);
      return netItemAmt.toString();
    }
  }

  String getAmountInWords(String? sGAmt) {
    if (sGAmt == null || double.tryParse(sGAmt) == null) {
      return 'Invalid Amount';
    }

    final units = [
      '',
      'One',
      'Two',
      'Three',
      'Four',
      'Five',
      'Six',
      'Seven',
      'Eight',
      'Nine'
    ];
    final teens = [
      'Ten',
      'Eleven',
      'Twelve',
      'Thirteen',
      'Fourteen',
      'Fifteen',
      'Sixteen',
      'Seventeen',
      'Eighteen',
      'Nineteen'
    ];
    final tens = [
      '',
      '',
      'Twenty',
      'Thirty',
      'Forty',
      'Fifty',
      'Sixty',
      'Seventy',
      'Eighty',
      'Ninety'
    ];

    String convertLessThanOneThousand(int number) {
      if (number >= 100) {
        return '${units[number ~/ 100]} Hundred ${convertLessThanOneThousand(number % 100)}';
      } else if (number >= 10 && number <= 19) {
        return '${teens[number - 10]}';
      } else if (number < 10) {
        return '${units[number]}';
      } else {
        return '${tens[number ~/ 10]} ${units[number % 10]}';
      }
    }

    String convert(double number) {
      if (number == 0) {
        return 'Zero Rupees Only';
      }

      String result = '';

      if (number < 0) {
        result = 'Negative ';
        number = -number;
      }

      // Handle Crores
      int crorePart = (number / 1e7).floor();
      if (crorePart > 0) {
        result += '${convertLessThanOneThousand(crorePart)} Crore ';
        number %= 1e7;
      }

      // Handle Lakhs
      int lakhPart = (number / 1e5).floor();
      if (lakhPart > 0) {
        result += '${convertLessThanOneThousand(lakhPart)} Lakh ';
        number %= 1e5;
      }

      // Handle Thousands
      int thousandPart = (number / 1e3).floor();
      if (thousandPart > 0) {
        result += '${convertLessThanOneThousand(thousandPart)} Thousand ';
        number %= 1e3;
      }

      // Handle remaining amount
      if (number > 0) {
        result += convertLessThanOneThousand(number.toInt());
      }

      result += ' Rupees';

      // Handling paise
      int paise = ((number % 1) * 100).round();
      if (paise > 0) {
        result += ' ${convertLessThanOneThousand(paise)} Paise';
      }

      result += ' Only';

      return result.trim();
    }

    return convert(double.parse(sGAmt));
  }

  String getFormattedAddress(String address) {
    // adj length of firmadd nd firmcity in 1 form
    const maxLineLength = 110;
    if (address.length > maxLineLength) {
      // Split d add into 2 line
      final firstLine = address.substring(0, maxLineLength);
      final secondLine = address.substring(maxLineLength);
      return '$firstLine\n$secondLine';
    } else {
      // Return d orgnl add if its alrdy shrt
      return address;
    }
  }

  String generateRandomFilename() {
    final randomNumber =
        Random().nextInt(1000000); // Adjust upper limit as needed
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'Bill_${timestamp}_$randomNumber.pdf';
  }

  String generateOnlyFilename(String Imag) {
    final randomNumber =
        Random().nextInt(1000000); // Adjust upper limit as needed
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return '${Imag}${timestamp}_$randomNumber';
  }

  TextEditingValue upperCessConvert(
      TextEditingController controller, String input) {
    return TextEditingValue(
      text: input.toUpperCase(),
      selection: TextSelection.fromPosition(
        TextPosition(offset: input.length),
      ),
    );
  }

  // Map of state names to state codes (with numbers)
  final Map<String, String> stateCodeMap = {
    'ANDAMAN AND NICOBAR ISLANDS': '35',
    'ANDHRA PRADESH': '28',
    'ANDHRA PRADESH(NEW)': '28N',
    'ARUNACHAL PRADESH': '12',
    'ASSAM': '18',
    'BIHAR': '10',
    'CHANDIGARH': '04',
    'CHATTISGARH': '22',
    'DADRA AND NAGAR HAVELI': '26',
    'DAMAN AND DIU': '25',
    'DELHI': '07',
    'GOA': '30',
    'GUJARAT': '24',
    'HARYANA': '06',
    'HIMACHAL PRADESH': '02',
    'JAMMU AND KASHMIR': '01',
    'JHARKHAND': '20',
    'KARNATAKA': '29',
    'KERALA': '32',
    'LAKSHADWEEP ISLANDS': '31',
    'MADHYA PRADESH': '23',
    'MAHARASHTRA': '27',
    'MANIPUR': '14',
    'MEGHALAYA': '17',
    'MIZORAM': '15',
    'NAGALAND': '13',
    'ODISHA': '21',
    'PONDICHERRY': '34',
    'PUNJAB': '03',
    'RAJASTHAN': '08',
    'SIKKIM': '11',
    'TAMIL NADU': '33',
    'TELANGANA': '36',
    'TRIPURA': '16',
    'UTTAR PRADESH': '09',
    'UTTARAKHAND': '05',
    'WEST BENGAL': '19',
  };
}
