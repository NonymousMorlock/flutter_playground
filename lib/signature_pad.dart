// coverage:ignore-file
import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:discord_test/image_converter.dart';
import 'package:discord_test/signature_provider.dart';
///Package import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
///Signature pad imports.
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

///Renders the signature pad widget.
class SignaturePad extends StatefulWidget {
  /// Creates a Signature Pad.
  const SignaturePad({super.key});

  @override
  State<SignaturePad> createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  final GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();

  List<Color> _strokeColors = <Color>[];
  int _selectedPenIndex = 0;
  Color? backgroundColor;

  late Color _strokeColor;
  late Uint8List _signatureData;
  final double _fontSizeRegular = 12;
  late List<Widget> _strokeColorWidgets;

  @override
  void initState() {
    _addColors();
    super.initState();
  }

  @override
  void dispose() {
    _strokeColors.clear();
    super.dispose();
  }

  void _addColors() {
    _strokeColors = <Color>[];
    _strokeColors
      ..add(const Color.fromRGBO(0, 0, 0, 1))
      ..add(const Color.fromRGBO(35, 93, 217, 1))
      ..add(const Color.fromRGBO(77, 180, 36, 1))
      ..add(const Color.fromRGBO(228, 77, 49, 1));
  }

  List<Widget> _addStrokeColorPalettes(StateSetter stateChanged) {
    _strokeColorWidgets = <Widget>[];
    for (var i = 0; i < _strokeColors.length; i++) {
      _strokeColorWidgets.add(
        Material(
          color: Colors.transparent,
          child: Ink(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: InkWell(
              onTap: () => stateChanged(
                () {
                  _strokeColor = _strokeColors[i];
                  _selectedPenIndex = i;
                },
              ),
              child: Center(
                child: Stack(
                  children: <Widget>[
                    Icon(Icons.brightness_1, size: 25, color: _strokeColors[i]),
                    if (_selectedPenIndex == i)
                      const Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.check,
                          size: 15,
                          color: Colors.white,
                        ),
                      )
                    else
                      const SizedBox(width: 8),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return _strokeColorWidgets;
  }

  bool _handleOnDrawStart() {
    context.read<SignatureProvider>().setSignatureFilled();
    return false;
  }

  void _showPopup() {
    context.read<SignatureProvider>().setSignatureEmpty();
    showDialog<Widget>(
      context: context,
      builder: (BuildContext _) {
        return StatefulBuilder(
          builder: (__, setState) {
            const textColor = Colors.black87;

            return ChangeNotifierProvider.value(
              value: context.read<SignatureProvider>(),
              child: Builder(
                builder: (context) {
                  return AlertDialog(
                    insetPadding: const EdgeInsets.all(12),
                    backgroundColor: backgroundColor,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'Draw your signature',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto-Medium',
                          ),
                        ),
                        InkWell(
                          //ignore: sdk_version_set_literal
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(
                            Icons.clear,
                            color: Color.fromRGBO(0, 0, 0, 0.54),
                            size: 24,
                          ),
                        )
                      ],
                    ),
                    titlePadding: const EdgeInsets.all(16),
                    content: SingleChildScrollView(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width < 306
                            ? MediaQuery.of(context).size.width
                            : 306,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width < 306
                                  ? MediaQuery.of(context).size.width
                                  : 306,
                              height: 172,
                              decoration: BoxDecoration(
                                border: Border.all(color: _getBorderColor()!),
                              ),
                              child: SfSignaturePad(
                                minimumStrokeWidth: 1,
                                maximumStrokeWidth: 4,
                                strokeColor: _strokeColor,
                                backgroundColor: backgroundColor,
                                onDrawStart: _handleOnDrawStart,
                                key: _signaturePadKey,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const Text(
                                  'Pen Color',
                                  style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  width: 124,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: _addStrokeColorPalettes(setState),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    actionsPadding: const EdgeInsets.all(8),
                    buttonPadding: EdgeInsets.zero,
                    actions: <Widget>[
                      TextButton(
                        onPressed: _handleClearButtonPressed,
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF2F7EB6),
                          ),
                        ),
                        child: const Text(
                          'CLEAR',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (!context
                          .watch<SignatureProvider>()
                          .signatureIsEmpty) ...[
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: () {
                            _handleSaveButtonPressed();
                            Navigator.of(context).pop();
                          },
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF3EBF53),
                            ),
                          ),
                          child: const Text(
                            'SAVE',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ]
                    ],
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  void _handleClearButtonPressed() {
    _signaturePadKey.currentState!.clear();
    if (context.read<SignatureProvider>().signatureIsEmpty) {
      context.read<SignatureProvider>().setUnsigned();
    } else {
      context.read<SignatureProvider>().setSignatureEmpty();
    }
  }

  Future<void> _handleSaveButtonPressed() async {
    late Uint8List data;

    if (kIsWeb) {
      final renderSignaturePad = _signaturePadKey.currentState!.context
          .findRenderObject()! as RenderSignaturePad;
      data =
          await ImageConverter.toImage(renderSignaturePad: renderSignaturePad);
    } else {
      final imageData =
          await _signaturePadKey.currentState!.toImage(pixelRatio: 3);
      final bytes = await imageData.toByteData(format: ui.ImageByteFormat.png);
      if (bytes != null) {
        data = bytes.buffer.asUint8List();
      }
    }
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/signature.png');
    await file.writeAsBytes(data);
    if (!mounted) return;
    context.read<SignatureProvider>().setSigned(file.path);
    setState(
      () {
        _signatureData = data;
      },
    );
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Color? _getTextColor() => Colors.grey[700];

  Color? _getBorderColor() => Colors.grey[350];

  @override
  Widget build(BuildContext context) {
    _strokeColors[0] = const Color.fromRGBO(0, 0, 0, 1);
    _strokeColor = _strokeColors[_selectedPenIndex];
    const height = 70.73;
    const width = 222.11;
    const signedBottom = 9.0;
    const signedWidth = 146.64;
    const signedTop = 9.0;
    const signedLeft = 17.0;

    return Consumer<SignatureProvider>(
      builder: (_, provider, __) {
        return InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: _showPopup,
          child: Container(
            padding: !provider.isSigned
                ? null
                : const EdgeInsets.only(
                    top: signedTop,
                    left: signedLeft,
                    bottom: signedBottom,
                  ),
            height: !provider.isSigned ? height : null,
            width: !provider.isSigned ? width : signedWidth,
            decoration: BoxDecoration(
              color: provider.isSigned ? Colors.white : null,
              border: provider.isSigned
                  ? null
                  : Border.all(
                      color: _getBorderColor()!,
                    ),
              borderRadius:
                  provider.isSigned ? BorderRadius.circular(10) : null,
              boxShadow: !provider.isSigned
                  ? null
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(.05),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
            ),
            child: provider.isSigned
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'Signed',
                          style: TextStyle(
                            color: Color(0xFFB3B3B3),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Center(
                        child: Image.memory(
                          _signatureData,
                          height: height * .7,
                          width: width * .7,
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                      'Tap here to sign',
                      style: TextStyle(
                        fontSize: _fontSizeRegular,
                        fontWeight: FontWeight.bold,
                        color: _getTextColor(),
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
