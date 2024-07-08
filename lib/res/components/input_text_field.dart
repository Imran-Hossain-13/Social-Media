import 'package:flutter/material.dart';

import '../color.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController myController;
  final FocusNode focusNode;
  final FormFieldSetter onFieldSubmittedValue;
  final FormFieldValidator onValidator;

  final TextInputType keyboardType;
  final String hint;
  final bool obscureText;
  final bool enable, autofocus;
  const InputTextField({
    super.key,
    required this.myController,
    required this.focusNode,
    required this.onFieldSubmittedValue,
    required this.onValidator,
    required this.keyboardType,
    required this.hint,
    required this.obscureText,
    this.enable = true,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextFormField(
        controller: myController,
        focusNode: focusNode,
        obscureText: obscureText,
        onFieldSubmitted: onFieldSubmittedValue,
        validator: onValidator,
        cursorColor: AppColors.secondaryColor,
        keyboardType: keyboardType,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 19,height: 0),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(color: AppColors.primaryTextTextColor.withOpacity(0.8),height: 0),
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.textFieldDefaultFocus,)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.secondaryColor,width: 2)
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.alertColor,width: 2)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.textFieldDefaultBorderColor,width: 2)
          ),
        ),
      ),
    );
  }
}
