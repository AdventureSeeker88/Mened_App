import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mended/provider/auth_pro.dart';
import 'package:mended/utils/path.dart';
import 'package:provider/provider.dart';

class AddSupporterButton extends StatefulWidget {
  final String id;
  final List supporterList;
  const AddSupporterButton(
      {super.key, required this.id, required this.supporterList});

  @override
  State<AddSupporterButton> createState() => _AddSupporterButtonState();
}

class _AddSupporterButtonState extends State<AddSupporterButton> {
  bool check = false;
  @override
  void initState() {
    if (widget.supporterList.contains(FirebaseAuth.instance.currentUser!.uid)) {
      check = true;
    } else {
      check = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Provider.of<AuthPro>(context, listen: false)
            .addSupporter(check ? false : true, true, widget.id);
        setState(() {
          check ? check = false : check = true;
        });
      },
      icon: Image.asset(
        check ? Assets.addSupported : Assets.addSupporter,
      ),
    );
  }
}
