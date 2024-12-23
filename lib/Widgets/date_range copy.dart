// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class SimpleDateRangePicker extends StatefulWidget {
//   final Function(DateTime? startDate, DateTime? endDate) onDateRangeSelected;

//   const SimpleDateRangePicker({
//     Key? key,
//     required this.onDateRangeSelected,
//   }) : super(key: key);

//   @override
//   _SimpleDateRangePickerState createState() => _SimpleDateRangePickerState();
// }

// class _SimpleDateRangePickerState extends State<SimpleDateRangePicker> {
//   DateTime? _startDate;
//   DateTime? _endDate;
//   final TextEditingController _startDateController = TextEditingController();
//   final TextEditingController _endDateController = TextEditingController();
//   final DateFormat _dateFormat = DateFormat('dd MMM yyyy');

//   @override
//   void initState() {
//     super.initState();
//     _updateTextFields();
//   }

//   void _updateTextFields() {
//     _startDateController.text =
//         _startDate != null ? _dateFormat.format(_startDate!) : '';
//     _endDateController.text =
//         _endDate != null ? _dateFormat.format(_endDate!) : '';
//   }

//   Future<void> _selectDate(BuildContext context, bool isStartDate) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: isStartDate
//           ? (_startDate ?? DateTime.now())
//           : (_endDate ??
//               _startDate?.add(const Duration(days: 1)) ??
//               DateTime.now()),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );

//     if (picked != null) {
//       setState(() {
//         if (isStartDate) {
//           if (_endDate != null && picked.isAfter(_endDate!)) {
//             _showDateRangeError();
//             return;
//           }
//           _startDate = picked;
//         } else {
//           if (_startDate != null && picked.isBefore(_startDate!)) {
//             _showDateRangeError();
//             return;
//           }
//           _endDate = picked;
//         }
//         _updateTextFields();
//         widget.onDateRangeSelected(_startDate, _endDate);
//       });
//     }
//   }

//   void _showDateRangeError() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Invalid date range selected'),
//         backgroundColor: Colors.redAccent,
//       ),
//     );
//   }

//   Widget _buildDateField({
//     required TextEditingController controller,
//     required String label,
//     required bool isStartDate,
//   }) {
//     return TextFormField(
//       controller: controller,
//       readOnly: true,
//       onTap: () => _selectDate(context, isStartDate),
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: const TextStyle(
//           fontWeight: FontWeight.bold,
//           color: Colors.blueAccent,
//         ),
//         suffixIcon: const Icon(Icons.calendar_today, color: Colors.blueAccent),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
//         ),
//         filled: true,
//         fillColor: Colors.blue.withOpacity(0.05),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: _buildDateField(
//             controller: _startDateController,
//             label: 'Start Date',
//             isStartDate: true,
//           ),
//         ),
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 8.0),
//           child: Icon(Icons.arrow_forward, color: Colors.blueAccent),
//         ),
//         Expanded(
//           child: _buildDateField(
//             controller: _endDateController,
//             label: 'End Date',
//             isStartDate: false,
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   void dispose() {
//     _startDateController.dispose();
//     _endDateController.dispose();
//     super.dispose();
//   }
// }
