import 'package:flutter/material.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/widgets/custom_icon_button.dart';
import 'package:mended/widgets/custom_simple_rounded_button.dart';
class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themegreencolor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomSimpleRoundedButton(
          onTap: () {
         
          },
          height: 45,
          width: double.infinity,
          buttoncolor: Palette.themecolor,
          borderRadius: BorderRadius.circular(5),
          child: Text(
            "Ask".toUpperCase(),
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
                      "Help",
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
                const Text(
                  "How can we help you?",
                  style: TextStyle(
                    color: themegreytextcolor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 150,
                      width: size.width / 100 * 40,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Palette.themecolor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: themewhitecolor,
                            child: Icon(
                              Icons.format_quote,
                              color: Palette.themecolor,
                              size: 32,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Faq's",
                            style: TextStyle(
                              color: themewhitecolor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 150,
                      width: size.width / 100 * 40,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Palette.themecolor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: themewhitecolor,
                            child: Icon(
                              Icons.support_agent,
                              color: Palette.themecolor,
                              size: 32,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Support",
                            style: TextStyle(
                              color: themewhitecolor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Ask for help",
                  style: TextStyle(
                    color: themewhitecolor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        style: const TextStyle(color: themewhitecolor),
                        decoration: InputDecoration(
                          hintText: "Name",
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
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: const TextStyle(color: themewhitecolor),
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
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  style: const TextStyle(color: themewhitecolor),
                  decoration: InputDecoration(
                    hintText: "Subject",
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
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  style: const TextStyle(color: themewhitecolor),
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "How can we help you?",
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
                // Center(
                //   child: CustomOutlinedButton(
                //     onTap: () {},
                //     height: 45,
                //     width: 200,
                //     borderRadius: BorderRadius.circular(5),
                //     borderColor: themewhitecolor,
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         const Icon(
                //           Icons.add,
                //           color: themewhitecolor,
                //         ),
                //         const SizedBox(
                //           width: 10,
                //         ),
                //         Text(
                //           "Add a Photo".toUpperCase(),
                //           style: const TextStyle(
                //             color: themewhitecolor,
                //             fontSize: 14,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 50,
                // ),
                // const Text(
                //   "Comments",
                //   style: TextStyle(
                //     color: themewhitecolor,
                //     fontSize: 18,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                // TextFormField(
                
                //   maxLines: 8,
                //   decoration: InputDecoration(
                //     hintText: "Here you can describe the problem",
                //     hintStyle: const TextStyle(
                //       color: themegreycolor,
                //     ),
                //     filled: true,
                //     fillColor: themegreycolor.withOpacity(0.4),
                //     enabledBorder: OutlineInputBorder(
                //       borderSide: const BorderSide(
                //         color: themewhitecolor,
                //       ),
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderSide: const BorderSide(
                //         color: themewhitecolor,
                //       ),
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //     contentPadding: const EdgeInsets.all(12),
                //   ),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                // const Text(
                //   "Your privacy is important to us. It is Brainstorming's policy to respect your privacy regarding any information we may collect from you across our website, and other sites we own and operate.\n\nWe only ask for personal information when we truly need it to provide a service to you. We collect it by fair and lawful means, with your knowledge and consent. We also let you know why we’re collecting it and how it will be used.\n\nWe only retain collected information for as long as necessary to provide you with your requested service. ",
                //   textAlign: TextAlign.center,
                //   style: TextStyle(color: themegreytextcolor, fontSize: 16),
                // ),
                // const SizedBox(
                //   height: 40,
                // ),
                // Center(
                //   child: CustomTextButton(
                //     buttonText: "Terms & Conditions",
                //     onTap: () {},
                //     textstyle: const TextStyle(
                //       color: Palette.themecolor,
                //       fontSize: 18,
                //       // fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 25,
                // ),
                // Center(
                //   child: CustomTextButton(
                //     buttonText: "Privacy Policy",
                //     onTap: () {},
                //     textstyle: const TextStyle(
                //       color: Palette.themecolor,
                //       fontSize: 18,
                //       // fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
