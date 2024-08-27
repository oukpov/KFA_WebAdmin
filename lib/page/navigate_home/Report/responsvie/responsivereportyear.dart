import 'package:flutter/widgets.dart';
import '../page/comparablereportyear.dart';

class ResponsiveReportYear extends StatefulWidget {
  const ResponsiveReportYear({
    super.key,
  });
  @override
  State<ResponsiveReportYear> createState() => _ResponsiveReportYearState();
}

class _ResponsiveReportYearState extends State<ResponsiveReportYear> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 770) {
          return const ComparableReportYear(
            device: 'm',
            // email: '',
            // idUsercontroller: '',
            // myIdcontroller: '',
          );
        } else if (constraints.maxWidth < 1199) {
          return const ComparableReportYear(
            device: 'd',
            // email: '',
            // idUsercontroller: '',
            // myIdcontroller: '',
          );
        } else {
          return const ComparableReportYear(
            device: 'd',
            // email: '',
            // idUsercontroller: '',
            // myIdcontroller: '',
          );
        }
      },
    );
  }
}
