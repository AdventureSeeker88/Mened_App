import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mended/provider/auth_pro.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/widgets/custom_icon_button.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            "assets/images/png/fondo.png",
          ),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: CustomIconButton(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close,
                            color: themewhitecolor,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      "Forgot Password",
                      style: TextStyle(
                        fontSize: 40,
                        color: themewhitecolor,
                        fontWeight: FontWeight.bold,
                        fontFamily: "dripping",
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 10,
                        left: 30,
                        right: 30,
                        bottom: 5,
                      ),
                      child: Text(
                        "Oops, It happens to the best of us, Input your address to fix the issue",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: themegreycolor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 40,
                          horizontal: 25,
                        ),
                        child: Column(
                          children: [
                            // email
                            TextFormField(
                              style: const TextStyle(color: themewhitecolor),
                              controller: emailC,
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                // RouteNavigator.route(context, const SetNewPasswordScreen());

                if (_formKey.currentState!.validate()) {
                  final authProvider =
                      Provider.of<AuthPro>(context, listen: false);

                  authProvider.forgotPassword(emailC.text, context);
                }
              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 60.0,
                    left: 20,
                    right: 20,
                  ),
                  child: Container(
                    height: 80,
                    width: size.width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/images/png/mended-button.png",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: themewhitecolor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
