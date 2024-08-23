import 'dart:io';
import 'dart:typed_data';

import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<void> createPdf(Uint8List imgData) async {
  final image = pw.MemoryImage(imgData);

  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.zero,
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Image(
            image,
            fit: pw.BoxFit.fill, // Now adjust fill according your requirement.
          ),
        );
      },
    ),
  );

  final dir = (await getApplicationDocumentsDirectory()).path;

  final file = File("$dir/example.pdf");
  await file.writeAsBytes(await pdf.save());
  OpenFilex.open(file.path);
}


/*

return pw.Container(
          height: pSize.height,
          width: pSize.width,
          decoration: pw.BoxDecoration(
            image: pw.DecorationImage(
              image: image,
            ),
          ),
        ); // Center
 */