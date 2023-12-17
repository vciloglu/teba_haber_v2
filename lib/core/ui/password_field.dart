import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField(
      {super.key,
      this.validator,
      this.disabled = false,
      this.labelText,
      this.onChange,
      this.decoration,
      this.controller,
      this.initialValue});

  final String? Function(String?)? validator;
  final void Function(String?)? onChange;
  final bool disabled;
  final String? labelText;
  final InputDecoration? decoration;
  final TextEditingController? controller;
  final String? initialValue;

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _isSecureText = true;
  void _changeSecureText() {
    setState(() {
      _isSecureText = !_isSecureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _isSecureText,
      initialValue: widget.initialValue,
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChange,
      decoration: InputDecoration(
        enabled: !widget.disabled,
        labelText: widget.labelText,
        suffixIcon: IconButton(
          onPressed: () {
            _changeSecureText();
          },
          icon: _isSecureText
              ? const Icon(Icons.visibility_outlined)
              : const Icon(Icons.visibility_off_outlined),
        ),
      ),
    );
  }
}
