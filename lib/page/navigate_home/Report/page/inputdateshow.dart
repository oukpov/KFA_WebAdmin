import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../Profile/contants.dart';
import '../../../../../../components/ApprovebyAndVerifyby.dart';
import '../../../../../../components/colors/colors.dart';

class InputDatetshow extends StatelessWidget {
  final String fieldName;
  final int flex;
  final ValueNotifier<String?> dateNotifier;

  const InputDatetshow({
    Key? key,
    required this.fieldName,
    required this.flex,
    required this.dateNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: SizedBox(
        height: 35,
        child: ValueListenableBuilder<String?>(
            valueListenable: dateNotifier,
            builder: (context, dateValue, child) {
              return TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.calendar_today),
                  labelText: fieldName,
                  border: const OutlineInputBorder(),
                ),
                readOnly: true,
                controller: TextEditingController(text: dateValue ?? ''),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );

                  if (pickedDate != null) {
                    String formattedDate =
                        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                    dateNotifier.value = formattedDate;
                  }
                },
              );
            }),
      ),
    );
  }
}
