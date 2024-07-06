import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giftappgp/utils/AppColors.dart';

class DefaultTextFormField extends StatelessWidget {
  final BuildContext context;
  final String hintText;
  final String? Function(String? val)? validator;
  final TextEditingController controller;
  final TextInputType type;
  final bool isPassword;
  final IconData iconData;
  final bool enable;

  const DefaultTextFormField(
      {Key? key,
      required this.context,
      required this.hintText,
      required this.validator,
      required this.controller,
      required this.type,
      this.enable = true,
      this.isPassword = false,
      required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: enable,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(iconData),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: AppColors.grey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: AppColors.grey,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: AppColors.grey,
          ),
        ),
        filled: true,
        fillColor: AppColors.grey,
        contentPadding: const EdgeInsets.only(left: 34, top: 40),
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}

Widget customTextFieldWidget(
        {required TextEditingController controller,
        required String title,
        required bool enable,
        bool? Isnumber,
        bool? require,
        int? maxline,
        bool? visibility,
        Function()? visabiltyfun,
        String? Function(String?)? validator,
        required IconData? iconData,
        required bool IsPass,
        required double height,
        List<TextInputFormatter>? inputFormatters,
        required double width}) =>
    Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.only(top: 5, bottom: 5, right: 15, left: 15),
      child: TextFormField(
        enabled: enable,
        validator: validator,
        maxLines: maxline == null ? 1 : maxline,
        inputFormatters: inputFormatters,
        keyboardType:
            Isnumber == true ? TextInputType.number : TextInputType.text,
        controller: controller,
        obscureText: IsPass
            ? visibility == null
                ? true
                : visibility == false
                    ? true
                    : false
            : false,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          prefixIcon: Icon(
            iconData,
            color: AppColors.primary,
          ),
          suffixIcon: IsPass
              ? InkWell(
                  onTap: visabiltyfun,
                  child: Icon(visibility == false
                      ? Icons.visibility
                      : Icons.visibility_off),
                )
              : null,
          label: Row(
            children: [
              Text(title, style: const TextStyle(color: Colors.grey)),
              require == true
                  ? Text('*', style: const TextStyle(color: Colors.red))
                  : Container(),
            ],
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: AppColors.grey,
              //  color: AppColors.color1,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: AppColors.grey,

              //color: AppColors.color1,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: AppColors.grey,

              //color: AppColors.color1,
              width: 2.0,
            ),
          ),
        ),
      ),
    );

class BuildHeader extends StatelessWidget {
  final String title;

  const BuildHeader({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    );
  }
}

class TotalText extends StatelessWidget {
  final String title;
  final String price;

  const TotalText({
    Key? key,
    required this.title,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(color: AppColors.primary),
        ),
        Text(
          '\$$price',
          style: const TextStyle(color: AppColors.primary),
        ),
      ],
    );
  }
}

class BuildSecondHeader extends StatelessWidget {
  final String title;
  final double? fontSize;
  final TextAlign? textAlign;

  const BuildSecondHeader({
    Key? key,
    required this.title,
    this.fontSize,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      style: TextStyle(color: AppColors.primary, fontSize: fontSize),
    );
  }
}

class CustomTitle extends StatelessWidget {
  final String title;
  final double fontSize;

  const CustomTitle({
    Key? key,
    required this.title,
    this.fontSize = 18.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class DefaultButton extends StatelessWidget {
  final Color color;
  final String title;
  final VoidCallback onPressed;
  final Color textColor;
  final double width;
  final double height;

  const DefaultButton({
    Key? key,
    this.color = AppColors.primary,
    required this.title,
    this.textColor = Colors.white,
    this.width = double.infinity,
    this.height = 56,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      child: Text(
        title,
        style: TextStyle(fontSize: 17),
      ),
      textColor: textColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      height: height,
      minWidth: width,
    );
  }
}

class RawButton extends StatelessWidget {
  final Color buttonColor;
  final String text;
  final String image;
  final VoidCallback onPressed;

  const RawButton({
    Key? key,
    required this.buttonColor,
    required this.text,
    required this.image,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: buttonColor,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      height: 56,
      minWidth: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SvgPicture.asset(image),
          // const SizedBox(width: 32.4),
          Text(text),
        ],
      ),
      onPressed: onPressed,
    );
  }
}

class DefaultTextButton extends StatelessWidget {
  final Color? color;
  final String child;
  final VoidCallback onPressed;
  final FontWeight fontWeight;

  const DefaultTextButton({
    Key? key,
    this.color,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        child,
        style: TextStyle(
          color: color,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (route) => false,
  );
}

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? color;
  final Color? backgroundColor;
  final double? elevation;
  final Color? iconColor;
  final BuildContext context;

  const DefaultAppBar({
    Key? key,
    required this.title,
    this.color,
    this.backgroundColor,
    this.elevation,
    this.iconColor,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: iconColor),
      backgroundColor: backgroundColor,
      elevation: elevation,
      title: Text(title),
      actions: [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CircularIndicator extends StatelessWidget {
  const CircularIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

String? uId = '';

const SizedBox sizedBox12 = SizedBox(height: 12);

const SizedBox sizedBox28 = SizedBox(height: 28);

const SizedBox sizedBox20 = SizedBox(height: 20);

const SizedBox sizedBox10 = SizedBox(height: 10);

const SizedBox sizedBox15 = SizedBox(height: 15);

const EdgeInsets paddingAll = EdgeInsets.all(20);

const EdgeInsets paddingHorizontal = EdgeInsets.symmetric(horizontal: 20);
