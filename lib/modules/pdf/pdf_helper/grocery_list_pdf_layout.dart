import 'package:flutter/services.dart';
import 'package:grocery_list_maker/models/grocery_item.dart';
import 'package:grocery_list_maker/models/pdf_data.dart';
import 'package:grocery_list_maker/utils/utility.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<Uint8List> generateGroceryList(
  PdfPageFormat pageFormat,
  PdfData data,
) async {
  final groceryList = GroceryListPdfLayout(
    title: data.title ?? '',
    customerName: data.name ?? '',
    customerAddress: data.address ?? '',
    items: data.items,
    baseColor: PdfColors.redAccent,
    accentColor: PdfColors.blueGrey700,
  );

  return await groceryList.buildPdf(pageFormat);
}

class GroceryListPdfLayout {
  final String customerName;
  final String customerAddress;
  final String title;
  final List<GroceryItem>? items;

  final PdfColor baseColor;
  final PdfColor accentColor;

  static const _darkColor = PdfColors.blueGrey800;
  static const _lightColor = PdfColors.white;

  GroceryListPdfLayout({
    required this.title,
    required this.customerName,
    required this.baseColor,
    required this.accentColor,
    required this.customerAddress,
    required this.items,
  });

  PdfColor get _baseTextColor => baseColor.isLight ? _lightColor : _darkColor;

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat) async {
    final doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
          pageTheme: _buildPageTheme(
            pageFormat,
            await PdfGoogleFonts.notoSansRegular(),
            await PdfGoogleFonts.notoSansBold(),
            await PdfGoogleFonts.notoSansItalic(),
          ),
          header: _buildHeader,
          footer: _buildFooter,
          build: (context) => [
                _contentTable(context),
                pw.SizedBox(height: 20.0),
              ]),
    );

    return doc.save();
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Center(
      child: pw.Text(
        'Page ${context.pageNumber} of ${context.pagesCount}',
        style: pw.TextStyle(
          fontSize: 14.0,
          fontWeight: pw.FontWeight.normal,
        ),
      ),
    );
  }

  pw.PageTheme _buildPageTheme(
    PdfPageFormat pageFormat,
    pw.Font base,
    pw.Font bold,
    pw.Font italic,
  ) {
    return pw.PageTheme(
      pageFormat: pageFormat,
      theme: pw.ThemeData.withFont(
        base: base,
        bold: bold,
        italic: italic,
      ),
      orientation: pw.PageOrientation.natural,
      margin: const pw.EdgeInsets.fromLTRB(
        32.0,
        48.0,
        32.0,
        40.0,
      ),
    );
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Column(
      children: [
        pw.Container(
          alignment: pw.Alignment.center,
          child: pw.RichText(
            text: pw.TextSpan(
              text: title,
              style: pw.TextStyle(
                color: baseColor,
                fontWeight: pw.FontWeight.bold,
                fontSize: 32.0,
                decoration: pw.TextDecoration.underline,
              ),
            ),
          ),
        ),
        pw.SizedBox(height: 16.0),
        pw.Container(
          alignment: pw.Alignment.centerLeft,
          child: pw.RichText(
            text: pw.TextSpan(
              text: customerName,
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
        pw.Container(
          alignment: pw.Alignment.centerLeft,
          child: pw.RichText(
            text: pw.TextSpan(
              text: customerAddress,
              style: const pw.TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ),
        pw.Container(
          alignment: pw.Alignment.centerRight,
          child: pw.Text(
            DateTime.now().formatDate(),
            style: const pw.TextStyle(
              fontSize: 20.0,
            ),
          ),
        ),
        pw.SizedBox(height: 16.0),
      ],
    );
  }

  pw.Widget _contentTable(pw.Context context) {
    const tableHeaders = [
      'S. No.',
      'Item',
      'Quantity',
    ];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        color: baseColor,
      ),
      headerHeight: 32.0,
      cellHeight: 40.0,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerRight,
      },
      columnWidths: {
        0: const pw.FixedColumnWidth(40.0),
        1: const pw.IntrinsicColumnWidth(),
        2: const pw.IntrinsicColumnWidth(),
      },
      headerStyle: pw.TextStyle(
        color: _baseTextColor,
        fontSize: 16.0,
        fontWeight: pw.FontWeight.bold,
      ),
      headerPadding: const pw.EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 8.0,
      ),
      cellStyle: const pw.TextStyle(
        color: _darkColor,
        fontSize: 14.0,
      ),
      cellPadding: const pw.EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: accentColor,
            width: .5,
          ),
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        items!.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => items![row].getRowDescription(col, row),
        ),
      ),
    );
  }
}
