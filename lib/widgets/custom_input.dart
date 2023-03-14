import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:siangmalam/commons/custom_style.dart';
import 'package:siangmalam/commons/size_config.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:sizer/sizer.dart';
/*Created By Dwi Sutrisno*/

/*Custom Form Widget*/
class CustomFormWidget {
  static InputDecoration customInputDecorationWithSuffix(
      String hint, String label, IconData icon) {
    return InputDecoration(
        fillColor: Colors.white,
        filled: true,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        border: outlineInputBorder,
        hintText: hint,
        labelText: label,
        labelStyle: inputLabelStyle,
        errorStyle: errorTextStyle,
        contentPadding: inputCustomPadding(),
        suffixIcon: customSuffixIconPadding(icon));
  }

  static InputDecoration customInputDecorationWithSuffixSize(String hint,
      String label, IconData icon, double labelsize, Color fillcolor) {
    return InputDecoration(
        fillColor: fillcolor,
        filled: true,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        prefixIconConstraints: const BoxConstraints(minWidth: 80),
        suffixIconConstraints: const BoxConstraints(minWidth: 80),
        border: outlineInputBorder,
        hintText: hint,
        // labelText: label,
        labelStyle: inputLabelStyle,
        errorStyle: errorTextStyle,
        // contentPadding: inputCustomPadding(),
        suffixIcon: customSuffixIconPrimaryGold(icon));
  }

  static InputDecoration customInputDecorationWithPrefix(
      String hint, String label, IconData icon) {
    return InputDecoration(
      fillColor: Colors.white,
      filled: true,
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      border: outlineInputBorder,
      hintText: hint,
      labelText: label,
      labelStyle: inputLabelStyle,
      errorStyle: errorTextStyle,
      contentPadding: inputCustomPadding(),
      // suffixIcon: customSuffixIconPadding(icon),
      prefixIcon: customPrefixIconPadding(icon),
    );
  }

  static InputDecoration customInputDecoration(String hint, String label) {
    return InputDecoration(
        fillColor: Colors.white,
        filled: true,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        border: outlineInputBorder,
        hintText: hint,
        labelText: label,
        labelStyle: inputLabelStyle,
        errorStyle: errorTextStyle,
        contentPadding: inputCustomPadding());
  }

  static EdgeInsets inputCustomPadding() {
    return EdgeInsets.symmetric(horizontal: 7.0.w, vertical: 1.5.h);
  }

  static Padding customSuffixIconPadding(IconData icon) {
    return Padding(
      padding: EdgeInsets.only(right: getProportionateScreenWidth(20)),
      child: Icon(
        icon,
        color: primaryGrey,
        size: getProportionateScreenHeight(28),
      ),
    );
  }

  static Padding customSuffixIconPrimaryGold(IconData icon) {
    return Padding(
      padding: EdgeInsets.only(right: getProportionateScreenWidth(0)),
      child: Icon(
        icon,
        color: primaryGoldText,
        size: getProportionateScreenHeight(28),
      ),
    );
  }

  static Padding customPrefixIconPadding(IconData icon) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: Icon(
        icon,
        color: primaryGrey,
        size: getProportionateScreenHeight(28),
      ),
    );
  }
}
/*Custom Form Widget*/

/*Custom Input Field*/
class CustomInputField extends StatelessWidget {
  final String hint;
  final String label;
  final bool enable;
  final IconData icon;
  final TextInputType inputType;
  final FocusScopeNode node;

  final String? Function(String?)? validationBuilder;
  final Function(String?)? dataInstance;

  const CustomInputField(
      {Key? key,
      required this.hint,
      required this.label,
      required this.icon,
      required this.enable,
      required this.node,
      required this.inputType,
      required this.validationBuilder,
      required this.dataInstance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        enabled: enable,
        keyboardType: inputType,
        onSaved: dataInstance,
        validator: validationBuilder,
        decoration:
            CustomFormWidget.customInputDecorationWithSuffix(hint, label, icon),
        onEditingComplete: () => node.nextFocus());
  }
} /*Custom Input Field*/

/*Custom Input Field*/
class CustomInputFieldWithController extends StatelessWidget {
  final String hint;
  final String label;
  final bool enable;
  final IconData icon;
  final TextInputType inputType;
  final FocusScopeNode node;
  final TextEditingController controller;

  final String? Function(String?)? validationBuilder;
  final Function(String?)? dataInstance;

  const CustomInputFieldWithController({
    Key? key,
    required this.hint,
    required this.label,
    required this.enable,
    required this.icon,
    required this.node,
    required this.inputType,
    required this.validationBuilder,
    required this.dataInstance,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable,
      controller: controller,
      keyboardType: inputType,
      onSaved: dataInstance,
      validator: validationBuilder,
      decoration:
          CustomFormWidget.customInputDecorationWithSuffix(hint, label, icon),
      onEditingComplete: () => node.nextFocus(),
    );
  }
}

/*Custom Input Field*/
class CustomInputFieldWithControllerSingleFocus extends StatelessWidget {
  final String hint;
  final String label;
  final bool enable;
  final IconData icon;
  final TextInputType inputType;
  final FocusScopeNode node;
  final TextEditingController controller;

  final String? Function(String?)? validationBuilder;
  final Function(String?)? dataInstance;

  const CustomInputFieldWithControllerSingleFocus({
    Key? key,
    required this.hint,
    required this.label,
    required this.enable,
    required this.icon,
    required this.node,
    required this.inputType,
    required this.validationBuilder,
    required this.dataInstance,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable,
      controller: controller,
      keyboardType: inputType,
      onSaved: dataInstance,
      validator: validationBuilder,
      decoration:
          CustomFormWidget.customInputDecorationWithSuffix(hint, label, icon),
      onEditingComplete: () => node.unfocus(),
    );
  }
}

/*Custom Input Field Formater*/
class CustomInputFieldWithControllerFormater extends StatelessWidget {
  final String hint;
  final String label;
  final bool enable;
  final IconData icon;
  final TextInputType inputType;
  final TextInputFormatter formater;
  final FocusScopeNode node;
  final TextEditingController controller;

  final String? Function(String?)? validationBuilder;
  final Function(String?)? dataInstance;

  const CustomInputFieldWithControllerFormater(
      {Key? key,
      required this.hint,
      required this.label,
      required this.enable,
      required this.icon,
      required this.node,
      required this.inputType,
      required this.validationBuilder,
      required this.dataInstance,
      required this.controller,
      required this.formater})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        enabled: enable,
        controller: controller,
        keyboardType: inputType,
        onSaved: dataInstance,
        validator: validationBuilder,
        inputFormatters: [formater],
        decoration:
            CustomFormWidget.customInputDecorationWithSuffix(hint, label, icon),
        onEditingComplete: () => node.nextFocus());
  }
}

/* Custom Input Without Node */
class CustomInputFieldWONode extends StatelessWidget {
  final String hint;
  final String label;
  final bool enable;
  final IconData icon;
  final TextInputType inputType;
  final TextEditingController controller;
  final int lineNumbers;
  final int maxlines;

  final String? Function(String?)? validationBuilder;
  final Function(String?)? dataInstance;

  const CustomInputFieldWONode({
    Key? key,
    required this.hint,
    required this.label,
    required this.enable,
    required this.icon,
    required this.inputType,
    required this.validationBuilder,
    required this.dataInstance,
    required this.controller,
    required this.lineNumbers,
    required this.maxlines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: lineNumbers,
      maxLength: maxlines,
      enabled: enable,
      controller: controller,
      keyboardType: inputType,
      onSaved: dataInstance,
      validator: validationBuilder,
      decoration:
          CustomFormWidget.customInputDecorationWithSuffix(hint, label, icon),
    );
  }
}
/* Custom Input Without Node */

/*Custom Input Field*/
class CustomInputFieldWithControllerBigSize extends StatelessWidget {
  final String hint;
  final String label;
  final double labelsize;
  final Color colorfill;
  final bool enable;
  final IconData icon;
  final TextInputType inputType;
  final FocusScopeNode node;
  final TextEditingController controller;

  final String? Function(String?)? validationBuilder;
  final Function(String?)? dataInstance;

  const CustomInputFieldWithControllerBigSize({
    Key? key,
    required this.hint,
    required this.label,
    required this.labelsize,
    required this.colorfill,
    required this.enable,
    required this.icon,
    required this.node,
    required this.inputType,
    required this.validationBuilder,
    required this.dataInstance,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.normal,
      ),
      enabled: enable,
      controller: controller,
      keyboardType: inputType,
      onSaved: dataInstance,
      validator: validationBuilder,
      decoration: CustomFormWidget.customInputDecorationWithSuffixSize(
        hint,
        label,
        icon,
        labelsize,
        colorfill,
      ),
      onEditingComplete: () => node.nextFocus(),
    );
  }
}
