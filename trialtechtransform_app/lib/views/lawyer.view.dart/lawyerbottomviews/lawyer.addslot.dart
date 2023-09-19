import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../constants/colors.dart';
import '../../../constants/global.var.dart';
import '../../../constants/size.config.dart';
import '../../../services/lawyer.services.dart';
import '../../widgets/custom.widgets.dart';

class AddSlot extends StatefulWidget {
  const AddSlot({super.key});

  @override
  State<AddSlot> createState() => _AddSlotState();
}

class _AddSlotState extends State<AddSlot> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  Future _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      print('Time selected: ${selectedTime.toString()}');
      setState(() {
        selectedTime = picked;
      });
    }
  }

  String dropDownValue = "Monday";
  bool expand = true;

  List<String> list = <String>[
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    "Friday",
    "Saturday",
    "Sunday"
  ];

  TextEditingController amt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Container(
              decoration: BoxDecoration(
                  color: darkBlue, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          expand = !expand;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Add Your Slot",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 20, color: palletWhite),
                          ),
                          (expand)
                              ? Icon(
                                  CupertinoIcons.minus,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )
                        ],
                      ),
                    ),
                    (expand)
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  _selectDate(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: greybg,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontSize: 20,
                                                  color: darkBlue),
                                        ),
                                        const Icon(
                                          Icons.calendar_month,
                                          color: darkBlue,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  _selectTime(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: greybg,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${selectedTime.hour} : ${selectedTime.minute}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontSize: 20,
                                                  color: darkBlue),
                                        ),
                                        const Icon(
                                          Icons.watch_later_sharp,
                                          color: darkBlue,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                    fillColor: greybg,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none)),
                                value: dropDownValue,
                                icon: const Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: darkBlue,
                                ),
                                elevation: 16,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontSize: 18),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    dropDownValue = value!;
                                  });
                                },
                                items: list.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: amt,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 18, color: Colors.black),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: "Amount",
                                    filled: true,
                                    fillColor: greybg,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: SizeConfig.width / 2,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(pYellow)),
                                    onPressed: () {
                                      LawyerService().addSlot(
                                          DateTime(
                                              selectedDate.year,
                                              selectedDate.month,
                                              selectedDate.day,
                                              selectedTime.hour,
                                              selectedTime.minute),
                                          dropDownValue,
                                          amt.text.toString());
                                      CustomWidget()
                                          .snackBar("Slot Added", context, 500);
                                      setState(() {
                                        expand = !expand;
                                      });
                                    },
                                    child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 12),
                                        child: Text(
                                          "Add Slot",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontSize: 18,
                                              ),
                                        ))),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ),
          StreamBuilder(
              stream: GlobalVars.store
                  .collection("lawyer")
                  .doc(GlobalVars.auth.currentUser!.uid)
                  .collection("slots")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Added Slot",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 20),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DateTime cdate =
                                snapshot.data!.docs[index].get("date").toDate();
                            String date = cdate.day.toString();
                            String month = cdate.month.toString();
                            String yr = cdate.year.toString();

                            String hr = cdate.hour.toString();
                            String min = cdate.minute.toString();
                            return Card(
                              color: extraLightBlue,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "$date-$month-$yr",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(fontSize: 18),
                                    ),
                                    Text(
                                      snapshot.data!.docs[index].get("day"),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(fontSize: 18),
                                    ),
                                    Text(
                                      "$hr : $min",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(fontSize: 18),
                                    ),
                                    Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return const Center(
                    child: Text("Error"),
                  );
                }

                return const Center(
                  child: Text("Loading"),
                );
              })
        ],
      ),
    );
  }
}
