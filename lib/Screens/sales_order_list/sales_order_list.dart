import 'package:flutter/material.dart';
import 'package:hamrokhata/commons/widgets/base_widget.dart';

class SalesOrderList extends StatefulWidget {
  const SalesOrderList({super.key});

  @override
  State<SalesOrderList> createState() => _SalesOrderListState();
}

class _SalesOrderListState extends State<SalesOrderList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Sales Order List'),
      ),
      body: BaseWidget(builder: (context, config, theme) {
        return Container(
          padding:
              EdgeInsets.symmetric(vertical: config.appVerticalPaddingMedium()),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Date Filter: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  IconButton(
                    icon: const Icon(Icons.date_range, size: 25),
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2100));

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        // String formattedDate =
                        //     DateFormat('yyyy-MM-dd').format(pickedDate);
                        // print(
                        //     formattedDate); //formatted date output using intl package =>  2021-03-16
                        // setState(() {
                        //   dateInput.text =
                        //       formattedDate; //set output date to TextField value.
                        // });
                      } else {}
                    },
                  ),
                ],
              ),
              const Divider(
                height: 2,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: config.appVerticalPaddingSmall()),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    children: const [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Invoice No. ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Customer Name",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Amount",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 2,
              ),
              Column(
                children: List.generate(
                    1
                    //trackingList.length
                    , (index) {
                  // TrackingModel trackingModel = trackingList[index];
                  return Visibility(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: const [
                            Expanded(
                              flex: 1,
                              child: Text(
                                '100001',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Hari Prasad Shopping Hub',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                '5000',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      }),
      bottomSheet: Container(
        // color: Colors.black45,
        height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const Divider(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Total',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  ' Rs. 5000',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.start,
                )
              ],
            ),
            const Divider(
              height: 2,
            ),
          ],
        ),
      ),
    );
  }
}
