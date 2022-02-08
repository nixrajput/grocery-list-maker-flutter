import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grocery_list_maker/models/grocery_item.dart';
import 'package:grocery_list_maker/models/pdf_data.dart';
import 'package:grocery_list_maker/pdf_helper/grocery_list.dart';
import 'package:grocery_list_maker/pdf_helper/pdf_builder.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class PdfPreviewPage extends StatefulWidget {
  final List<GroceryItem?>? data;
  final String? name;
  final String? address;
  final String? title;

  const PdfPreviewPage({
    Key? key,
    required this.data,
    this.name,
    this.address,
    this.title,
  }) : super(key: key);

  @override
  _PdfPreviewPageState createState() => _PdfPreviewPageState();
}

class _PdfPreviewPageState extends State<PdfPreviewPage> {
  PrintingInfo? printingInfo;

  void _showPrintedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document printed successfully'),
      ),
    );
  }

  void _showSharedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document shared successfully'),
      ),
    );
  }

  Future<void> _saveAsFile(
    BuildContext context,
    LayoutCallback build,
    PdfPageFormat pageFormat,
  ) async {
    final bytes = await build(pageFormat);

    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;
    final file = File(appDocPath + '/' + 'list.pdf');
    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
  }

  Future<void> _init() async {
    final info = await Printing.info();

    setState(() {
      printingInfo = info;
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    final actions = <PdfPreviewAction>[
      if (!kIsWeb)
        PdfPreviewAction(
          icon: const Icon(Icons.save),
          onPressed: _saveAsFile,
        ),
    ];

    return Scaffold(
      body: SafeArea(
        child: PdfPreview(
          canDebug: false,
          maxPageWidth: deviceSize.width,
          actions: actions,
          shouldRepaint: true,
          pdfFileName: 'list.pdf',
          loadingWidget: const CircularProgressIndicator(),
          initialPageFormat: PdfPageFormat.a4,
          pageFormats: const {
            "A4": PdfPageFormat.a4,
            "Letter": PdfPageFormat.letter,
            "A3": PdfPageFormat.a3
          },
          build: (format) => const PdfLayout(
            'List',
            'grocery_list.dart',
            generateGroceryList,
          ).builder(
            format,
            PdfData(
              name: widget.name,
              address: widget.address,
              items: widget.data,
              title: widget.title,
            ),
          ),
          onPrinted: _showPrintedToast,
          onShared: _showSharedToast,
        ),
      ),
    );
  }
}
