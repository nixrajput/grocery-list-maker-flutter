import 'dart:typed_data';

import 'package:grocery_list_maker/models/pdf_data.dart';
import 'package:pdf/pdf.dart';

typedef LayoutCallbackWithData = Future<Uint8List> Function(
    PdfPageFormat pageFormat, PdfData data);

class PdfLayout {
  const PdfLayout(this.name, this.file, this.builder, [this.needsData = false]);

  final String name;

  final String file;

  final LayoutCallbackWithData builder;

  final bool needsData;
}
