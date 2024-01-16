import 'package:flutter/material.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/widgets/custom_icon_button.dart';
import 'package:mended/widgets/custom_outlined_button.dart';
import 'package:mended/widgets/custom_simple_rounded_button.dart';
import 'package:mended/widgets/custom_text_button.dart';
class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themegreencolor,
      bottomNavigationBar: SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CustomSimpleRoundedButton(
                onTap: () {
                
                },
                height: 45,
                width: double.infinity,
                buttoncolor: Palette.themecolor,
                borderRadius: BorderRadius.circular(5),
                child: Text(
                  "I Agree".toUpperCase(),
                  style: const TextStyle(
                    color: themewhitecolor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomOutlinedButton(
                onTap: () {},
                height: 45,
                width: double.infinity,
                borderRadius: BorderRadius.circular(5),
                borderColor: themewhitecolor,
                child: Text(
                  "I Disagree".toUpperCase(),
                  style: const TextStyle(
                    color: themewhitecolor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      "Terms and conditions",
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
                const Center(
                  child: Text(
                    "Review Terms & Conditions",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Palette.themecolor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Your privacy is important to us. It is Brainstorming's policy to respect your privacy regarding any information we may collect from you across our website, and other sites we own and operate.\n\nWe only ask for personal information when we truly need it to provide a service to you. We collect it by fair and lawful means, with your knowledge and consent. We also let you know why we’re collecting it and how it will be used.\n\nWe only retain collected information for as long as necessary to provide you with your requested service. ",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: themegreytextcolor, fontSize: 16),
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: CustomTextButton(
                    buttonText: "Terms & Conditions",
                    onTap: () {},
                    textstyle: const TextStyle(
                      color: Palette.themecolor,
                      fontSize: 18,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: CustomTextButton(
                    buttonText: "Privacy Policy",
                    onTap: () {},
                    textstyle: const TextStyle(
                      color: Palette.themecolor,
                      fontSize: 18,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
