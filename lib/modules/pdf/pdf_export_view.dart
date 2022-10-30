import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_list_maker/global_widgets/unfocus_widget.dart';
import 'package:grocery_list_maker/models/grocery_item.dart';
import 'package:grocery_list_maker/models/pdf_data.dart';
import 'package:grocery_list_maker/modules/pdf/pdf_helper/grocery_list_pdf_layout.dart';
import 'package:grocery_list_maker/modules/pdf/pdf_helper/pdf_layout.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class PdfExportView extends StatefulWidget {
  final List<GroceryItem>? data;
  final String? name;
  final String? address;
  final String? title;

  const PdfExportView({
    Key? key,
    required this.data,
    this.name,
    this.address,
    this.title,
  }) : super(key: key);

  @override
  PdfExportViewState createState() => PdfExportViewState();
}

class PdfExportViewState extends State<PdfExportView> {
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
    final file = File('$appDocPath/grocery_list_pdf.pdf');
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

    return UnFocusWidget(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAppBar(context),
              Expanded(
                child: PdfPreview(
                  canDebug: false,
                  maxPageWidth: deviceSize.width,
                  actions: actions,
                  shouldRepaint: true,
                  pdfFileName: 'grocery_list_pdf.pdf',
                  loadingWidget: const Center(
                    child: SizedBox(
                      width: 24.0,
                      height: 24.0,
                      child: CircularProgressIndicator(
                        color: Colors.redAccent,
                        strokeWidth: 2.0,
                      ),
                    ),
                  ),
                  initialPageFormat: PdfPageFormat.a4,
                  pageFormats: const {
                    "A4": PdfPageFormat.a4,
                    "Letter": PdfPageFormat.letter,
                    "A3": PdfPageFormat.a3
                  },
                  build: (format) => const PdfLayout(
                    'List',
                    'grocery_list_pdf_layout.dart',
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
            ],
          ),
        ),
      ),
    );
  }

  Container _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 12.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              size: 24.0,
            ),
          ),
          const SizedBox(width: 12.0),
          Text(
            widget.title ?? 'Grocery List',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
