import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nexaera_chat/presentation/constants/nav_items.dart';
import 'package:unicons/unicons.dart';

import '../../blocs/authentication/auth.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? actions;

  late ThemeData _theme;
  late AuthProvider _auth;

  CustomAppBar({super.key, this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    _auth = context.read<AuthProvider>();
    _theme = Theme.of(context);
    return Container(
        color: _theme.colorScheme.surface,
        height: preferredSize.height,
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
        child: Row(
          children: [
            _logo(context),
            const SizedBox(width: 48), //48
            Expanded(child: _nav(context)),
            const SizedBox(width: 48),
            _profile(context),
          ],
        ));
  }

  Widget _logo(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => context.goNamed('default'),
        child: Row(
          children: [
            Icon(UniconsLine.tag_alt,
                size: 20, color: _theme.colorScheme.primary),
            const SizedBox(width: 16),
            Text("NEXÆRA",
                style: _theme.textTheme.bodyMedium!.copyWith(
                  fontFamily: 'SpaceGrotesk',
                  letterSpacing: 4,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                )),
          ],
        ));
  }

  Widget _nav(BuildContext context) {
    List<Widget> menuItems = [
      NavigationTextItem(
          title: NavItem.start.displayName,
          route: 'default',
          isSelected: isSelected(context, '/')),
      NavigationTextItem(
          title: NavItem.workshop.displayName,
          route: 'workshop',
          isSelected: isSelected(context, '/workshop')),
      NavigationTextItem(
          title: NavItem.docs.displayName,
          route: 'docs',
          isSelected: isSelected(context, '/docs')),
    ];

    return Wrap(spacing: 32, children: menuItems);
  }

  Widget _profile(BuildContext context) {
    return GestureDetector(
      onTap: () => context.goNamed('profile'),
      child: Container(
        height: 32,
        width: 32,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: _theme.colorScheme.surfaceVariant),
      ),
    );
  }

  bool isSelected(BuildContext context, String route) {
    var location = GoRouter.of(context).location;
    if (route == '/') return location == '/';
    return location.startsWith(route);
  }

  @override
  Size get preferredSize => const Size.fromHeight(64.0);
}

class NavigationTextItem extends StatelessWidget {
  const NavigationTextItem(
      {super.key,
      required this.title,
      required this.route,
      required this.isSelected});

  final String title;
  final String route;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => context.goNamed(route),
        child: Text(title,
            style: theme.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color:
                    isSelected ? null : theme.colorScheme.onSurfaceVariant)));
  }
}
