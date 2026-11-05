import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/tokens.dart';
import '../../l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        actions: [
          IconButton(icon: const Icon(Icons.shopping_cart_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              const Positioned(top: 0, left: 0, right: 0, height: 210, child: _SwatchCollage()),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(AppSpace.m, 160, AppSpace.m, 0),
                child: _FindYourColourCard(l: l),
              ),
              PositionedDirectional(
                top: AppSpace.m,
                start: AppSpace.m,
                child: Container(
                  width: 56,
                  height: 56,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: AppColors.navy, borderRadius: BorderRadius.circular(10)),
                  child: Text(l.appName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpace.m),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpace.m),
            child: FilledButton.icon(
              onPressed: () => context.push('/visualize'),
              icon: const Icon(Icons.auto_awesome, size: 20),
              label: Text(l.visualizeNow),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpace.m, AppSpace.l, AppSpace.m, AppSpace.s),
            child: Text(l.myProjectsCount(2), style: text.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpace.m),
            child: Row(
              children: [
                Expanded(child: _AddProjectCard(label: l.addProject)),
                const SizedBox(width: AppSpace.m),
                Expanded(child: _ProjectCard(label: l.manageProjects)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpace.m, AppSpace.l, AppSpace.m, AppSpace.s),
            child: Row(
              children: [
                Expanded(child: Text(l.recentlyViewed, style: text.titleMedium?.copyWith(fontWeight: FontWeight.w600))),
                Text(l.viewAll, style: text.bodySmall?.copyWith(color: AppColors.navy)),
              ],
            ),
          ),
          SizedBox(
            height: 160,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpace.m),
              itemCount: _recent.length,
              separatorBuilder: (_, __) => const SizedBox(width: AppSpace.m),
              itemBuilder: (_, i) => _RecentTile(color: _recent[i].$1, name: _recent[i].$2),
            ),
          ),
          const SizedBox(height: AppSpace.xl + 16),
        ],
      ).animate().fadeIn(duration: 300.ms),
    );
  }
}

const _recent = [
  (Color(0xFFB5502B), 'Desert Clay'),
  (Color(0xFF8DA38B), 'Sage Mist'),
  (Color(0xFFD9B99B), 'Warm Sand'),
  (Color(0xFF2F4F7F), 'Nile Blue'),
];

class _FindYourColourCard extends StatelessWidget {
  const _FindYourColourCard({required this.l});
  final AppLocalizations l;

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.colorize, l.colourPicker, '/picker'),
      (Icons.qr_code_scanner, l.colourFinder, '/finder'),
      (Icons.palette_outlined, l.colourWall, '/wall'),
    ];
    return Container(
      padding: const EdgeInsets.all(AppSpace.m),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l.findYourColour, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: AppSpace.m),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (final it in items)
                InkWell(
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  onTap: () => context.push(it.$3),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      children: [
                        Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.navy, width: 1.5)),
                          child: Icon(it.$1, color: AppColors.navy),
                        ),
                        const SizedBox(height: 6),
                        Text(it.$2, style: const TextStyle(color: AppColors.navy, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AddProjectCard extends StatelessWidget {
  const _AddProjectCard({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) => Container(
        height: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_circle_outline, color: AppColors.navy, size: 28),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(color: AppColors.navy, fontSize: 16)),
          ],
        ),
      );
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) => Container(
        height: 140,
        decoration: BoxDecoration(
          color: const Color(0xFF3E6FA8),
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.all(AppSpace.s),
        child: Container(
          height: 34,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: AppColors.navy, borderRadius: BorderRadius.circular(4)),
          child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 13)),
        ),
      );
}

class _RecentTile extends StatelessWidget {
  const _RecentTile({required this.color, required this.name});
  final Color color;
  final String name;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 110,
        child: Column(
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: AppShadows.soft),
            ),
            const SizedBox(height: 8),
            Text(name, style: const TextStyle(fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      );
}

/// Placeholder hero: paint-chip collage. Replace with a real photo asset later.
class _SwatchCollage extends StatelessWidget {
  const _SwatchCollage();

  @override
  Widget build(BuildContext context) => CustomPaint(painter: _CollagePainter());
}

class _CollagePainter extends CustomPainter {
  static const _palette = [
    Color(0xFFD9C7B0), Color(0xFFE6B8B0), Color(0xFFB5502B), Color(0xFFF2A33A),
    Color(0xFF2F7F86), Color(0xFF8DA38B), Color(0xFF2F4F7F), Color(0xFFE9E2D3),
    Color(0xFFC9A66B), Color(0xFF9E8AA8), Color(0xFF1F3A5F), Color(0xFFF1D98A),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final rnd = Random(7);
    canvas.drawRect(Offset.zero & size, Paint()..color = const Color(0xFFEDEAE4));
    const cols = 9, rows = 5;
    final w = size.width / cols, h = size.height / rows;
    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < cols; c++) {
        final p = Paint()..color = _palette[rnd.nextInt(_palette.length)];
        canvas.save();
        canvas.translate(c * w + w / 2, r * h + h / 2);
        canvas.rotate((rnd.nextDouble() - .5) * .08);
        canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: w * .95, height: h * .95), p);
        canvas.restore();
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
