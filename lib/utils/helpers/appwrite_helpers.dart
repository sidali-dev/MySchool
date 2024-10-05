import 'package:appwrite/appwrite.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:myschool/utils/helpers/helper_functions.dart';

class AppwriteHelpers {
  static handleAppwriteExceptions(
      AppwriteException exception, BuildContext context) {
    switch (exception.code) {
      case 401:
        SHelperFunctions.showAwesomeSnackBar(
            title: "Unauthorized Access",
            content: exception.message!,
            contentType: ContentType.failure,
            context: context);
        break;

      case 403:
        SHelperFunctions.showAwesomeSnackBar(
            title: "Unauthorized Forbidden",
            content: exception.message!,
            contentType: ContentType.failure,
            context: context);
        break;

      case 404:
        SHelperFunctions.showAwesomeSnackBar(
            title: "User Not Found",
            content: exception.message!,
            contentType: ContentType.failure,
            context: context);
        break;

      case 409:
        SHelperFunctions.showAwesomeSnackBar(
            title: "User Already Created",
            content: exception.message!,
            contentType: ContentType.failure,
            context: context);
        break;

      case 411:
        SHelperFunctions.showAwesomeSnackBar(
            title: "Payload Too Large",
            content: exception.message!,
            contentType: ContentType.failure,
            context: context);
        break;

      case 429:
        SHelperFunctions.showAwesomeSnackBar(
            title: "Too Many Tries",
            content: exception.message!,
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
