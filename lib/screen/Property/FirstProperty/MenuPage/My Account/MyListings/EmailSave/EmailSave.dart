import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../../../../components/colors.dart';
import '../../../../../../../components/first_pay.dart';
import '../../../../component/Header.dart';
import '../../../../component/fonttext/fontText.dart';
import '../../../DetailScreen/DetailAll.dart';

class EmailSave extends StatefulWidget {
  EmailSave(
      {super.key,
      required this.device,
      required this.list,
      required this.listBack,
      required this.checkboxValues,
      required this.listAll,
      required this.myIdcontroller});
  final String device;
  late List list;
  late List listAll;
  final String myIdcontroller;
  final OnChangeCallback listBack;
  final OnChangeCallback checkboxValues;
  @override
  State<EmailSave> createState() => _EmailSaveState();
}

class _EmailSaveState extends State<EmailSave> {
  List<bool> checkboxValues = [];

  List list = [];
  @override
  void initState() {
    super.initState();
    listViewAll();
  }

  void listViewAll() {
    setState(() {
      list = widget.list;
      for (int i = 0; i < list.length; i++) {
        if (list[i]['check'].toString() == 'true') {
          listView.add(list[i]);
        }
      }
    });
  }

  List listView = [];
  double w = 0;
  double l = 0;
  double r = 0;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              print('Print');
            },
            child: Container(
              decoration: BoxDecoration(
                  color: whiteColor, borderRadius: BorderRadius.circular(5)),
              height: MediaQuery.of(context).size.height * 0.7,
              width: (widget.device == 'M')
                  ? MediaQuery.of(context).size.width
                  : (widget.device == 'T')
                      ? 500
                      : 700,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      color: backgroundScreen,
                      height: 50,
                      width: (widget.device == 'M')
                          ? MediaQuery.of(context).size.width
                          : (widget.device == 'T')
                              ? 500
                              : 700,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            const Text('Email Save'),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                    Icons.remove_circle_outline_outlined))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: (widget.device == 'M')
                          ? MediaQuery.of(context).size.width
                          : (widget.device == 'T')
                              ? 500
                              : 700,
                      color: const Color.fromARGB(255, 187, 181, 181),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (int i = 0; i < listView.length; i++)
                              Text('No. ${listView[i]['id_ptys']}')
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: (widget.device == 'M')
                          ? MediaQuery.of(context).size.width
                          : (widget.device == 'T')
                              ? 500
                              : 700,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 0.5, color: greyColor)),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      listView = [];
                                      widget.listBack(true);
                                      checkboxValues = List.generate(
                                          widget.listAll.length,
                                          (index) => false);

                                      widget.checkboxValues(checkboxValues);
                                    });
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: whiteNotFullColor50),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text('Clear All'),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Wrap(
                              children: [
                                if (w < 770)
                                  optionPropertyMobile()
                                else if (w < 1199)
                                  optionPropertyTablet()
                                else
                                  optionPropertyDekTop(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget optionPropertyMobile() {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 12.0,
      runSpacing: 12.0,
      children: <Widget>[
        for (int i = 0; i < listView.length; i++)
          if (w < 500)
            imageUrl(i, 200, 700, 0, listView)
          else
            imageUrl(i, 250, 600, r, listView)
      ],
    );
  }

  Widget optionPropertyTablet() {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 12.0,
      runSpacing: 12.0,
      children: <Widget>[
        for (int i = 0; i < listView.length; i++)
          if (w >= 770 && w < 991)
            imageUrl(i, 200, 350, 0, listView)
          else
            imageUrl(i, 200, 300, 0, listView)
      ],
    );
  }

  Widget optionPropertyDekTop() {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Wrap(
        direction: Axis.horizontal,
        spacing: 12.0,
        runSpacing: 12.0,
        children: <Widget>[
          for (int i = 0; i < listView.length; i++)
            if (w > 1199) imageUrl(i, 180, 280, 0, listView)
        ],
      ),
    );
  }

  Widget imageUrl(int index, double hPic, wPic, r, List list) {
    var fontValue = TextStyle(
        fontSize: MediaQuery.textScaleFactorOf(context) * 13,
        color: const Color.fromARGB(255, 64, 65, 64));
    return InkWell(
      onTap: () {
        print(list[index].toString());
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return DetailScreen(
              myIdcontroller: widget.myIdcontroller,
              index: index.toString(),
              list: list,
              verbalID: list[index]['id_ptys'].toString(),
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: Form(
          child: Card(
            elevation: 10,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              width: wPic,
              child: Column(
                children: [
                  // Container(
                  //   height: hPic,
                  //   width: wPic,
                  //   color: Colors.red,
                  //   child: Text('No. $index(page:$deTailPage4)'),
                  // )

                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            child: CachedNetworkImage(
                              imageUrl: list[index]['url'].toString(),
                              fit: BoxFit.cover,
                              height: hPic,
                              width: wPic,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            )),
                      ),
                      // Positioned(
                      //   top: MediaQuery.of(context).size.height * 0.01,
                      //   child: type('type', 12, index, list),
                      // ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            fontSizes('', 'urgent', 12, index, list, context),
                            textS(context),
                            fontSizes(
                                '', 'Name_cummune', 12, index, list, context),
                          ],
                        ),
                        size7,
                        Row(
                          children: [
                            fontSizes(
                                'Price', 'price', 12, index, list, context),
                            textS(context),
                            fontSizes('Bed', 'bed', 12, index, list, context),
                          ],
                        ),
                        size7,
                        Row(
                          children: [
                            fontSizes('Land', 'land', 12, index, list, context),
                            textS(context),
                            fontSizes('Bath', 'bath', 12, index, list, context),
                          ],
                        ),
                        size7,
                        Text(
                          '${(list[index]['address'].toString() == "null") ? "" : list[index]['address']}, ${(list[index]['Name_cummune'].toString() == "null") ? "" : list[index]['Name_cummune']} ,Cambodia',
                          style: fontValue,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
