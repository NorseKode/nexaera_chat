import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:nexaera_chat/presentation/constants/nav_items.dart';
import 'package:unicons/unicons.dart';

import '../../blocs/authentication/auth.dart';
import '../../utils/routes.dart';

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
        onTap: () => context.goNamed(NavItem.start.name),
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
    var location = GoRouter.of(context).location;
    List<Widget> menuItems =
        NavItem.values.map((e) => NavigationTextItem(navItem: e)).toList();

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

  @override
  Size get preferredSize => const Size.fromHeight(64.0);
}

class NavigationTextItem extends StatelessWidget {
  const NavigationTextItem({
    super.key,
    required this.navItem,
  });

  final NavItem navItem;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var isSelected = _isSelected(GoRouter.of(context).location, navItem.route);
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => context.goNamed(navItem.name),
        child: Text(navItem.displayName,
            style: theme.textTheme.bodyMedium!.copyWith(
                fontFamily: 'SpaceGrotesk',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color:
                    isSelected ? null : theme.colorScheme.onSurfaceVariant)));
  }

  bool _isSelected(String location, String route) {
    if (route == '/') return location == '/';
    return location.startsWith(route);
  }
}
