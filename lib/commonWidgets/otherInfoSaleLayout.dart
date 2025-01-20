import 'package:flutter/material.dart';

class OtherInfoSaleLayout {
  static void otherInfoLayout(
    BuildContext context,
    TextEditingController controllerSiteName,
    TextEditingController controllerDChalanNo,
    TextEditingController controllerDeliveryDate,
    TextEditingController controllerPoNo,
    TextEditingController controllerPoDate,
    TextEditingController controllerTransport,
    TextEditingController controllerCreditDays,
    TextEditingController controllerVerifyBy,
    TextEditingController controllerLrNo,
    TextEditingController controllerProjctName,
    TextEditingController controllerProjectTeam,
    TextEditingController controllerPaymentCrDays,
    TextEditingController controllerPaymentCrDate,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Card(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Other Details',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: controllerSiteName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Site Name',
                    ),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: controllerDChalanNo,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'D. Chalan No',
                    ),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: controllerDeliveryDate,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Delivery Date',
                    ),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: controllerPoNo,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Po No.',
                    ),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: controllerPoDate,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Po Date',
                    ),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: controllerTransport,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Transport No',
                    ),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: controllerCreditDays,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Credit Days',
                    ),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: controllerVerifyBy,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Verify By',
                    ),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: controllerLrNo,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'LR No.',
                    ),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: controllerProjctName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Projct Name',
                    ),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: controllerProjectTeam,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Projct Team',
                    ),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: controllerPaymentCrDays,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Payment Cr Days',
                    ),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: controllerPaymentCrDate,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Payment Cr Date',
                    ),
                  ),
                  SizedBox(height: 13),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      label: Text('Add'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
