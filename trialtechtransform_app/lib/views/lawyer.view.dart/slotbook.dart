import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlotBookingTable extends StatelessWidget {
  // Sample data for the table (you can replace it with your data).
  final List<SlotData> slotData = [
    SlotData(date: '2023-09-17', time: '10:00 AM', slots: 3),
    SlotData(date: '2023-09-17', time: '11:00 AM', slots: 2),
    SlotData(date: '2023-09-18', time: '02:00 PM', slots: 4),
    // Add more slot data here.
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slot Booking Table'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: _buildColumns(),
          rows: _buildRows(),
        ),
      ),
    );
  }

  List<DataColumn> _buildColumns() {
    // Create a list of DataColumns with date and time values.
    return [
      DataColumn(label: Text('Date')),
      DataColumn(label: Text('Time')),
      for (var slot in slotData)
        DataColumn(
          label: Text('${slot.date} ${slot.time}'),
        ),
    ];
  }

  List<DataRow> _buildRows() {
    // Create a list of DataRows with available slot values.
    return slotData.map((slot) {
      return DataRow(
        cells: [
          DataCell(Text(slot.date)),
          DataCell(Text(slot.time)),
          for (var i = 0; i < slotData.length; i++)
            DataCell(Text(slotData[i].slots.toString())),
        ],
      );
    }).toList();
  }
}

class SlotData {
  final String date;
  final String time;
  final int slots;

  SlotData({required this.date, required this.time, required this.slots});
}
