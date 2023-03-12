import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.prefixIcon,
      required this.hint,
      this.controller,
      this.readOnly,
      this.keyboardType,
      this.obscureText,
      this.onSubmitted,
      this.textInputAction,
      this.suffixIcon});

  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String hint;
  final bool? readOnly;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final TextInputAction? textInputAction;
  final Function(String value)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var controller = this.controller ?? TextEditingController();

    return TextField(
      readOnly: readOnly ?? false,
      onSubmitted: onSubmitted,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      controller: controller,
      textInputAction: textInputAction,
      style: theme.textTheme.bodyMedium!.copyWith(fontFamily: 'Inter'),
      decoration: InputDecoration(
          isDense: true,
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon,
                  size: 18, color: theme.colorScheme.onSurfaceVariant)
              : null,
          suffixIcon: suffixIcon != null
              ? GestureDetector(
                  onTap: () => onSubmitted != null
                      ? onSubmitted!(controller.text)
                      : null,
                  child: Icon(suffixIcon,
                      size: 18, color: theme.colorScheme.onSurfaceVariant),
                )
              : null,
          hintText: hint,
          hintStyle: theme.textTheme.bodyMedium!.copyWith(
              fontFamily: 'Inter',
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500),
          filled: true,
          fillColor: theme.colorScheme.surface,
          border: const OutlineInputBorder(borderSide: BorderSide.none)),
    );
  }
}


//  Container(
//                                 decoration: BoxDecoration(
//                                     color: theme.colorScheme.surface,
//                                     borderRadius: BorderRadius.circular(5)),
//                                 padding: EdgeInsets.all(16),
//                                 child: TextField(
//                                   decoration: InputDecoration(
//                                       isCollapsed: true,
//                                       hintText: 'Testing',
//                                       hintStyle: theme.textTheme.bodyMedium!
//                                           .copyWith(
//                                               color: theme
//                                                   .colorScheme.onSurfaceVariant,
//                                               fontWeight: FontWeight.w500),
//                                       filled: true,
//                                       fillColor: theme.colorScheme.surface,
//                                       border: const OutlineInputBorder(
//                                           borderSide: BorderSide.none)),
//                                 ),
//                               ),