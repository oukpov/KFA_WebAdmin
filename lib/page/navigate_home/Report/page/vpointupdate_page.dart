import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/controller/v_point_controller.dart';
import 'package:web_admin/models/v_point_model.dart';

class VpointUpdatePage extends StatefulWidget {
  final VpointModel vpoint;

  VpointUpdatePage({required this.vpoint});

  @override
  _VpointUpdatePageState createState() => _VpointUpdatePageState();
}

class _VpointUpdatePageState extends State<VpointUpdatePage> {
  final VpointUpdateController controller = Get.find<VpointUpdateController>();
  late TextEditingController telNumController;
  late TextEditingController usernameController;
  late TextEditingController balanceController;

  @override
  void initState() {
    super.initState();
    telNumController = TextEditingController(text: widget.vpoint.telNum);
    usernameController = TextEditingController(text: widget.vpoint.username);
    balanceController =
        TextEditingController(text: widget.vpoint.balance?.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit VPoint (ID: ${widget.vpoint.iDControl})'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: telNumController,
              decoration: InputDecoration(labelText: 'Telephone Number'),
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: balanceController,
              decoration: InputDecoration(labelText: 'Balance'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Create a new VpointModel with updated values
                VpointModel updatedVpoint = VpointModel(
                  iDControl: widget.vpoint.iDControl,
                  telNum: telNumController.text,
                  username: usernameController.text,
                  balance: int.tryParse(balanceController.text),
                  // Add other fields here, keeping their original values
                  idUserControl: widget.vpoint.idUserControl,
                  countAutoverbal: widget.vpoint.countAutoverbal,
                  create: widget.vpoint.create,
                  expiry: widget.vpoint.expiry,
                  theirPlans: widget.vpoint.theirPlans,
                  createdVerbals: widget.vpoint.createdVerbals,
                );

                // Call the update function
                // await controller.updateVpoint(updatedVpoint.iDControl, updatedVpoint.countAutoverbal, updatedVpoint.create, updatedVpoint.expiry, updatedVpoint.theirPlans, updatedVpoint.balance!);

                // Go back to the previous screen
                Get.back();
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    telNumController.dispose();
    usernameController.dispose();
    balanceController.dispose();
    super.dispose();
  }
}
