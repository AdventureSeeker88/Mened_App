import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mended/provider/auth_pro.dart';
import 'package:mended/route/go_router.dart';
import 'package:mended/route/navigator.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/widgets/custom_icon_button.dart';
import 'package:mended/widgets/toast.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool visiblePass = true;
  bool visibleConfirmPass = true;
  bool value = false;
  final _formKey = GlobalKey<FormState>();

  final List<String> categoryList = [
    'College Life',
    'Depression',
    'Anxiety',
    'Military',
    'Single mom',
    'Single dad',
    'Heartbreak',
    'Business',
    'Stressed',
    'Sports',
    'Other'
  ];
  String categoryValue = "";
  final TextEditingController userNameC = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();
  final TextEditingController confirmPasswordC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // background
            Image.asset(
              "assets/images/png/fondo.png",
              fit: BoxFit.cover,
              width: size.width,
            ),
            SingleChildScrollView(
              child: Center(
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
                        "Create Account",
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
                          "You are just one step away from being part of this family",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: themegreycolor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Text(
                        "Love conquers all",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: themegreycolor,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 40,
                          horizontal: 25,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              // user name
                              TextFormField(
                                style: const TextStyle(color: themewhitecolor),
                                controller: userNameC,
                                decoration: InputDecoration(
                                  hintText: "User Name",
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
                                    return "Username is empty";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              // your email
                              TextFormField(
                                style: const TextStyle(color: themewhitecolor),
                                controller: emailC,
                                decoration: InputDecoration(
                                  hintText: "Your Email",
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
                              // password
                              TextFormField(
                                style: const TextStyle(color: themewhitecolor),
                                controller: passwordC,
                                obscureText: visiblePass,
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
                                  suffixIcon: CustomIconButton(
                                    onTap: () {
                                      if (visiblePass == true) {
                                        setState(() {
                                          visiblePass = false;
                                        });
                                      } else if (visiblePass == false) {
                                        setState(() {
                                          visiblePass = true;
                                        });
                                      }
                                    },
                                    child: Icon(
                                      visiblePass == false
                                          ? Icons.remove_red_eye
                                          : Icons.remove_red_eye_outlined,
                                      color: themewhitecolor,
                                    ),
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
                                height: 25,
                              ),
                              // confirm password
                              TextFormField(
                                style: const TextStyle(color: themewhitecolor),
                                controller: confirmPasswordC,
                                obscureText: visibleConfirmPass,
                                decoration: InputDecoration(
                                  hintText: "Confirm Password",
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
                                      if (visibleConfirmPass == true) {
                                        setState(() {
                                          visibleConfirmPass = false;
                                        });
                                      } else if (visibleConfirmPass == false) {
                                        setState(() {
                                          visibleConfirmPass = true;
                                        });
                                      }
                                    },
                                    child: Icon(
                                      visibleConfirmPass == false
                                          ? Icons.remove_red_eye
                                          : Icons.remove_red_eye_outlined,
                                      color: themewhitecolor,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.all(12),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Password is empty";
                                  } else if (value.length < 6) {
                                    return "Enter At Least 6 Characters";
                                  } else if (value != passwordC.text) {
                                    return "Confirm password doesn't match";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              DropdownButtonFormField(
                                  focusColor: themewhitecolor,
                                  style:
                                      const TextStyle(color: themewhitecolor),
                                  dropdownColor: themegreencolor,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: themewhitecolor.withOpacity(0.4),
                                    hintText: "Select Categories",
                                    hintStyle: const TextStyle(
                                      color: themewhitecolor,
                                    ),
                                    isDense: true,
                                    alignLabelWithHint: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 11, horizontal: 6),
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
                                  ),
                                  // value: degree_value,
                                  items: categoryList
                                      .map((item) => DropdownMenuItem(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: themewhitecolor,
                                            ),
                                          )))
                                      .toList(),
                                  onChanged: (item) {
                                    categoryValue = item.toString();
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      return "Please Select Categories";
                                    }
                                  }),

                              const SizedBox(
                                height: 40,
                              ),
                              CheckboxListTile(
                                value: value,
                                contentPadding: EdgeInsets.zero,
                                activeColor: themelightgreencolor,
                                title: const Text(
                                  "I accept the terms and privacy policy",
                                  style: TextStyle(
                                    color: themegreycolor,
                                    fontSize: 18,
                                  ),
                                ),
                                checkboxShape: const CircleBorder(),
                                side: const BorderSide(
                                  color: themewhitecolor,
                                  width: 2,
                                ),
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    value = newValue!;
                                  });
                                },
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (value != true) {
                                      customToast(
                                          "Please Select Privacy policy to continue!",
                                          context);
                                    } else {
                                      final post = Provider.of<AuthPro>(context,
                                          listen: false);

                                      post.signupFun(
                                          userNameC.text,
                                          emailC.text,
                                          passwordC.text,
                                          categoryValue,
                                          context);
                                    }
                                  }
                                  // RouteNavigator.route(
                                  //     context, const OnboardingScreen());
                                },
                                child: Container(
                                  height: 70,
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
                                      "Sign up",
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
                              Text.rich(
                                TextSpan(
                                  text: "Already have an account? ",
                                  style: const TextStyle(
                                    color: themewhitecolor,
                                    fontSize: 16,
                                  ),
                                  children: [
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Go.named(context, Routes.login);
                                        },
                                      text: "Login",
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
