import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mended/helper/pick_image.dart';
import 'package:mended/helper/storage_methods.dart';
import 'package:mended/model/auth_model.dart';
import 'package:mended/model/rating_model.dart';
import 'package:mended/model/transfer_coin.dart';
import 'package:mended/route/go_router.dart';
import 'package:mended/route/navigator.dart';
import 'package:mended/utils/database.dart';
import 'package:mended/widgets/dailog.dart';
import 'package:mended/widgets/toast.dart';
import 'package:uuid/uuid.dart';

class AuthPro with ChangeNotifier {
  //type = 0 : Mended
  //type = 1 : Mender
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  void loginFun(email, password, BuildContext context) async {
    String errorMessage = "";
    showCircularLoadDialog(context);
    bool exits = await firestore
        .collection(Database.auth)
        .where('email', isEqualTo: email)
        .where('type', isEqualTo: 0)
        .get()
        .then((value) {
      return value.docs.isEmpty ? false : true;
    });

    if (exits) {
      try {
        await auth.signInWithEmailAndPassword(
            email: email.toString(), password: password.toString());
       
        // ignore: use_build_context_synchronously
        log("sign in");
        Navigator.pop(context);
        Go.namedreplace(
          context,
          Routes.onboarding,
        );
        //  await getmyData();
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "ERROR_INVALID_EMAIL":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "ERROR_USER_NOT_FOUND":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "ERROR_USER_DISABLED":
            errorMessage = "User with this email has been disabled.";
            break;
          case "email-already-in-use":
            errorMessage = "This Email is Already Taken.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests. Try again later.";
            break;

          case "ERROR_OPERATION_NOT_ALLOWED":
            errorMessage = "Signing in with Email and Password is not enabled.";

            break;
          case "INVALID_LOGIN_CREDENTIALS":
            errorMessage = "Signing in with Email and Password is not valid.";

            break;

          default:
            errorMessage = "An undefined Error happened.";
        }
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        customToast(errorMessage, context);
      }
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      customToast("These Account Doesn't Exist", context);
    }
  }

  void signupFun(String name, String email, String password, String category,
      BuildContext context) async {
    String errorMessage = "";
    try {
      showCircularLoadDialog(context);
      UserCredential cred = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      AuthM model = AuthM(
        uid: cred.user!.uid,
        chargeCoins: 1,
        image: "",
        name: name,
        bio: "I am using Mended",
        aboutDoctor: "",
        email: email,
        dateTime: Timestamp.now(),
        type: 0,
        buddyList: [],
        supporterList: [],
        blockList: [],
        views: 0,
        category: [category],
        token: "",
        status: 0,
        onlineStatus: "Online",
        coin: 0,
      );
      await firestore
          .collection(Database.auth)
          .doc(
            cred.user!.uid,
          )
          .set(model.toJson())
          .then((value) async {
        // getmyData();
         Navigator.pop(context);
        Go.namedreplace(
          context,
          Routes.onboarding,
        );
      });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "email-already-in-use":
          errorMessage = "This Email is Already Taken.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Navigator.pop(context);
      customToast(errorMessage, context);
    }
  }

  Map myUserdata = {};
  getmyData() async {
    await firestore
        .collection(Database.auth)
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) {
      myUserdata = value.data() ?? {};
      debugPrint(myUserdata.toString());
      notifyListeners();
    });
    notifyListeners();
  }

  updatetoken(token) {
    firestore
        .collection('auth')
        .doc(auth.currentUser!.uid)
        .update({'token': token});
  }

  Future<AuthM> getUserById(id) async {
      
    return await firestore
        .collection(Database.auth)
        .doc(id)
        .get()
        .then((value) {
      AuthM result = AuthM.fromSnap(value);
       
      return result;
    });
  }

  updateAuth(id, json) async {
    await firestore.collection(Database.auth).doc(id).update(json);
  }

  void addBuddy(bool add, bool notify, id) async {
    await updateAuth(auth.currentUser!.uid, {
      'buddyList': add == true
          ? FieldValue.arrayUnion([id])
          : FieldValue.arrayRemove([id]),
    });
    getmyData();
  }

  void addSupporter(bool add, bool notify, id) async {
    await updateAuth(id, {
      'supporterList': add == true
          ? FieldValue.arrayUnion([auth.currentUser!.uid])
          : FieldValue.arrayRemove([auth.currentUser!.uid]),
    });
    getmyData();
  }

  void blockUser(bool add, id) async {
    await updateAuth(auth.currentUser!.uid, {
      'blockList': add == true
          ? FieldValue.arrayUnion([id])
          : FieldValue.arrayRemove([id]),
    });
    getmyData();
  }

  Stream<List<AuthM>> get_my_profile(uid) => FirebaseFirestore.instance
      .collection('auth')
      .where("uid", isEqualTo: uid)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((document) => AuthM.fromJson(document.data()))
          .toList());

  Uint8List? selectProfileImage;
  Future selectProfileImageFunc() async {
    try {
      Uint8List file;
      file = await pickImage(ImageSource.gallery);

      selectProfileImage = file;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  updateAuthUserImage(id, Uint8List image) async {
    String url = await StorageMethods()
        .uploadImageToStoragee('mended/profiles/', image, true);
    await updateAuth(id, {'image': url});
  }

  profileUpdate(name, bio, Uint8List? image, id, context) async {
    showCircularLoadDialog(context);
    if (image != null) {
      await updateAuthUserImage(
        id,
        image,
      );
    }
    await updateAuth(id, {
      'name': name,
      'bio': bio,
    });
    Navigator.pop(context);
    Navigator.pop(context);
    customToast("Update Your Profile Successfully", context);
  }

  userChangePasswordFunc(oldPassword, newPassword, BuildContext context) async {
    try {
      showCircularLoadDialog(context);

      await firestore
          .collection(Database.auth)
          .doc(auth.currentUser!.uid)
          .get()
          .then((value) async {
        if (value.exists) {
          final mendedEmail = value.data()!["email"].toString();
          log("mendedEmail: $mendedEmail");

          var cred = EmailAuthProvider.credential(
              email: mendedEmail, password: oldPassword);
          await auth.currentUser!
              .reauthenticateWithCredential(cred)
              .then((value) {
            debugPrint("Value >>>> $value");

            auth.currentUser!.updatePassword(newPassword).then((value) async {
              await auth.signOut();
              context.replaceNamed("splash");
            });
          }).catchError((error) {
            Navigator.pop(context);
            customToast("Please Enter your correct Old Password", context);
          });
        }
      });
    } catch (e) {
      debugPrint("Catch Exception: $e");
    }
  }

  Future<bool> detacTransferCoin(int coin, id, context) async {
    int get = await FirebaseFirestore.instance
        .collection("auth")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      return value['coin'];
    });
    log(coin.toString());
    log(get.toString());
    var docId = const Uuid().v4();
    // firestore.collection(Database.transferCoin).doc(docId).set(
    //       TransferCoinM(
    //         id: docId,
    //         coin: coin,
    //         status: 0,
    //         dateTime: Timestamp.now(),
    //         transferBy: "user",
    //         transferId: FirebaseAuth.instance.currentUser!.uid,
    //         receiverId: id,
    //       ).toJson(),
    //     );
    if (coin <= get) {
      FirebaseFirestore.instance
          .collection("auth")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'coin': FieldValue.increment(-coin)});
      FirebaseFirestore.instance
          .collection("auth")
          .doc(id)
          .update({'coin': FieldValue.increment(coin)});
      return true;
    } else {
      customToast("Invalid Coins", context);

      return false;
    }
  }

  ratingFun(double rating, receiverId, context) async {
    var id = const Uuid().v4();
    return await firestore
        .collection(Database.rating)
        .doc(id)
        .set(
          RatingModel(
            id: id,
            senderId: auth.currentUser!.uid,
            rating: rating,
            receiverId: receiverId,
            title: "",
            status: 0,
            dateTime: Timestamp.now(),
          ).toJson(),
        )
        .then((value) {
      return true;
    }).onError((error, stackTrace) {
      customToast(error.toString(), context);
      return false;
    });
  }

  void forgotPassword(email, context) async {
    try {
      showCircularLoadDialog(context);
      firestore
          .collection(Database.auth)
          .where('email', isEqualTo: email)
          .where('type', isEqualTo: 0)
          .get()
          .then(
        (value) async {
          if (value.docs.isNotEmpty) {
            await auth.sendPasswordResetEmail(
              email: email,
            );
            Navigator.pop(context);

            successfullyDailog(context,
                "The Password Recovery mail has been sent to your email");
          } else {
            Navigator.pop(context);
            customToast("There isn't any user with this email adress", context);
          }
        },
      );
    } catch (e) {
      debugPrint("Catch Exception: $e");
    }
  }

  createCleint() {
    // firestore.collection(Database.cleint).doc(auth.currentUser!.uid).collection(Database.
  }
}
