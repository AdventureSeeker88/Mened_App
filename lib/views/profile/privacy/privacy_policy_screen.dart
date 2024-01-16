import 'package:flutter/material.dart';
import 'package:mended/theme/colors.dart';
import 'package:mended/widgets/custom_icon_button.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themegreencolor, // backgroundColor: themelightgreycolor,
      // appBar: AppBar(
      //   backgroundColor: Palette.themecolor,
      //   elevation: 0,
      //   title: const Text(
      //     "Privacy Policy",
      //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      //   ),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomIconButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: themewhitecolor,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Privacy Policy",
                  style: TextStyle(
                    color: themewhitecolor,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ut arcu semper, vestibulum lacus sed, aliquet nisi. Cras eget tellus ut risus sagittis volutpat. Phasellus eget lorem tortor. Ut convallis, nibh in auctor varius, quam velit elementum massa, vel venenatis lorem odio et mi. Integer vel dictum justo. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque quis dictum lacus. In hac habitasse platea dictumst. Etiam consectetur posuere leo, in feugiat risus malesuada id.\n\nSed id fringilla lorem, vitae iaculis libero. Integer diam erat, finibus eu dui quis, fermentum pellentesque urna. Nam at semper sem, eget volutpat libero. Nam blandit eros sit amet hendrerit cursus. Sed convallis purus non neque luctus fringilla. Phasellus a arcu rhoncus diam hendrerit mollis et lobortis augue. Quisque eget aliquam dui. Integer cursus, mi in bibendum interdum, erat felis lobortis nunc, nec posuere neque diam id ipsum. Curabitur aliquet vitae ipsum non placerat. Maecenas lacus lectus, lacinia et sagittis aliquet, iaculis non metus. Curabitur sapien libero, ultricies id lacinia in, malesuada et tellus.\n\nNam sollicitudin tristique nunc a condimentum. Sed tincidunt, mauris a facilisis scelerisque, ipsum risus ultricies dui, vitae ullamcorper dui augue eu orci. Mauris in malesuada odio. Aliquam erat volutpat. Sed vulputate vestibulum gravida. Vivamus iaculis massa a augue tincidunt laoreet facilisis convallis mi. Cras cursus metus a elit sollicitudin, finibus laoreet turpis auctor. Suspendisse potenti. Phasellus sapien tortor, aliquet in dui a, ultricies efficitur lacus. Etiam congue est dui, ut sollicitudin quam tristique nec. Quisque vitae placerat augue. Aliquam pellentesque justo ante.\n\nFusce faucibus placerat dapibus. Etiam vel lobortis eros. Nulla congue libero odio, eget fermentum velit sagittis non. Curabitur tincidunt egestas purus, quis mollis arcu dignissim at. Pellentesque diam justo, auctor a velit non, aliquam mollis nisi. Ut viverra urna eu elit efficitur maximus. Sed accumsan a enim a ullamcorper. Mauris et dui urna. Mauris elementum arcu mattis, commodo elit id, blandit tellus. Donec risus ligula, ullamcorper eu tellus nec, commodo interdum augue. Fusce gravida vitae tellus vitae dignissim. Donec ut dolor sem. In in erat non diam hendrerit fermentum non nec erat.\n\nNulla ultrices malesuada lacus, a congue massa venenatis ut. Fusce vel aliquet velit, ac dignissim mauris. Proin iaculis vel odio sed ullamcorper. Integer luctus ipsum vel scelerisque lobortis. Donec faucibus eget ante sit amet lacinia. Duis vitae dapibus risus. Etiam eu felis at sapien imperdiet euismod. Nunc et viverra sapien. Mauris dictum ornare augue, in dictum odio finibus a. Curabitur volutpat eget ex sed venenatis. Curabitur ac nibh dapibus, pellentesque diam eget, egestas leo. Quisque egestas vitae diam semper condimentum. Sed eu gravida urna, vitae volutpat lectus. Ut eu odio aliquet, bibendum lorem quis, vestibulum libero.",
                  style: TextStyle(
                    fontSize: 16,
                    color: themewhitecolor,
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
