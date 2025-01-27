import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/components/colors.dart';
import 'package:web_admin/controller/v_point_controller.dart';
import 'package:web_admin/models/v_point_model.dart';
import 'package:intl/intl.dart';

class VpointListPage extends StatelessWidget {
  final VpointUpdateController controller = Get.put(VpointUpdateController());
  final TextEditingController searchController = TextEditingController();
  // final OnChangeCallback onback;
  VpointListPage({super.key});
  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        // appBar: AppBar(
        //   title: const Text('VPoint List'),
        // ),
        // body:
        Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 500,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: const InputDecoration(
                            hintText: 'Enter Phone Number or Username',
                            border: InputBorder.none,
                            // prefixIcon:
                            //     Icon(Icons.phone, color: Colors.grey[600]),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (searchController.text.isNotEmpty) {
                            controller
                                .searchphoneandname(searchController.text);
                          }
                        },
                        icon: const Icon(Icons.search),
                        label: const Text('Search'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Obx(() {
            if (controller.isSearch.value) {
              return const CircularProgressIndicator();
            } else if (controller.listsearch.isEmpty) {
              return Expanded(
                child: ListView.builder(
                  itemCount: controller.vpointList.length,
                  itemBuilder: (context, index) {
                    VpointModel vpoint = controller.vpointList[index];
                    return Card(
                      child: ListTile(
                        // leading: CircleAvatar(
                        //   child: Text(vpoint.username?[0] ?? 'N/A'),
                        // ),
                        title: Text(vpoint.username ?? 'N/A',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Tel: ${vpoint.telNum ?? 'N/A'}'),
                            Text('VPoint: ${vpoint.countAutoverbal ?? 'N/A'}',
                                style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold)),
                            Text(
                                'Expire Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(vpoint.expiry ?? ''))}'),
                          ],
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          // Get.to(() => VpointDetailPage(vpoint: vpoint));
                          showBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: whiteColor),
                                    height: 500,
                                    width: 350,
                                    child: VpointDetailPage(vpoint: vpoint),
                                    // child: VpointDetailPage(vpoint: vpoint),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            } else {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: VpointListItem(
                    vpointList:
                        controller.listsearch.cast<VpointModel>().toList(),
                  ),
                ),
              );
            }
          }),
        ],
      ),
    );
    // );
  }
}

class VpointListItem extends StatelessWidget {
  final List<VpointModel> vpointList;

  const VpointListItem({Key? key, required this.vpointList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: vpointList.length,
      itemBuilder: (context, index) {
        final vpoint = vpointList[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(vpoint.username?[0] ?? 'N/A'),
            ),
            title: Text(vpoint.username ?? 'N/A',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tel: ${vpoint.telNum ?? 'N/A'}'),
                Text('VPoint: ${vpoint.countAutoverbal ?? 'N/A'}',
                    style: const TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold)),
                Text('Expire Date: ${_formatDate(vpoint.expiry)}'),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Get.to(() => VpointDetailPage(vpoint: vpoint));
            },
          ),
        );
      },
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'N/A';
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }
}

class VpointDetailPage extends StatelessWidget {
  final VpointModel vpoint;
  final VpointUpdateController controller = Get.find<VpointUpdateController>();
  final TextEditingController countAutoverbalController =
      TextEditingController();
  final TextEditingController createController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController theirPlansController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();
  VpointDetailPage({Key? key, required this.vpoint}) : super(key: key);
  var sizeBox = const SizedBox(height: 10);
  @override
  Widget build(BuildContext context) {
    return
        //  Scaffold(
        // appBar: AppBar(
        //   title: const Text('VPoint Detail'),
        //   actions: [
        //     IconButton(
        //       icon: const Icon(Icons.edit),
        //       onPressed: () {
        //         _showEditDialog(context, vpoint);
        //       },
        //     ),
        //   ],
        // ),
        // body:
        //  SingleChildScrollView(

        // child:
        Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.remove,
                    color: blackColor,
                    size: 30,
                  ))
            ],
          ),
          Center(
            child: CircleAvatar(
              radius: 50,
              child: Text(
                vpoint.username?[0] ?? 'N/A',
                style: const TextStyle(fontSize: 32),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textFiled('Username'),
                  // const Text(
                  //   'Username',
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
                  sizeBox,
                  textFiled('Tel Number'),
                  // const Text(
                  //   'Tel Number',
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
                  sizeBox,
                  textFiled('ID User'),
                  // const Text(
                  //   'ID User',
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
                  sizeBox,
                  textFiled('VPoint'),
                  // const Text(
                  //   'VPoint',
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
                  sizeBox,
                  textFiled('Expire Date'),
                  // const Text(
                  //   'Expire Date',
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
                  sizeBox,
                  textFiled('Their Plans'),
                  // const Text(
                  //   'Their Plans',
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
                  sizeBox,
                  textFiled('Block'),
                  // const Text(
                  //   'Block',
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
                  sizeBox,
                  textFiled('Created Verbals'),
                  // const Text(
                  //   'Created Verbals',
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textFiledValue(vpoint.username ?? 'N/A', blackColor),
                  sizeBox,
                  Text(
                    " : ${vpoint.telNum ?? 'N/A'}",
                    style: const TextStyle(color: Colors.blue),
                  ),
                  sizeBox,
                  Text(
                    " : ${vpoint.idUserControl ?? 'N/A'}",
                    // vpoint.idUserControl ?? 'N/A',
                    style: const TextStyle(color: Colors.blue),
                  ),
                  sizeBox,
                  Text(
                    " : ${vpoint.countAutoverbal ?? 'N/A'}",
                    // '${vpoint.countAutoverbal}',
                    style: const TextStyle(color: Colors.blue),
                  ),
                  sizeBox,
                  Text(
                    " : ${_formatDate(vpoint.expiry)}",
                    style: const TextStyle(color: Colors.blue),
                  ),
                  sizeBox,
                  Text(
                    " : ${vpoint.theirPlans ?? 'N/A'}",
                    // '${vpoint.theirPlans}',
                    style: const TextStyle(color: Colors.blue),
                  ),
                  sizeBox,
                  Text(
                    " : ${vpoint.balance ?? 'N/A'}",
                    style: const TextStyle(color: Colors.blue),
                  ),
                  sizeBox,
                  Text(
                    " : ${vpoint.createdVerbals ?? 'N/A'}",
                    style: const TextStyle(color: Colors.blue),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          IconButton(
            icon: const Icon(
              Icons.edit,
              size: 30,
            ),
            onPressed: () {
              _showEditDialog(context, vpoint);
            },
          ),
          // DetailItem(label: 'Username', value: vpoint.username ?? 'N/A'),
          // DetailItem(label: 'Tel Number', value: vpoint.telNum ?? 'N/A'),
          // DetailItem(label: 'ID User', value: vpoint.idUserControl ?? 'N/A'),
          // DetailItem(
          //     label: 'VPoint',
          //     value: '${vpoint.countAutoverbal}',
          //     valueColor: Colors.blue),
          // DetailItem(label: 'Expire Date', value: _formatDate(vpoint.expiry)),
          // DetailItem(label: 'Their Plans', value: vpoint.theirPlans ?? 'N/A'),
          // DetailItem(label: 'Block', value: '${vpoint.balance}'),
          // DetailItem(
          //     label: 'Created Verbals', value: '${vpoint.createdVerbals}'),
        ],
      ),
    );
    // ),
    // );
  }

  Widget textFiled(String title) {
    return Text(
      title,
      style: TextStyle(color: greyColorNolots, fontWeight: FontWeight.bold),
    );
  }

  Widget textFiledValue(String value, Color color) {
    return Text(
      " : $value",
      style: TextStyle(color: color, fontWeight: FontWeight.bold),
    );
  }

  void _showEditDialog(BuildContext context, VpointModel vpoint) {
    final updatedVpoint = VpointModel(
      iDControl: vpoint.iDControl,
      idUserControl: vpoint.idUserControl,
      countAutoverbal: vpoint.countAutoverbal,
      create: vpoint.create,
      expiry: vpoint.expiry,
      theirPlans: vpoint.theirPlans,
      balance: vpoint.balance,
      createdVerbals: vpoint.createdVerbals,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update VPoint'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller:
                      TextEditingController(text: '${vpoint.countAutoverbal}'),
                  decoration: const InputDecoration(
                    labelText: 'VPoint',
                    prefixIcon: Icon(Icons.confirmation_number),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    vpoint.countAutoverbal = int.tryParse(value) ?? 0;
                  },
                ),
                GestureDetector(
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: vpoint.expiry != null
                          ? DateTime.parse(vpoint.expiry!)
                          : DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate:
                          DateTime.now().add(const Duration(days: 365 * 5)),
                    );
                    if (picked != null) {
                      final newExpiry = picked.toIso8601String().split('T')[0];
                      vpoint.expiry = newExpiry;
                      updatedVpoint.expiry = newExpiry;
                      // Update the TextField immediately
                      controller
                          .update(); // Use GetX controller to update the UI
                    }
                  },
                  child: AbsorbPointer(
                    child: Obx(() => TextField(
                          // Use Obx for reactive UI updates
                          controller: TextEditingController(
                              text:
                                  _formatDate(controller.vpoint.value.expiry)),
                          decoration: const InputDecoration(
                            labelText: 'Expire Date',
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                        )),
                  ),
                ),
                TextField(
                  controller:
                      TextEditingController(text: '${vpoint.theirPlans}'),
                  decoration: const InputDecoration(
                    labelText: 'Their Plans',
                    prefixIcon: Icon(Icons.list_alt),
                  ),
                  onChanged: (value) {
                    vpoint.theirPlans = value;
                  },
                ),
                TextField(
                  controller: TextEditingController(text: '${vpoint.balance}'),
                  decoration: const InputDecoration(
                    labelText: 'Balance',
                    prefixIcon: Icon(Icons.account_balance_wallet),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    vpoint.balance = int.tryParse(value) ?? 0;
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: const Text('Update'),
              onPressed: () async {
                final updatedVpoint = VpointModel(
                  iDControl: vpoint.iDControl,
                  idUserControl: vpoint.idUserControl,
                  countAutoverbal: vpoint.countAutoverbal,
                  create: vpoint.create,
                  expiry: vpoint.expiry,
                  theirPlans: vpoint.theirPlans,
                  balance: vpoint.balance,
                  createdVerbals: controller.vpoint.value.createdVerbals,
                );
                try {
                  await controller.handleUpdate(updatedVpoint);
                  Navigator.of(context).pop(); // Close the dialog
                  Get.snackbar(
                    'Success',
                    'VPoint updated successfully',
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                } catch (e) {
                  Get.snackbar(
                    'Error',
                    'Update failed: ${e.toString()}',
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'N/A';
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }
}

class DetailItem extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const DetailItem(
      {Key? key, required this.label, required this.value, this.valueColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(color: valueColor),
          ),
        ],
      ),
    );
  }
}
