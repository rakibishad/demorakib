import 'package:flutter/material.dart';
import 'package:parivesh/extra/colors.dart';
import 'package:parivesh/extra/common_style.dart';

class TextInputFieldPassword extends StatelessWidget {
  final Function(String value) onChanged;
  final String? Function(String? value) validator;
  final TextInputAction textInputAction;
  final ValueNotifier<bool> isPasswordVisible = ValueNotifier(true);

  TextInputFieldPassword(
      {super.key,
      this.textInputAction = TextInputAction.done,
      required this.validator,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isPasswordVisible,
        builder: (BuildContext context, bool counterValue, Widget? child) {
          return Theme(
            data: Theme.of(context).copyWith(
              textSelectionTheme: TextSelectionThemeData(
                selectionColor: MyColor.lightGray,
                selectionHandleColor: MyColor.lightGray,
              ),
            ),
            child: TextFormField(
              obscureText: isPasswordVisible.value,
              autovalidateMode: AutovalidateMode.disabled,
              style: textStyleNormal,
              cursorColor: MyColor.darkGrey,
              keyboardType: TextInputType.text,
              textInputAction: textInputAction,
              validator: validator,
              onChanged: onChanged,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                alignLabelWithHint: true,
                suffixIcon: GestureDetector(
                  child: Icon(
                    counterValue
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.grey,
                  ),
                  onTap: () => isPasswordVisible.value = !isPasswordVisible.value,
                ),
                enabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
                errorBorder: outlineInputBorderRed,
                focusedErrorBorder: outlineInputBorderRed,
              ),
            ),
          );
        });
  }
}
