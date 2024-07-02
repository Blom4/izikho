import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MyTextFieldWidget extends HookWidget {
  const MyTextFieldWidget({
    super.key,
    required this.labelText,
    required this.controller,
    this.isPassword = false,
    this.onTap,
    this.readOnly = false,
    this.maxLines,
    this.suffixIcon,
    this.validator,
    this.keyboardType,
    this.helperText,
  });

  final TextEditingController controller;
  final bool isPassword;
  final String labelText;
  final VoidCallback? onTap;
  final bool readOnly;
  final int? maxLines;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final String? helperText;

  @override
  Widget build(BuildContext context) {
    final toggleShowPassword = useState(isPassword);
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: validator,
      onTap: onTap,
      readOnly: readOnly,
      obscureText: toggleShowPassword.value,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        isDense: true,
        helperText: helperText,
        helperMaxLines: 2,
        labelText: labelText,
        border: const OutlineInputBorder(),
        suffixIcon: !isPassword
            ? suffixIcon
            : InkWell(
                onTap: () {
                  toggleShowPassword.value = !toggleShowPassword.value;
                },
                child: Icon(toggleShowPassword.value
                    ? Icons.visibility
                    : Icons.visibility_off),
              ),
      ),
      cursorColor: Colors.black,
      maxLines: isPassword ? 1 : maxLines,

      keyboardType: keyboardType,
      //textInputAction: TextInputAction.done,
    );
  }
}
