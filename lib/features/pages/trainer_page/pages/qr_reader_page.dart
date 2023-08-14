import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/components/adaptive_activity_indicator.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/trainer_page_wm.dart';

///
class QrReaderPage extends StatefulWidget {
  final ITrainerPageWidgetModel wm;

  ///
  const QrReaderPage({required this.wm, Key? key}) : super(key: key);

  @override
  _QrReaderPageState createState() => _QrReaderPageState();
}

class _QrReaderPageState extends State<QrReaderPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final _animationStatus = false;
  QRViewController? _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _controller?.pauseCamera();
    } else if (Platform.isIOS) {
      _controller?.resumeCamera();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: AppColors().accentGreen,
                  borderRadius: 10,
                  borderWidth: 5,
                ),
              ),
            ),
            if (_animationStatus)
              Positioned.fill(
                child: ColoredBox(
                  color: AppColors().primaryText.withOpacity(0.7),
                  child: const Center(
                    child: AdaptiveActivityIndicator(),
                  ),
                ),
              ),
            Positioned(
              top: 0 + MediaQuery.of(context).padding.top,
              left: 10,
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Positioned(
              top: 100 + MediaQuery.of(context).padding.top + 48,
              right: 10,
              left: 10,
              child: Text(
                'Выровняйте QR код в центре экрана',
                style: AppTextStyles().medium_20_27,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
    });
    controller.scannedDataStream.listen(_sendCode);
  }

  Future<void> _sendCode(Barcode code) async {
    await _controller?.pauseCamera();
    final qrCode = code.code;
    await widget.wm.sendCode(qrCode ?? '');
  }
}
