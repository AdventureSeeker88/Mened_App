// import 'package:food_app/provider/dark_theme_provider.dart';
// import 'package:food_app/theme/colors.dart';
// import 'package:food_app/widgets/custom_rounded_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_credit_card/credit_card_brand.dart';
// import 'package:flutter_credit_card/flutter_credit_card.dart';
// import 'package:provider/provider.dart';

// class CustomCreditCard extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return CustomCreditCardState();
//   }
// }

// class CustomCreditCardState extends State<CustomCreditCard> {
//   String cardNumber = '';
//   String expiryDate = '';
//   String cardHolderName = '';
//   String cvvCode = '';
//   bool isCvvFocused = false;
//   bool useGlassMorphism = false;
//   bool useBackgroundImage = false;
//   OutlineInputBorder? border;
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     border = OutlineInputBorder(
//       borderSide: BorderSide(
//         color: Colors.grey.withOpacity(0.7),
//         width: 2.0,
//       ),
//     );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeChange = Provider.of<DarkThemeProvider>(context);
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         elevation: 0,
//         title: Text(
//           "Add New Card",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//       ),
//       bottomNavigationBar: Container(
//         height: 75,
//         decoration: BoxDecoration(),
//         child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: CustomRoundedButton(
//               buttonText: "Add",
//               onTap: () {
//                 if (formKey.currentState!.validate()) {
//                   print('valid!');
//                 } else {
//                   print('invalid!');
//                 }
//               },
//               buttoncolor: themeChange.darkTheme == true
//                   ? themegreycolor
//                   : themeChange.darkTheme == false
//                       ? themeblackcolor
//                       : Palette.themecolor,
//               buttontextcolor: themeChange.darkTheme == true
//                   ? themeblackcolor
//                   : themeChange.darkTheme == false
//                       ? Palette.themecolor
//                       : Palette.themecolor,
//               height: kMinInteractiveDimension,
//               width: MediaQuery.of(context).size.width * 0.85,
//             )),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           image: !useBackgroundImage
//               ? const DecorationImage(
//                   image: ExactAssetImage('assets/bg.png'),
//                   fit: BoxFit.fill,
//                 )
//               : null,
//         ),
//         child: SafeArea(
//           child: Column(
//             children: <Widget>[
//               const SizedBox(
//                 height: 20,
//               ),
//               CreditCardWidget(
//                 // glassmorphismConfig:
//                 //     useGlassMorphism ? Glassmorphism.defaultConfig() : null,
//                 cardNumber: cardNumber,
//                 expiryDate: expiryDate,
//                 cardHolderName: cardHolderName,
//                 cvvCode: cvvCode,
//                 bankName: 'Any Bank',
//                 showBackView: isCvvFocused,
//                 obscureCardNumber: true,
//                 obscureCardCvv: true,
//                 isHolderNameVisible: true,
//                 cardBgColor: themeChange.darkTheme == true
//                     ? themegreycolor
//                     : themeChange.darkTheme == false
//                         ? themeblackcolor
//                         : Palette.themecolor,
//                 backgroundImage: useBackgroundImage
//                     ? "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Mastercard_2019_logo.svg/1200px-Mastercard_2019_logo.svg.png"
//                     : null,
//                 isSwipeGestureEnabled: true,
//                 onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
//                 customCardTypeIcons: <CustomCardTypeIcon>[
//                   CustomCardTypeIcon(
//                       cardType: CardType.mastercard,
//                       cardImage: Image.network(
//                           "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Mastercard_2019_logo.svg/1200px-Mastercard_2019_logo.svg.png")),
//                 ],
//               ),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: <Widget>[
//                       CreditCardForm(
//                         formKey: formKey,
//                         obscureCvv: true,
//                         obscureNumber: true,
//                         cardNumber: cardNumber,
//                         cvvCode: cvvCode,
//                         isHolderNameVisible: true,
//                         isCardNumberVisible: true,
//                         isExpiryDateVisible: true,
//                         cardHolderName: cardHolderName,
//                         expiryDate: expiryDate,
//                         themeColor: Colors.blue,
//                         textColor: themeChange.darkTheme == true
//                             ? themegreycolor
//                             : themeChange.darkTheme == false
//                                 ? themeblackcolor
//                                 : Palette.themecolor,
//                         cardNumberDecoration: InputDecoration(
//                           labelText: 'Card Number',
//                           hintText: 'XXXX XXXX XXXX XXXX',
//                           hintStyle: TextStyle(
//                             color: themeChange.darkTheme == true
//                                 ? themegreycolor
//                                 : themeChange.darkTheme == false
//                                     ? themeblackcolor
//                                     : Palette.themecolor,
//                           ),
//                           labelStyle: TextStyle(
//                             color: themeChange.darkTheme == true
//                                 ? themegreycolor
//                                 : themeChange.darkTheme == false
//                                     ? themeblackcolor
//                                     : Palette.themecolor,
//                           ),
//                           focusedBorder: border,
//                           enabledBorder: border,
//                         ),
//                         expiryDateDecoration: InputDecoration(
//                           hintStyle: TextStyle(
//                             color: themeChange.darkTheme == true
//                                 ? themegreycolor
//                                 : themeChange.darkTheme == false
//                                     ? themeblackcolor
//                                     : Palette.themecolor,
//                           ),
//                           labelStyle: TextStyle(
//                             color: themeChange.darkTheme == true
//                                 ? themegreycolor
//                                 : themeChange.darkTheme == false
//                                     ? themeblackcolor
//                                     : Palette.themecolor,
//                           ),
//                           focusedBorder: border,
//                           enabledBorder: border,
//                           labelText: 'Expired Date',
//                           hintText: 'XX/XX',
//                         ),
//                         cvvCodeDecoration: InputDecoration(
//                           hintStyle: TextStyle(
//                             color: themeChange.darkTheme == true
//                                 ? themegreycolor
//                                 : themeChange.darkTheme == false
//                                     ? themeblackcolor
//                                     : Palette.themecolor,
//                           ),
//                           labelStyle: TextStyle(
//                             color: themeChange.darkTheme == true
//                                 ? themegreycolor
//                                 : themeChange.darkTheme == false
//                                     ? themeblackcolor
//                                     : Palette.themecolor,
//                           ),
//                           focusedBorder: border,
//                           enabledBorder: border,
//                           labelText: 'CVV',
//                           hintText: 'XXX',
//                         ),
//                         cardHolderDecoration: InputDecoration(
//                           hintStyle: TextStyle(
//                             color: themeChange.darkTheme == true
//                                 ? themegreycolor
//                                 : themeChange.darkTheme == false
//                                     ? themeblackcolor
//                                     : Palette.themecolor,
//                           ),
//                           labelStyle: TextStyle(
//                             color: themeChange.darkTheme == true
//                                 ? themegreycolor
//                                 : themeChange.darkTheme == false
//                                     ? themeblackcolor
//                                     : Palette.themecolor,
//                           ),
//                           focusedBorder: border,
//                           enabledBorder: border,
//                           labelText: 'Card Holder',
//                         ),
//                         onCreditCardModelChange: onCreditCardModelChange,
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       // Row(
//                       //   mainAxisAlignment: MainAxisAlignment.center,
//                       //   children: <Widget>[
//                       //     const Text(
//                       //       'Glassmorphism',
//                       //       style: TextStyle(
//                       //         color: themeblackcolor,
//                       //         fontSize: 18,
//                       //       ),
//                       //     ),
//                       //     Switch(
//                       //       value: useGlassMorphism,
//                       //       inactiveTrackColor: Colors.grey,
//                       //       activeColor: Colors.white,
//                       //       activeTrackColor: Colors.green,
//                       //       onChanged: (bool value) => setState(() {
//                       //         useGlassMorphism = value;
//                       //       }),
//                       //     ),
//                       //   ],
//                       // ),
//                       // Row(
//                       //   mainAxisAlignment: MainAxisAlignment.center,
//                       //   children: <Widget>[
//                       //     const Text(
//                       //       'Card Image',
//                       //       style: TextStyle(
//                       //         color: Colors.white,
//                       //         fontSize: 18,
//                       //       ),
//                       //     ),
//                       //     Switch(
//                       //       value: useBackgroundImage,
//                       //       inactiveTrackColor: Colors.grey,
//                       //       activeColor: Colors.white,
//                       //       activeTrackColor: Colors.green,
//                       //       onChanged: (bool value) => setState(() {
//                       //         useBackgroundImage = value;
//                       //       }),
//                       //     ),
//                       //   ],
//                       // ),
//                       // const SizedBox(
//                       //   height: 20,
//                       // ),
//                       // ElevatedButton(
//                       //   style: ElevatedButton.styleFrom(
//                       //     shape: RoundedRectangleBorder(
//                       //       borderRadius: BorderRadius.circular(8.0),
//                       //     ),
//                       //   ),
//                       //   child: Container(
//                       //     margin: const EdgeInsets.all(12),
//                       //     child: const Text(
//                       //       'Validate',
//                       //       style: TextStyle(
//                       //         color: Colors.white,
//                       //         fontFamily: 'halter',
//                       //         fontSize: 14,
//                       //         package: 'flutter_credit_card',
//                       //       ),
//                       //     ),
//                       //   ),
//                       //   onPressed: () {
//                       //     if (formKey.currentState!.validate()) {
//                       //       print('valid!');
//                       //     } else {
//                       //       print('invalid!');
//                       //     }
//                       //   },
//                       // ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void onCreditCardModelChange(CreditCardModel? creditCardModel) {
//     setState(() {
//       cardNumber = creditCardModel!.cardNumber;
//       expiryDate = creditCardModel.expiryDate;
//       cardHolderName = creditCardModel.cardHolderName;
//       cvvCode = creditCardModel.cvvCode;
//       isCvvFocused = creditCardModel.isCvvFocused;
//     });
//   }
// }
