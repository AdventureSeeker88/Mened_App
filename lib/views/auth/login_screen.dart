import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mended/provider/auth_pro.dart';
import 'package:mended/route/go_router.dart';
import 'package:mended/route/navigator.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/utils/path.dart';
import 'package:mended/widgets/custom_text_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              Assets.greenBackground,
              fit: BoxFit.cover,
              width: size.width,
              // height: size.height,
            ),
            SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Column(
                    children: [
                      Image.asset(
                        Assets.welcomeSticker,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 40,
                          horizontal: 25,
                        ),
                        child: Form(
                          key: formkey,
                          child: Column(
                            children: [
                              TextFormField(
                                style: const TextStyle(color: themewhitecolor),
                                controller: emailCtrl,
                                decoration: InputDecoration(
                                  hintText: "Email",
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
                                  contentPadding: const EdgeInsets.all(12),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Email is empty";
                                  }
                                  if (!RegExp(
                                          "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                      .hasMatch(value)) {
                                    return ("Please Enter a valid email");
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              TextFormField(
                                style: const TextStyle(color: themewhitecolor),
                                controller: passwordCtrl,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "Password",
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
                                  contentPadding: const EdgeInsets.all(12),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Password is empty";
                                  } else if (value.length < 6) {
                                    return "Enter At Least 6 Characters";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: CustomTextButton(
                                  buttonText: "Forgot Password?",
                                  onTap: () {
                                    Go.named(context, Routes.forgotPassword);
                                  },
                                  textstyle: const TextStyle(
                                    color: themewhitecolor,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              InkWell(
                                onTap: () {
                                  if (formkey.currentState!.validate()) {
                                    final post = Provider.of<AuthPro>(context,
                                        listen: false);

                                    post.loginFun(emailCtrl.text,
                                        passwordCtrl.text, context);
                                  }
                                },
                                child: Container(
                                  height: 70,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        Assets.mendedButton,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        color: themewhitecolor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: size.width / 100 * 28,
                                    child: const Divider(
                                      color: themewhitecolor,
                                    ),
                                  ),
                                  const Text(
                                    "or sign up with",
                                    style: TextStyle(
                                      color: themewhitecolor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width / 100 * 28,
                                    child: const Divider(
                                      color: themewhitecolor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: List.generate(
                                  3,
                                  (index) => CircleAvatar(
                                    radius: 25,
                                    backgroundColor: themewhitecolor,
                                    child: SvgPicture.asset(
                                      index == 0
                                          ? Assets.googleSvg
                                          : index == 1
                                              ? Assets.facebookSvg
                                              : Assets.appleSvg,
                                      height: index == 1
                                          ? 30
                                          : index == 2
                                              ? 30
                                              : 25,
                                      width: 30,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Text.rich(
                                TextSpan(
                                  text: "Not registered yet? ",
                                  style: const TextStyle(
                                    color: themewhitecolor,
                                    fontSize: 16,
                                  ),
                                  children: [
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Go.named(
                                            context,
                                            Routes.signup,
                                          );
                                        },
                                      text: "Create Account",
                                      style: const TextStyle(
                                        color: themeorangecolor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
