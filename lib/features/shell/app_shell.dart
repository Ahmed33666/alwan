import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/tokens.dart';
import '../../l10n/app_localizations.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child, required this.location});
  final Widget child;
  final String location;

  static const _tabs = ['/home', '/colours', '/visualize', '/products', '/projects'];

  int get _index {
    final i = _tabs.indexWhere((t) => location.startsWith(t));
    return i < 0 ? 0 : i;
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final items = [
      (Icons.home_outlined, l.navHome),
      (Icons.palette_outlined, l.navColours),
      (Icons.visibility_outlined, l.navVisualize),
      (Icons.inventory_2_outlined, l.navProducts),
      (Icons.create_new_folder_outlined, l.navProjects),
    ];

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 64,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Row(
                  children: [
                    for (var i = 0; i < items.length; i++)
                      Expanded(
                        child: i == 2
                            ? _CenterLabel(label: items[i].$2, onTap: () => context.push('/visualize'))
                            : _NavItem(
                                icon: items[i].$1,
                                label: items[i].$2,
                                selected: _index == i,
                                onTap: () => context.go(_tabs[i]),
                              ),
                      ),
                  ],
                ),
                PositionedDirectional(
                  top: -22,
                  start: 0,
                  end: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: () => context.push('/visualize'),
                      child: Container(
                        width: 62,
                        height: 62,
                        decoration: BoxDecoration(
                          color: AppColors.teal,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: AppShadows.soft,
                        ),
                        child: const Icon(Icons.auto_awesome, color: Colors.white, size: 28),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({required this.icon, required this.label, required this.selected, required this.onTap});
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 2,
            width: selected ? 36 : 0,
            color: AppColors.navy,
          ),
          const Spacer(),
          Icon(icon, color: AppColors.navy, size: 24),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(color: AppColors.navy, fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}

class _CenterLabel extends StatelessWidget {
  const _CenterLabel({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(label, style: const TextStyle(color: AppColors.navy, fontSize: 12)),
        ),
      ),
    );
  }
}
