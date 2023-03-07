enum NavItem { start, workshop, chat, docs }

extension NavItemExtension on NavItem {
  String get displayName => displayNames[this] ?? 'Undefined';
  String get route => routes[this] ?? '/';

  static const displayNames = {
    NavItem.start: 'Start',
    NavItem.workshop: 'Workshop',
    NavItem.chat: 'Chat',
    NavItem.docs: 'Docs'
  };

  static const routes = {
    NavItem.start: '/',
    NavItem.workshop: '/workshop',
    NavItem.chat: '/chat',
    NavItem.docs: '/docs'
  };
}
