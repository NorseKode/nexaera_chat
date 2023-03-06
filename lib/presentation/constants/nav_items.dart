enum NavItem { start, workshop, docs }

extension NavItemExtension on NavItem {
  String get displayName => displayNames[this] ?? 'Undefined';

  static const displayNames = {
    NavItem.start: 'Start',
    NavItem.workshop: 'Workshop',
    NavItem.docs: 'Docs',
  };
}
