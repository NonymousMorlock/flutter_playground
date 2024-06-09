// import 'package:flutter/material.dart';
//
// //Copy this CustomPainter code to the Bottom of the File
// class RPSCustomPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final path_0 = Path();
//     path_0.moveTo(size.width * 0.9683852, size.height * 0.7503653);
//     path_0.lineTo(size.width * 0.04815481, size.height * 0.9865277);
//     path_0.lineTo(size.width * 0.04246111, size.height * 0.4896376);
//     path_0.lineTo(size.width * 0.03703704, size.height * 0.01630149);
//     path_0.lineTo(size.width * 0.04246111, size.height * 0.01775139);
//     path_0.lineTo(size.width * 0.5000000, size.height * 0.1400634);
//     path_0.lineTo(size.width * 0.9629630, size.height * 0.2638257);
//     path_0.lineTo(size.width * 0.9683852, size.height * 0.5004762);
//     path_0.lineTo(size.width * 0.9740815, size.height * 0.7489040);
//     path_0.lineTo(size.width * 0.9683852, size.height * 0.7503653);
//     path_0.close();
//
//     final paint0Fill = Paint()..style = PaintingStyle.fill;
//     paint0Fill.color = const Color(0xff656565).withOpacity(1);
//     canvas.drawPath(path_0, paint0Fill);
//
//     final var path_1 = Path();
//     path_1.moveTo(size.width * 0.04246111, size.height * 0.009900990);
//     path_1.lineTo(size.width * 0.04246111, size.height);
//     path_1.moveTo(size.width * 0.9683852, size.height * 0.2574257);
//     path_1.lineTo(size.width * 0.9683852, size.height * 0.7524752);
//     path_1.moveTo(size.width * 0.03703704, size.height * 0.01630149);
//     path_1.lineTo(size.width * 0.5000000, size.height * 0.1400634);
//     path_1.lineTo(size.width * 0.9629630, size.height * 0.2638257);
//     path_1.lineTo(size.width * 0.9740815, size.height * 0.7489040);
//     path_1.lineTo(size.width * 0.04815481, size.height * 0.9865277);
//     path_1.lineTo(size.width * 0.03703704, size.height * 0.01630149);
//     path_1.close();
//
//     final paint1Stroke = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2;
//     paint1Stroke.color = Colors.white.withOpacity(1);
//     canvas.drawPath(path_1, paint1Stroke);
//
//     final paint1Fill = Paint()..style = PaintingStyle.fill;
//     paint1Fill.color = const Color(0xff656565).withOpacity(1);
//     canvas.drawPath(path_1, paint1Fill);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
//
// //Copy this CustomPainter code to the Bottom of the File
// class RPSCustomPainter2 extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint0Stroke = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2;
//     paint0Stroke.color = Colors.white.withOpacity(1);
//     canvas.drawRect(
//         Rect.fromLTWH(size.width * 0.001428571, size.height * 0.005000000,
//             size.width * 0.9971429, size.height * 0.9900000,),
//         paint0Stroke,);
//
//     final var paint0Fill = Paint()..style = PaintingStyle.fill;
//     paint0Fill.color = const Color(0xff000000).withOpacity(1);
//     canvas.drawRect(
//         Rect.fromLTWH(size.width * 0.001428571, size.height * 0.005000000,
//             size.width * 0.9971429, size.height * 0.9900000,),
//         paint0Fill,);
//
//     final var paint1Stroke = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2;
//     paint1Stroke.color = Colors.white.withOpacity(1);
//     canvas.drawRect(
//         Rect.fromLTWH(size.width * 0.07285714, size.height * 0.2550000,
//             size.width * 0.8542857, size.height * 0.4900000,),
//         paint1Stroke,);
//
//     final paint1Fill = Paint()..style = PaintingStyle.fill;
//     paint1Fill.color = const Color(0xff000000).withOpacity(1);
//     canvas.drawRect(
//         Rect.fromLTWH(size.width * 0.07285714, size.height * 0.2550000,
//             size.width * 0.8542857, size.height * 0.4900000,),
//         paint1Fill,);
//
//     final paint2Stroke = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2;
//     paint2Stroke.color = Colors.black.withOpacity(1);
//     canvas.drawLine(Offset(size.width * 0.001010151, size.height * 0.006464470),
//         Offset(size.width * 0.07243886, size.height * 0.2564640), paint2Stroke,);
//
//     final paint3Stroke = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2;
//     paint3Stroke.color = Colors.white.withOpacity(1);
//     canvas.drawLine(Offset(size.width * 0.001867811, size.height * 0.9863930),
//         Offset(size.width * 0.07329629, size.height * 0.7463930), paint3Stroke,);
//
//     final paint4Stroke = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2;
//     paint4Stroke.color = Colors.white.withOpacity(1);
//     canvas.drawLine(Offset(size.width * 0.9961114, size.height * 0.9934630),
//         Offset(size.width * 0.9275400, size.height * 0.7434630), paint4Stroke,);
//
//     final paint5Stroke = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2;
//     paint5Stroke.color = Colors.white.withOpacity(1);
//     canvas.drawLine(Offset(size.width * 0.9981314, size.height * 0.01360690),
//         Offset(size.width * 0.9267029, size.height * 0.2536070), paint5Stroke,);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
