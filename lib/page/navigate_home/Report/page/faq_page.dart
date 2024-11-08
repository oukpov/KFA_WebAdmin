import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/faq_controller.dart';
import '../../../../models/faq_model.dart';

class FaqPage extends StatelessWidget {
  final FaqController faqController = Get.put(FaqController());
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          'Frequently Asked Questions',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle, color: Colors.white, size: 28),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Row(
                      children: [
                        Icon(Icons.question_answer, color: Colors.blue[900]),
                        const SizedBox(width: 8),
                        Text('Add New FAQ',
                            style: TextStyle(
                                color: Colors.blue[900],
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: questionController,
                            decoration: InputDecoration(
                              labelText: 'Question',
                              labelStyle: TextStyle(color: Colors.blue[900]),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.blue[900]!),
                              ),
                              prefixIcon: Icon(Icons.help_outline,
                                  color: Colors.blue[900]),
                            ),
                            maxLines: 2,
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: answerController,
                            decoration: InputDecoration(
                              labelText: 'Answer',
                              labelStyle: TextStyle(color: Colors.blue[900]),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.blue[900]!),
                              ),
                              prefixIcon: Icon(Icons.edit_note,
                                  color: Colors.blue[900]),
                            ),
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel',
                            style: TextStyle(color: Colors.grey[600])),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () async {
                          if (questionController.text.isNotEmpty &&
                              answerController.text.isNotEmpty) {
                            await faqController.insertFaqData(
                              FaqModel(
                                question: questionController.text,
                                answer: answerController.text,
                              ),
                            );
                            questionController.clear();
                            answerController.clear();
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                            await faqController.fetchFaqData();
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text('Save',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        if (faqController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.blue[900],
            ),
          );
        } else {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue[50]!, Colors.white],
              ),
            ),
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: faqController.faqList.length,
              itemBuilder: (context, index) {
                FaqModel faq = faqController.faqList[index];
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ExpansionTile(
                    leading: Icon(
                      Icons.question_answer,
                      color: Colors.blue[900],
                    ),
                    title: Text(
                      faq.question ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.blue[900],
                      ),
                    ),
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        color: Colors.grey[50],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              faq.answer ?? '',
                              style: TextStyle(
                                fontSize: 15,
                                height: 1.5,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon:
                                      Icon(Icons.edit, color: Colors.blue[900]),
                                  onPressed: () {
                                    questionController.text =
                                        faq.question ?? '';
                                    answerController.text = faq.answer ?? '';
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Row(
                                            children: [
                                              Icon(Icons.edit,
                                                  color: Colors.blue[900]),
                                              const SizedBox(width: 8),
                                              Text('Edit FAQ',
                                                  style: TextStyle(
                                                      color: Colors.blue[900],
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextField(
                                                  controller:
                                                      questionController,
                                                  decoration: InputDecoration(
                                                    labelText: 'Question',
                                                    labelStyle: TextStyle(
                                                        color:
                                                            Colors.blue[900]),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .blue[900]!),
                                                    ),
                                                    prefixIcon: Icon(
                                                        Icons.help_outline,
                                                        color:
                                                            Colors.blue[900]),
                                                  ),
                                                  maxLines: 2,
                                                ),
                                                const SizedBox(height: 16),
                                                TextField(
                                                  controller: answerController,
                                                  decoration: InputDecoration(
                                                    labelText: 'Answer',
                                                    labelStyle: TextStyle(
                                                        color:
                                                            Colors.blue[900]),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .blue[900]!),
                                                    ),
                                                    prefixIcon: Icon(
                                                        Icons.edit_note,
                                                        color:
                                                            Colors.blue[900]),
                                                  ),
                                                  maxLines: 3,
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                questionController.clear();
                                                answerController.clear();
                                                Navigator.pop(context);
                                              },
                                              child: Text('Cancel',
                                                  style: TextStyle(
                                                      color: Colors.grey[600])),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.blue[900],
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              onPressed: () async {
                                                if (questionController
                                                        .text.isNotEmpty &&
                                                    answerController
                                                        .text.isNotEmpty) {
                                                  await faqController
                                                      .updateFaqData(
                                                    FaqModel(
                                                      question:
                                                          questionController
                                                              .text,
                                                      answer:
                                                          answerController.text,
                                                    ),
                                                    int.parse(faq.id!),
                                                  );
                                                  questionController.clear();
                                                  answerController.clear();
                                                  Navigator.pop(context);
                                                  await faqController
                                                      .fetchFaqData();
                                                }
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8),
                                                child: Text('Update',
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Row(
                                            children: const [
                                              Icon(Icons.warning,
                                                  color: Colors.red),
                                              SizedBox(width: 8),
                                              Text('Delete FAQ',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                          content: const Text(
                                              'Are you sure you want to delete this FAQ?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text('Cancel',
                                                  style: TextStyle(
                                                      color: Colors.grey[600])),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.red,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              onPressed: () async {
                                                await faqController
                                                    .deleteFaqData(
                                                        int.parse(faq.id!));
                                                // ignore: use_build_context_synchronously
                                                Navigator.pop(context);
                                                await faqController
                                                    .fetchFaqData();
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8),
                                                child: Text('Delete',
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
      }),
    );
  }
}
