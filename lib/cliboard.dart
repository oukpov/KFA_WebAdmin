import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class HomePageClipboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Cloner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FileCloner(),
    );
  }
}

class FileCloner extends StatefulWidget {
  @override
  _FileClonerState createState() => _FileClonerState();
}

class _FileClonerState extends State<FileCloner> {
  String _statusMessage = '';

  Future<void> cloneFile(
      String sourceFilePath, String destinationFileName) async {
    try {
      // Get the application's documents directory
      final directory = await getApplicationDocumentsDirectory();

      // Create a File instance for the source file
      final sourceFile = File(sourceFilePath);

      // Create a File instance for the destination file
      final destinationFilePath = '${directory.path}/$destinationFileName';
      final destinationFile = File(destinationFilePath);

      // Copy the source file to the destination file
      await sourceFile.copy(destinationFile.path);

      setState(() {
        _statusMessage = 'File copied to $destinationFilePath';
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Error copying file: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Cloner'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                String sourcePath =
                    '/path/to/source/file.txt'; // Replace with the path to the source file
                String destinationFileName =
                    'cloned_file.txt'; // Replace with the desired name for the destination file

                await cloneFile(sourcePath, destinationFileName);
              },
              child: Text('Clone File'),
            ),
            SizedBox(height: 20),
            Text(_statusMessage),
          ],
        ),
      ),
    );
  }
}
