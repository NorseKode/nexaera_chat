enum NavItem { start, chat, docs, lab, account }

extension NavItemExtension on NavItem {
  String get displayName => displayNames[this] ?? 'Undefined';
  String get route => routes[this] ?? '/';

  static const displayNames = {
    NavItem.start: 'Start',
    //NavItem.workshop: 'Workshop',
    NavItem.chat: 'Chat',
    NavItem.docs: 'Docs',
    NavItem.lab: 'Lab',
    NavItem.account: 'Account'
  };

  static const routes = {
    NavItem.start: '/',
    // NavItem.workshop: '/workshop',
    NavItem.lab: '/lab',
    NavItem.chat: '/chat',
    NavItem.docs: '/docs',
    NavItem.account: '/account'
  };
}
