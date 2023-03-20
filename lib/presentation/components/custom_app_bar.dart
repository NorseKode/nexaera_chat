import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nexaera_chat/blocs/user/user_bloc.dart';
import 'package:nexaera_chat/presentation/components/page_header.dart';
import 'package:nexaera_chat/presentation/constants/nav_items.dart';
import 'package:unicons/unicons.dart';

import '../../app/auth.dart';
import '../../utils/routes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? actions;

  CustomAppBar({super.key, this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    var auth = context.read<AuthProvider>();
    var theme = Theme.of(context);
    return Container(
        color: theme.colorScheme.surface,
        height: preferredSize.height,
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
        child: Row(
          children: [
            GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => context.goNamed(NavItem.start.name),
                child: Row(
                  children: [
                    Text("NEXÆRA",
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontFamily: 'SpaceGrotesk',
                          letterSpacing: 4,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        )),
                  ],
                )),
            const SizedBox(width: 32), //48
            Expanded(child: _nav(context)),
            const SizedBox(width: 32),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserInitial) {
                  context.read<UserBloc>().add(GetUserDetails(auth.user!.uid));
                }
                return GestureDetector(
                  onTap: () => context.goNamed(NavItem.account.name),
                  child: Container(
                    height: 32,
                    width: 32,
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: theme.colorScheme.surfaceVariant),
                    child: FittedBox(
                        child: Headline(
                      title: state is UserLoaded
                          ? getInitials(state.firstName, state.lastName)
                          : '',
                    )),
                  ),
                );
              },
            ),
          ],
        ));
  }

  String getInitials(String firstname, String lastname) {
    String initials = "";

    initials += firstname.isNotEmpty ? firstname[0] : '';
    initials += lastname.isNotEmpty ? lastname[0] : '';

    return initials.toUpperCase();
  }

  Widget _nav(BuildContext context) {
    List<Widget> menuItems = [
      const _NavigationTextItem(navItem: NavItem.chat),
      const _NavigationTextItem(navItem: NavItem.lab),
      const _NavigationTextItem(navItem: NavItem.docs),
    ];

    return Wrap(alignment: WrapAlignment.end, spacing: 32, children: menuItems);
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}

class _NavigationTextItem extends StatelessWidget {
  const _NavigationTextItem({
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
        onTap: () => context.go(navItem.route),
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
