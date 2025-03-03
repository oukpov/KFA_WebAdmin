import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../../../../../components/ApprovebyAndVerifyby.dart';
import 'colors.dart';

class DropdownOption extends StatefulWidget {
  const DropdownOption(
      {Key? key,
      required this.value,
      required this.valuenameback,
      required this.lable,
      required this.dataname,
      required this.dataid,
      required this.listData,
      required this.icon})
      : super(key: key);
  final OnChangeCallback value;
  final OnChangeCallback valuenameback;
  final String dataname;
  final String dataid;
  final String lable;
  final IconData icon;
  final List<Map<dynamic, dynamic>> listData;
  @override
  State<DropdownOption> createState() => _valueDropdownState();
}

class _valueDropdownState extends State<DropdownOption> {
  bool districtw = false;
  bool checkproperty = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 150,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: kPrimaryColor),
                  borderRadius: BorderRadius.circular(10)),
              child: DropdownSearch<Map<dynamic, dynamic>>(
                items: widget.listData,
                compareFn: (item1, item2) {
                  return item1[widget.dataname] == item2[widget.dataname];
                },
                validator: (value) {
                  setState(() {
                    if (value == null || value.isEmpty) {
                      checkproperty = true;
                    } else {
                      checkproperty = false;
                    }
                  });
                  return null;
                },
                popupProps: PopupProps.menu(
                  isFilterOnline: true,
                  showSearchBox: true,
                  showSelectedItems: true,
                  itemBuilder: (context, item, isSelected) {
                    return ListTile(
                      title: Text(item[widget.dataname] ?? ''),
                      selected: isSelected,
                    );
                  },
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Search',
                        label: Text(widget.lable)),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    widget.value(value?[widget.dataid].toString());
                    widget.valuenameback(value?[widget.dataname].toString());
                  });
                },
                selectedItem: const {"value": "A"},
                dropdownDecoratorProps: DropDownDecoratorProps(
                  // dropdownSearchDecoration: InputDecoration(
                  //   border: InputBorder.none,
                  // ),
                  dropdownSearchDecoration: InputDecoration(
                    fillColor: kwhite,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    hintText: widget.lable,
                    hintStyle: TextStyle(
                        color: !checkproperty ? greyColorNolots : colorsRed),
                    prefixIcon: Icon(
                      widget.icon,
                      color: kImageColor,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: kPrimaryColor, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: kPrimaryColor,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: kerror,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 2,
                        color: kerror,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                filterFn: (item, filter) {
                  return item[widget.dataname]
                          ?.toLowerCase()
                          .contains(filter.toLowerCase()) ??
                      false;
                },
                itemAsString: (item) => item[widget.dataname] ?? '',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
