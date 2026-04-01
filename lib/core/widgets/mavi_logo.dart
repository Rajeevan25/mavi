import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MaviLogo extends StatelessWidget {
  final double size;
  final bool showText;
  final Color? color;

  const MaviLogo({
    super.key,
    this.size = 100,
    this.showText = true,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? AppColors.navyDeep;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size * 0.7,
          child: CustomPaint(
            painter: EagleLogoPainter(color: effectiveColor),
          ),
        ),
        if (showText) ...[
          SizedBox(height: size * 0.05),
          Text(
            'MAVI',
            style: TextStyle(
              color: effectiveColor,
              fontSize: size * 0.25,
              fontWeight: FontWeight.w900,
              letterSpacing: 4.0,
              fontFamily: 'Outfit',
              height: 1.0,
            ),
          ),
          Text(
            'SECURITY',
            style: TextStyle(
              color: effectiveColor,
              fontSize: size * 0.1,
              fontWeight: FontWeight.bold,
              letterSpacing: 6.0,
              height: 1.0,
            ),
          ),
          // Stylized underline/v-shape from mockup
          Container(
            margin: EdgeInsets.only(top: size * 0.05),
            width: size * 0.3,
            height: 2,
            decoration: BoxDecoration(
              color: effectiveColor,
              borderRadius: BorderRadius.circular(1),
            ),
            child: Stack(
               alignment: Alignment.center,
               children: [
                  Transform.translate(
                    offset: Offset(0, size * 0.05),
                    child: CustomPaint(
                      size: Size(size * 0.15, size * 0.05),
                      painter: BottomVPainter(color: effectiveColor),
                    ),
                  )
               ],
            ),
          ),
        ],
      ],
    );
  }
}

class EagleLogoPainter extends CustomPainter {
  final Color color;

  EagleLogoPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final double w = size.width;
    final double h = size.height;

    // Draw central head/crest
    final headPath = Path();
    headPath.moveTo(w * 0.5, h * 0.1);
    headPath.quadraticBezierTo(w * 0.6, h * 0.1, w * 0.65, h * 0.3);
    headPath.lineTo(w * 0.62, h * 0.35);
    headPath.lineTo(w * 0.58, h * 0.32);
    headPath.quadraticBezierTo(w * 0.55, h * 0.5, w * 0.5, h * 0.55);
    headPath.quadraticBezierTo(w * 0.45, h * 0.5, w * 0.42, h * 0.32);
    headPath.lineTo(w * 0.38, h * 0.35);
    headPath.lineTo(w * 0.35, h * 0.3);
    headPath.quadraticBezierTo(w * 0.4, h * 0.1, w * 0.5, h * 0.1);
    canvas.drawPath(headPath, paint);

    // Draw wings (symmetric)
    _drawWing(canvas, paint, w * 0.5, h * 0.45, w * 0.4, h * 0.4, true);
    _drawWing(canvas, paint, w * 0.5, h * 0.45, w * 0.4, h * 0.4, false);
  }

  void _drawWing(Canvas canvas, Paint paint, double centerX, double centerY, double wingWidth, double wingHeight, bool isLeft) {
    final double direction = isLeft ? -1 : 1;
    
    // Wing levels (mockup has multiple feathers/segments)
    for (int i = 0; i < 4; i++) {
      final double offset = i * wingHeight * 0.15;
      final double scale = 1.0 - (i * 0.1);
      
      final wingPath = Path();
      wingPath.moveTo(centerX, centerY + offset);
      wingPath.quadraticBezierTo(
        centerX + wingWidth * 0.8 * direction, centerY - wingHeight * 0.1 + offset,
        centerX + wingWidth * direction * scale, centerY - wingHeight * 0.6 + offset
      );
      wingPath.quadraticBezierTo(
        centerX + wingWidth * 0.7 * direction, centerY - wingHeight * 0.4 + offset,
        centerX + wingWidth * 0.1 * direction, centerY + offset * 1.2
      );
      wingPath.close();
      canvas.drawPath(wingPath, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BottomVPainter extends CustomPainter {
  final Color color;

  BottomVPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.5, size.height);
    path.lineTo(size.width, 0);
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
