import 'package:flutter/material.dart';
import 'package:mavi_security/core/theme/app_colors.dart';

class SignaturePad extends StatefulWidget {
  final String label;
  final VoidCallback? onSigned;

  const SignaturePad({
    super.key,
    this.label = 'UNTERSCHRIFT DES KUNDEN',
    this.onSigned,
  });

  @override
  State<SignaturePad> createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  final List<Offset?> _points = [];
  bool _hasSignature = false;

  void _addPoint(Offset? point) {
    setState(() {
      _points.add(point);
      if (point != null && !_hasSignature) {
        _hasSignature = true;
        widget.onSigned?.call();
      }
    });
  }

  void _clear() {
    setState(() {
      _points.clear();
      _hasSignature = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.label,
              style: TextStyle(
                color: AppColors.navyLight.withOpacity(0.6),
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
              ),
            ),
            if (_hasSignature)
              TextButton(
                onPressed: _clear,
                style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
                child: const Text('LÖSCHEN', style: TextStyle(fontSize: 10, color: AppColors.error)),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.outlineVariant.withOpacity(0.5)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: GestureDetector(
              onPanUpdate: (details) => _addPoint(details.localPosition),
              onPanEnd: (details) => _addPoint(null),
              child: CustomPaint(
                painter: _SignaturePainter(_points),
                size: Size.infinite,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        if (!_hasSignature)
          Center(
            child: Text(
              'Hier unterschreiben',
              style: TextStyle(
                color: AppColors.navyLight.withOpacity(0.4),
                fontSize: 11,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    );
  }
}

class _SignaturePainter extends CustomPainter {
  final List<Offset?> points;

  _SignaturePainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.navyDeep
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
