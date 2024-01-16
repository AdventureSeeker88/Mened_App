import 'package:flutter/cupertino.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

ToastFuture customToast(msg, BuildContext context) {
  return showToast(msg, context: context, position: StyledToastPosition.center);
}
