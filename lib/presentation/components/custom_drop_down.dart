import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown(
      {super.key,
      required this.items,
      required this.onSelected,
      required this.selected});

  final List<DropdownMenuEntry> items;
  final String selected;
  final Function(dynamic) onSelected;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return DropdownMenu(
      enableFilter: false,
      enableSearch: false,
      initialSelection: selected,
      dropdownMenuEntries: items,
      onSelected: onSelected,
      trailingIcon: const Icon(
        UniconsLine.angle_down,
        size: 20,
      ),
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
