import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/widgets/custom_simple_rounded_button.dart';
class CalenderTab extends StatefulWidget {
  const CalenderTab({Key? key}) : super(key: key);

  @override
  State<CalenderTab> createState() => _CalenderTabState();
}

class _CalenderTabState extends State<CalenderTab> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themegreencolor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "07 September, 2023",
                style: TextStyle(
                  color: themegreycolor,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.separated(
                itemCount: 2,
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: themewhitecolor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            color: themelightgreenshade2color,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.calendar_today,
                            color: themewhitecolor,
                            size: 30,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Dr.Alejandra Vega",
                              style: TextStyle(
                                color: themelightgreencolor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: const [
                                Icon(
                                  CupertinoIcons.time,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("12.00 - 16.00"),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        CustomSimpleRoundedButton(
                          onTap: () {},
                          height: 40,
                          width: size.width / 100 * 22,
                          buttoncolor: themelightgreencolor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30),
                          child: const Text(
                            "Join",
                            style: TextStyle(
                              color: themelightgreencolor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 15,
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "08 September, 2023",
                style: TextStyle(
                  color: themegreycolor,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: themewhitecolor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: themelightgreenshade2color,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.calendar_today,
                        color: themewhitecolor,
                        size: 30,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Dr.Alejandra Vega",
                          style: TextStyle(
                            color: themelightgreencolor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: const [
                            Icon(
                              CupertinoIcons.time,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("12.00 - 16.00"),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    CustomSimpleRoundedButton(
                      onTap: () {},
                      height: 40,
                      width: size.width / 100 * 22,
                      buttoncolor: themelightgreencolor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30),
                      child: const Text(
                        "Join",
                        style: TextStyle(
                          color: themelightgreencolor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
