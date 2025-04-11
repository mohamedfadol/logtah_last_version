import 'package:diligov/utility/pdf_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
class CustomPdfView extends StatefulWidget {
  final String path;
  const CustomPdfView({super.key, required this.path});

  @override
  State<CustomPdfView> createState() => _CustomPdfViewState();
}

class _CustomPdfViewState extends State<CustomPdfView> {
  String localPath = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    preparePdfFileFromNetwork();
  }

  @override
  void dispose() {
    // Set to landscapeLeft when leaving to ensure PerformanceRewardListView is correct
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    super.dispose();
  }

  Future<void> preparePdfFileFromNetwork() async {
    try {
      if(await PDFApi.requestPermission()){
        final filePath = await PDFApi.loadNetwork(widget.path!);
        setState(() { localPath = filePath.path!;});
        print("localPath PDF: ${localPath}");
        print("widget path PDF: ${widget.path}");
      } else {
        print("Lacking permissions to access the file in preparePdfFileFromNetwork function");
        return;
      }
    } catch (e) { print("Error preparePdfFileFromNetwork function PDF: $e"); }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: localPath.isNotEmpty
      ? PDFView(
        fitEachPage: true,
        filePath: localPath,
        autoSpacing: true,
        enableSwipe: true,
        pageSnap: true,
        swipeHorizontal: true,
        nightMode: false,
        onPageChanged: (int? currentPage, int? totalPages) {
          print("Current page: $currentPage!, Total pages: $totalPages!");
          // You can use this callback to keep track of the current page.
        },
      ) : const Center(child: CircularProgressIndicator()) ,
    );
  }
}
