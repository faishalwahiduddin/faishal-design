import 'package:flutter/material.dart';
import 'section_header.dart';
import 'islamic_divider.dart';

/// Item data for the content sidebar.
class SidebarItem {
  final String id;
  final String title;
  final String section;
  final bool completed;

  const SidebarItem({
    required this.id,
    required this.title,
    required this.section,
    this.completed = false,
  });
}

/// Sticky numbered sidebar for desktop reading views.
/// Shows items grouped by section with active highlighting
/// and completion checkmarks.
class ContentSidebar extends StatelessWidget {
  final List<SidebarItem> items;
  final String? activeId;
  final ValueChanged<String>? onItemTap;
  final double width;

  const ContentSidebar({
    super.key,
    required this.items,
    this.activeId,
    this.onItemTap,
    this.width = 256,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Group items by section
    final sections = <String, List<MapEntry<int, SidebarItem>>>{};
    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      sections.putIfAbsent(item.section, () => []);
      sections[item.section]!.add(MapEntry(i, item));
    }

    return SizedBox(
      width: width,
      child: ListView(
        padding: const EdgeInsets.only(bottom: 16),
        children: [
          for (final entry in sections.entries) ...[
            SectionHeader(title: entry.key),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  for (var j = 0; j < entry.value.length; j++) ...[
                    if (j > 0) const IslamicDivider(),
                    _SidebarItemTile(
                      index: entry.value[j].key + 1,
                      item: entry.value[j].value,
                      isActive: entry.value[j].value.id == activeId,
                      onTap: () => onItemTap?.call(entry.value[j].value.id),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SidebarItemTile extends StatelessWidget {
  final int index;
  final SidebarItem item;
  final bool isActive;
  final VoidCallback? onTap;

  const _SidebarItemTile({
    required this.index,
    required this.item,
    required this.isActive,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        constraints: const BoxConstraints(minHeight: 44),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: isActive
            ? primaryColor.withValues(alpha: 0.08)
            : Colors.transparent,
        child: Row(
          children: [
            SizedBox(
              width: 20,
              child: Text(
                '$index',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 13,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                item.title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
                  color:
                      isActive ? primaryColor : theme.colorScheme.onSurface,
                ),
              ),
            ),
            if (item.completed)
              Icon(Icons.check, size: 16, color: primaryColor),
          ],
        ),
      ),
    );
  }
}
