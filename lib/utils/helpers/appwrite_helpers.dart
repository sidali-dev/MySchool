import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:myschool/utils/helpers/helper_functions.dart';

class AppwriteHelpers {
  static handleAppwriteExceptions(int exceptionCode, BuildContext context) {
    switch (exceptionCode) {
      case 401:
        SHelperFunctions.showAwesomeSnackBar(
            title: "Unauthorized Access",
            content: exceptionCode.toString(),
            contentType: ContentType.failure,
            context: context);
        break;

      case 403:
        SHelperFunctions.showAwesomeSnackBar(
            title: "Unauthorized Forbidden",
            content: exceptionCode.toString(),
            contentType: ContentType.failure,
            context: context);
        break;

      case 404:
        SHelperFunctions.showAwesomeSnackBar(
            title: "User Not Found",
            content: exceptionCode.toString(),
            contentType: ContentType.failure,
            context: context);
        break;

      case 409:
        SHelperFunctions.showAwesomeSnackBar(
            title: "User Already Created",
            content: exceptionCode.toString(),
            contentType: ContentType.failure,
            context: context);
        break;

      case 411:
        SHelperFunctions.showAwesomeSnackBar(
            title: "Payload Too Large",
            content: exceptionCode.toString(),
            contentType: ContentType.failure,
            context: context);
        break;

      case 429:
        SHelperFunctions.showAwesomeSnackBar(
            title: "Too Many Tries",
            content: exceptionCode.toString(),
            contentType: ContentType.failure,
            context: context);
        break;
      default:
        SHelperFunctions.showAwesomeSnackBar(
            title: "ERROR",
            content: "Something Went Wrong",
            contentType: ContentType.failure,
            context: context);
        break;
    }
  }

  static showSomethingWentWorng(BuildContext context) {
    SHelperFunctions.showAwesomeSnackBar(
        title: "Something Went Wrong",
        content: "Try again later",
        contentType: ContentType.failure,
        context: context);
  }
}
