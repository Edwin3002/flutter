import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
 final Function(String)? onFieldSubmitted;

  const CustomTextFormField({
    super.key,
    this.label,
    this.hint,
    this.errorMessage,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.validator,
    this.onFieldSubmitted,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  
     bool showValue = false;
    void handleShowValue() {
      setState(() {
        showValue = !showValue;
      });
    }

  
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(40));

    const borderRadius = Radius.circular(15);
    return Container(
      // padding: const EdgeInsets.only(bottom: 0, top: 15),
      decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: borderRadius,
              bottomLeft: borderRadius,
              bottomRight: borderRadius),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, 5))
          ]),
      child: TextFormField(
        onChanged: widget.onChanged,
        validator: widget.validator,
        obscureText: widget.obscureText && !showValue,
        keyboardType: widget.keyboardType,
        style: const TextStyle(fontSize: 20, color: Colors.black54),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          floatingLabelStyle: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          enabledBorder: border,
          focusedBorder: border,
          errorBorder: border.copyWith(
              borderSide: BorderSide(color: Colors.red.shade800)),
          focusedErrorBorder: border.copyWith(
              borderSide: BorderSide(color: Colors.red.shade800)),
          isDense: true,
          label: widget.label != null ? Text(widget.label!) : null,
          hintText: widget.hint,
          errorText: widget.errorMessage,
          focusColor: colors.primary,
          suffixIcon: widget.obscureText
              ? Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: IconButton(
                      onPressed: handleShowValue,
                      icon: showValue
                          ? const Icon(Icons.close)
                          : const Icon(Icons.remove_red_eye)))
              : null,
          // icon: Icon( Icons.supervised_user_circle_outlined, color: colors.primary, )
        ),
      ),
    );
  }
}
