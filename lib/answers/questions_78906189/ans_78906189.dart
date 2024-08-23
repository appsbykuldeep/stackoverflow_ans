// How can I make an image fill the entire PDF page?

import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:stackoverflow_ans/extensions/context_ext.dart';

import 'create_pdf.dart';

class Ans78906189 extends StatefulWidget {
  const Ans78906189({super.key});

  @override
  State<Ans78906189> createState() => _Ans78906189State();
}

class _Ans78906189State extends State<Ans78906189> {
  ScreenshotController screenshotController = ScreenshotController();

  _takePic() async {
    final img = await screenshotController.capture();
    if (img == null) return;
    createPdf(img);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text("Title"),
        actions: [
          IconButton(
            onPressed: _takePic,
            icon: const Icon(
              Icons.picture_as_pdf,
            ),
          ),
        ],
      ),
      body: Screenshot(
        controller: screenshotController,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Container(
                height: context.height - 120,
                width: context.width,
                decoration: BoxDecoration(
                    border: Border.all(
                  width: 5,
                  color: Colors.red,
                )),
                child: const Center(
                  child: Text(
                    "PDF File",
                    style: TextStyle(
                      fontSize: 60,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
