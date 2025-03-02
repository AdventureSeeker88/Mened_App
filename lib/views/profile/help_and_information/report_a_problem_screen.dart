import 'package:flutter/material.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/widgets/custom_icon_button.dart';
import 'package:mended/widgets/custom_outlined_button.dart';
import 'package:mended/widgets/custom_simple_rounded_button.dart';
class ReportAProblemScreen extends StatefulWidget {
  const ReportAProblemScreen({super.key});

  @override
  State<ReportAProblemScreen> createState() => _ReportAProblemScreenState();
}

class _ReportAProblemScreenState extends State<ReportAProblemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themegreencolor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomSimpleRoundedButton(
          onTap: () {
            // RouteNavigator.route(
            //   context,
            //   const CreateAccountScreen(),
            // );
          },
          height: 45,
          width: double.infinity,
          buttoncolor: Palette.themecolor,
          borderRadius: BorderRadius.circular(5),
          child: Text(
            "Submit Report".toUpperCase(),
            style: const TextStyle(
              color: themewhitecolor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
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
                      "Report A Problem",
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
                    "We will help you as soon as you describe the problem in the paragraphs below",
                    style: TextStyle(
                      color: themegreytextcolor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: CustomOutlinedButton(
                    onTap: () {},
                    height: 45,
                    width: 200,
                    borderRadius: BorderRadius.circular(5),
                    borderColor: themewhitecolor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add,
                          color: themewhitecolor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Add a Photo".toUpperCase(),
                          style: const TextStyle(
                            color: themewhitecolor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Comments",
                  style: TextStyle(
                    color: themewhitecolor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),


                TextFormField(
                 maxLines: 8,
                  cursorColor: themewhitecolor,
                  style: const TextStyle(
                    color: themewhitecolor,
                  ), 
                  decoration: InputDecoration(
                     hintText: "Here you can describe the problem",
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
                 
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
