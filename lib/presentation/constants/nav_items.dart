enum NavItem { start, chat, docs, account }

extension NavItemExtension on NavItem {
  String get displayName => displayNames[this] ?? 'Undefined';
  String get route => routes[this] ?? '/';

  static const displayNames = {
    NavItem.start: 'Start',
    //NavItem.workshop: 'Workshop',
    NavItem.chat: 'Chat',
    NavItem.docs: 'Docs',
    NavItem.account: 'Account'
  };

  static const routes = {
    NavItem.start: '/',
    // NavItem.workshop: '/workshop',
    NavItem.chat: '/chat',
    NavItem.docs: '/docs',
    NavItem.account: '/account'
  };
}
