import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown(
      {super.key, required this.items, required this.onSelected});

  final List<DropdownMenuEntry> items;
  final Function(dynamic) onSelected;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return DropdownMenu(
      enableFilter: true,
      dropdownMenuEntries: items,
      onSelected: onSelected,
      trailingIcon: const Icon(
        UniconsLine.angle_down,
        size: 20,
      ),
      menuStyle: MenuStyle(),
      inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          isCollapsed: true,
          filled: true,
          fillColor: theme.colorScheme.surface,
          border: const OutlineInputBorder(borderSide: BorderSide.none)),
    );
  }
}

class CustomDropdownItem extends DropdownMenuEntry {
  const CustomDropdownItem({required super.value, required super.label});
}
