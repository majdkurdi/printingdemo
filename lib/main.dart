import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: const Text('Print'),
              onPressed: () async {
                final doc = pw.Document();
                doc.addPage(pw.Page(
                    pageFormat: PdfPageFormat.a4,
                    build: (pw.Context context) {
                      return pw.Center(
                        child: pw.Text('Hello World'),
                      );
                    }));
                await Printing.layoutPdf(
                    onLayout: (PdfPageFormat format) async => doc.save());
              },
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: const Text('Share'),
                onPressed: () async {
                  final doc = pw.Document();
                  doc.addPage(pw.Page(
                      pageFormat: PdfPageFormat.a4,
                      build: (pw.Context context) {
                        return pw.Center(
                          child: pw.Text('Hello World'),
                        );
                      }));
                  await Printing.sharePdf(
                      bytes: await doc.save(), filename: 'my-document.pdf');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
