import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/about_us_controller.dart';

class AboutUsTextUpdatePage extends StatefulWidget {
  const AboutUsTextUpdatePage({Key? key}) : super(key: key);

  @override
  State<AboutUsTextUpdatePage> createState() => _AboutUsTextUpdatePageState();
}

class _AboutUsTextUpdatePageState extends State<AboutUsTextUpdatePage> {
  final AboutUsController _aboutUsController = Get.find<AboutUsController>();

  final TextEditingController _dearValueCustomerController =
      TextEditingController();
  final TextEditingController _companyOverviewController =
      TextEditingController();
  final TextEditingController _visionMissionController =
      TextEditingController();
  final TextEditingController _ourPeopleController = TextEditingController();
  final TextEditingController _companyProfileController =
      TextEditingController();
  final TextEditingController _aboutCaptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCurrentData();
  }

  void _loadCurrentData() {
    _dearValueCustomerController.text =
        _aboutUsController.aboutUsData.value.dearValueCustomer ?? '';
    _companyOverviewController.text =
        _aboutUsController.aboutUsData.value.companyOverview ?? '';
    _visionMissionController.text =
        _aboutUsController.aboutUsData.value.visionMission ?? '';
    _ourPeopleController.text =
        _aboutUsController.aboutUsData.value.ourPeople ?? '';
    _companyProfileController.text =
        _aboutUsController.aboutUsData.value.companyProfile ?? '';
    _aboutCaptionController.text =
        _aboutUsController.aboutUsData.value.aboutCaption ?? '';
  }

  @override
  void dispose() {
    _dearValueCustomerController.dispose();
    _companyOverviewController.dispose();
    _visionMissionController.dispose();
    _ourPeopleController.dispose();
    _companyProfileController.dispose();
    _aboutCaptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update About Us Content'),
      ),
      body: Obx(
        () => _aboutUsController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildTextField(
                      'About Caption',
                      _aboutCaptionController,
                      maxLines: 5,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      'Dear Value Customer',
                      _dearValueCustomerController,
                      maxLines: 5,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      'Company Overview',
                      _companyOverviewController,
                      maxLines: 5,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      'Vision & Mission',
                      _visionMissionController,
                      maxLines: 5,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      'Our People',
                      _ourPeopleController,
                      maxLines: 5,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      'Company Profile',
                      _companyProfileController,
                      maxLines: 5,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _updateContent,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Update Content'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        alignLabelWithHint: true,
      ),
    );
  }

  void _updateContent() async {
    try {
      await _aboutUsController.updateAboutUsData(
        dearValueCustomer: _dearValueCustomerController.text,
        companyOverview: _companyOverviewController.text,
        visionMission: _visionMissionController.text,
        ourPeople: _ourPeopleController.text,
        companyProfile: _companyProfileController.text,
        aboutCaption: _aboutCaptionController.text,
      );

      Get.snackbar(
        'Success',
        'Content updated successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );

      // Refresh data after update
      await _aboutUsController.fetchAboutUsData();
      _loadCurrentData();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update content: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
