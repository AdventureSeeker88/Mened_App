import 'package:flutter/material.dart';
import 'package:mended/provider/auth_pro.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/widgets/custom_icon_button.dart';
import 'package:mended/widgets/custom_simple_rounded_button.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool oldPass = true;
  bool changePass = true;
  bool confirmChangePass = true;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordC = TextEditingController();
  final TextEditingController newPasswordC = TextEditingController();
  final TextEditingController confirmPasswordC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themegreencolor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: CustomSimpleRoundedButton(
          onTap: () {
            if (_formKey.currentState!.validate()) {
              final authProvider = Provider.of<AuthPro>(context, listen: false);

              authProvider.userChangePasswordFunc(
                  oldPasswordC.text, newPasswordC.text, context);
            }
          },
          height: 50,
          width: size.width,
          buttoncolor: themelightgreencolor,
          borderRadius: BorderRadius.circular(30),
          child: const Text(
            "Done",
            style: TextStyle(
              color: themewhitecolor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    CustomIconButton(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: themewhitecolor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Text(
                      "Change Password",
                      style: TextStyle(
                        color: themewhitecolor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: oldPasswordC,
                  obscureText: oldPass,
                  style: const TextStyle(
                    color: themewhitecolor,
                  ),
                  decoration: InputDecoration(
                    hintText: "Old Password",
                    hintStyle: const TextStyle(
                      color: themegreycolor,
                    ),
                    filled: true,
                    fillColor: themegreycolor.withOpacity(0.4),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: themewhitecolor,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: themewhitecolor,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: CustomIconButton(
                      onTap: () {
                        if (oldPass == true) {
                          setState(() {
                            oldPass = false;
                          });
                        } else if (oldPass == false) {
                          setState(() {
                            oldPass = true;
                          });
                        }
                      },
                      child: Icon(
                        oldPass == false
                            ? Icons.remove_red_eye
                            : Icons.remove_red_eye_outlined,
                        color: themewhitecolor,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Old Password is empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: newPasswordC,
                  obscureText: changePass,
                  style: const TextStyle(
                    color: themewhitecolor,
                  ),
                  decoration: InputDecoration(
                    hintText: "Change Password",
                    hintStyle: const TextStyle(
                      color: themegreycolor,
                    ),
                    filled: true,
                    fillColor: themegreycolor.withOpacity(0.4),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: themewhitecolor,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: themewhitecolor,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: CustomIconButton(
                      onTap: () {
                        if (changePass == true) {
                          setState(() {
                            changePass = false;
                          });
                        } else if (changePass == false) {
                          setState(() {
                            changePass = true;
                          });
                        }
                      },
                      child: Icon(
                        changePass == false
                            ? Icons.remove_red_eye
                            : Icons.remove_red_eye_outlined,
                        color: themewhitecolor,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "New Password is empty";
                    } else if (value.length <= 6) {
                      return "Password length should be greater than 6 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: confirmPasswordC,
                  obscureText: confirmChangePass,
                  cursorColor: themewhitecolor,
                  style: const TextStyle(
                    color: themewhitecolor,
                  ),
                  decoration: InputDecoration(
                    hintText: "Confirm Change Password",
                    hintStyle: const TextStyle(
                      color: themegreycolor,
                    ),
                    filled: true,
                    fillColor: themegreycolor.withOpacity(0.4),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: themewhitecolor,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: themewhitecolor,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: CustomIconButton(
                      onTap: () {
                        if (confirmChangePass == true) {
                          setState(() {
                            confirmChangePass = false;
                          });
                        } else if (confirmChangePass == false) {
                          setState(() {
                            confirmChangePass = true;
                          });
                        }
                      },
                      child: Icon(
                        confirmChangePass == false
                            ? Icons.remove_red_eye
                            : Icons.remove_red_eye_outlined,
                        color: themewhitecolor,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Confirm Password is empty";
                    } else if (value != newPasswordC.text) {
                      return "Confirm new password doesn't match";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
