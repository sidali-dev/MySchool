// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sign up`
  String get sign_up {
    return Intl.message(
      'Sign up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Level`
  String get level {
    return Intl.message(
      'Level',
      name: 'level',
      desc: '',
      args: [],
    );
  }

  /// `Please selece a branch`
  String get select_a_branch {
    return Intl.message(
      'Please selece a branch',
      name: 'select_a_branch',
      desc: '',
      args: [],
    );
  }

  /// `Pick Your Branch`
  String get pick_your_branch {
    return Intl.message(
      'Pick Your Branch',
      name: 'pick_your_branch',
      desc: '',
      args: [],
    );
  }

  /// `FINISH`
  String get finish {
    return Intl.message(
      'FINISH',
      name: 'finish',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Something?`
  String get forgot_something {
    return Intl.message(
      'Forgot Something?',
      name: 'forgot_something',
      desc: '',
      args: [],
    );
  }

  /// `GO BACK`
  String get go_back {
    return Intl.message(
      'GO BACK',
      name: 'go_back',
      desc: '',
      args: [],
    );
  }

  /// `About You`
  String get about_you {
    return Intl.message(
      'About You',
      name: 'about_you',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get full_name {
    return Intl.message(
      'Full Name',
      name: 'full_name',
      desc: '',
      args: [],
    );
  }

  /// `New User`
  String get new_user {
    return Intl.message(
      'New User',
      name: 'new_user',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name`
  String get enter_your_name {
    return Intl.message(
      'Please enter your name',
      name: 'enter_your_name',
      desc: '',
      args: [],
    );
  }

  /// `Name should only contain letters`
  String get name_only_contains_letters {
    return Intl.message(
      'Name should only contain letters',
      name: 'name_only_contains_letters',
      desc: '',
      args: [],
    );
  }

  /// `Name is too short`
  String get name_is_short {
    return Intl.message(
      'Name is too short',
      name: 'name_is_short',
      desc: '',
      args: [],
    );
  }

  /// `Name is too long`
  String get name_is_long {
    return Intl.message(
      'Name is too long',
      name: 'name_is_long',
      desc: '',
      args: [],
    );
  }

  /// `Please select a level`
  String get select_a_level {
    return Intl.message(
      'Please select a level',
      name: 'select_a_level',
      desc: '',
      args: [],
    );
  }

  /// `Pick Your Level`
  String get pick_your_level {
    return Intl.message(
      'Pick Your Level',
      name: 'pick_your_level',
      desc: '',
      args: [],
    );
  }

  /// `NEXT`
  String get next {
    return Intl.message(
      'NEXT',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Already Have an Account?`
  String get have_an_account {
    return Intl.message(
      'Already Have an Account?',
      name: 'have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `SIGN IN`
  String get sign_in {
    return Intl.message(
      'SIGN IN',
      name: 'sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get enter_email {
    return Intl.message(
      'Please enter your email',
      name: 'enter_email',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get valid_email {
    return Intl.message(
      'Please enter a valid email',
      name: 'valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get enter_password {
    return Intl.message(
      'Please enter your password',
      name: 'enter_password',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters`
  String get password_at_least_8 {
    return Intl.message(
      'Password must be at least 8 characters',
      name: 'password_at_least_8',
      desc: '',
      args: [],
    );
  }

  /// `New Here?`
  String get new_here {
    return Intl.message(
      'New Here?',
      name: 'new_here',
      desc: '',
      args: [],
    );
  }

  /// `Pick a Trimester`
  String get pick_trimester {
    return Intl.message(
      'Pick a Trimester',
      name: 'pick_trimester',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `What are we learning today?`
  String get learning_today {
    return Intl.message(
      'What are we learning today?',
      name: 'learning_today',
      desc: '',
      args: [],
    );
  }

  /// `START LEARNING !`
  String get start_learning {
    return Intl.message(
      'START LEARNING !',
      name: 'start_learning',
      desc: '',
      args: [],
    );
  }

  /// `Accounting`
  String get accounting {
    return Intl.message(
      'Accounting',
      name: 'accounting',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `Civil`
  String get civil {
    return Intl.message(
      'Civil',
      name: 'civil',
      desc: '',
      args: [],
    );
  }

  /// `Civil Engineering`
  String get civil_engineering {
    return Intl.message(
      'Civil Engineering',
      name: 'civil_engineering',
      desc: '',
      args: [],
    );
  }

  /// `Computer Science`
  String get computer_science {
    return Intl.message(
      'Computer Science',
      name: 'computer_science',
      desc: '',
      args: [],
    );
  }

  /// `Economy`
  String get economy {
    return Intl.message(
      'Economy',
      name: 'economy',
      desc: '',
      args: [],
    );
  }

  /// `Electrical Engineering`
  String get electrical_engineering {
    return Intl.message(
      'Electrical Engineering',
      name: 'electrical_engineering',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `French`
  String get french {
    return Intl.message(
      'French',
      name: 'french',
      desc: '',
      args: [],
    );
  }

  /// `Geography`
  String get geography {
    return Intl.message(
      'Geography',
      name: 'geography',
      desc: '',
      args: [],
    );
  }

  /// `German`
  String get german {
    return Intl.message(
      'German',
      name: 'german',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Italian`
  String get italian {
    return Intl.message(
      'Italian',
      name: 'italian',
      desc: '',
      args: [],
    );
  }

  /// `Law`
  String get law {
    return Intl.message(
      'Law',
      name: 'law',
      desc: '',
      args: [],
    );
  }

  /// `Maths`
  String get maths {
    return Intl.message(
      'Maths',
      name: 'maths',
      desc: '',
      args: [],
    );
  }

  /// `Mechanical Engineering`
  String get mechanical_engineering {
    return Intl.message(
      'Mechanical Engineering',
      name: 'mechanical_engineering',
      desc: '',
      args: [],
    );
  }

  /// `Philosophy`
  String get philosophy {
    return Intl.message(
      'Philosophy',
      name: 'philosophy',
      desc: '',
      args: [],
    );
  }

  /// `Physics`
  String get physics {
    return Intl.message(
      'Physics',
      name: 'physics',
      desc: '',
      args: [],
    );
  }

  /// `Process Engineering`
  String get process_engineering {
    return Intl.message(
      'Process Engineering',
      name: 'process_engineering',
      desc: '',
      args: [],
    );
  }

  /// `Science`
  String get science {
    return Intl.message(
      'Science',
      name: 'science',
      desc: '',
      args: [],
    );
  }

  /// `Shariaa`
  String get shariaa {
    return Intl.message(
      'Shariaa',
      name: 'shariaa',
      desc: '',
      args: [],
    );
  }

  /// `Spanish`
  String get spanish {
    return Intl.message(
      'Spanish',
      name: 'spanish',
      desc: '',
      args: [],
    );
  }

  /// `Technology`
  String get technology {
    return Intl.message(
      'Technology',
      name: 'technology',
      desc: '',
      args: [],
    );
  }

  /// `Exams`
  String get exams {
    return Intl.message(
      'Exams',
      name: 'exams',
      desc: '',
      args: [],
    );
  }

  /// `Exercises`
  String get exercises {
    return Intl.message(
      'Exercises',
      name: 'exercises',
      desc: '',
      args: [],
    );
  }

  /// `Finals`
  String get finals {
    return Intl.message(
      'Finals',
      name: 'finals',
      desc: '',
      args: [],
    );
  }

  /// `Lessons`
  String get lessons {
    return Intl.message(
      'Lessons',
      name: 'lessons',
      desc: '',
      args: [],
    );
  }

  /// `School Book`
  String get school_book {
    return Intl.message(
      'School Book',
      name: 'school_book',
      desc: '',
      args: [],
    );
  }

  /// `Videos`
  String get videos {
    return Intl.message(
      'Videos',
      name: 'videos',
      desc: '',
      args: [],
    );
  }

  /// `Literature`
  String get literature {
    return Intl.message(
      'Literature',
      name: 'literature',
      desc: '',
      args: [],
    );
  }

  /// `Scientific`
  String get scientific {
    return Intl.message(
      'Scientific',
      name: 'scientific',
      desc: '',
      args: [],
    );
  }

  /// `Foreign Languages`
  String get languages {
    return Intl.message(
      'Foreign Languages',
      name: 'languages',
      desc: '',
      args: [],
    );
  }

  /// `Literature & Philosophy`
  String get philosophy_branch {
    return Intl.message(
      'Literature & Philosophy',
      name: 'philosophy_branch',
      desc: '',
      args: [],
    );
  }

  /// `Management and Economics`
  String get management {
    return Intl.message(
      'Management and Economics',
      name: 'management',
      desc: '',
      args: [],
    );
  }

  /// `Technical Maths`
  String get math_technique {
    return Intl.message(
      'Technical Maths',
      name: 'math_technique',
      desc: '',
      args: [],
    );
  }

  /// `1 Primary School`
  String get ap1 {
    return Intl.message(
      '1 Primary School',
      name: 'ap1',
      desc: '',
      args: [],
    );
  }

  /// `2 Primary School`
  String get ap2 {
    return Intl.message(
      '2 Primary School',
      name: 'ap2',
      desc: '',
      args: [],
    );
  }

  /// `3 Primary School`
  String get ap3 {
    return Intl.message(
      '3 Primary School',
      name: 'ap3',
      desc: '',
      args: [],
    );
  }

  /// `4 Primary School`
  String get ap4 {
    return Intl.message(
      '4 Primary School',
      name: 'ap4',
      desc: '',
      args: [],
    );
  }

  /// `5 Primary School`
  String get ap5 {
    return Intl.message(
      '5 Primary School',
      name: 'ap5',
      desc: '',
      args: [],
    );
  }

  /// `1 Middle School`
  String get cem1 {
    return Intl.message(
      '1 Middle School',
      name: 'cem1',
      desc: '',
      args: [],
    );
  }

  /// `2 Middle School`
  String get cem2 {
    return Intl.message(
      '2 Middle School',
      name: 'cem2',
      desc: '',
      args: [],
    );
  }

  /// `3 Middle School`
  String get cem3 {
    return Intl.message(
      '3 Middle School',
      name: 'cem3',
      desc: '',
      args: [],
    );
  }

  /// `4 Middle School`
  String get cem4 {
    return Intl.message(
      '4 Middle School',
      name: 'cem4',
      desc: '',
      args: [],
    );
  }

  /// `1 High School`
  String get lycee1 {
    return Intl.message(
      '1 High School',
      name: 'lycee1',
      desc: '',
      args: [],
    );
  }

  /// `2 High School`
  String get lycee2 {
    return Intl.message(
      '2 High School',
      name: 'lycee2',
      desc: '',
      args: [],
    );
  }

  /// `3 High School`
  String get lycee3 {
    return Intl.message(
      '3 High School',
      name: 'lycee3',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Pick a level`
  String get pick_a_level {
    return Intl.message(
      'Pick a level',
      name: 'pick_a_level',
      desc: '',
      args: [],
    );
  }

  /// `UPDATE LEVEL`
  String get update_level {
    return Intl.message(
      'UPDATE LEVEL',
      name: 'update_level',
      desc: '',
      args: [],
    );
  }

  /// `Pick a branch`
  String get pick_branch {
    return Intl.message(
      'Pick a branch',
      name: 'pick_branch',
      desc: '',
      args: [],
    );
  }

  /// `UPDATE BRANCH`
  String get update_branch {
    return Intl.message(
      'UPDATE BRANCH',
      name: 'update_branch',
      desc: '',
      args: [],
    );
  }

  /// `Branch`
  String get branch {
    return Intl.message(
      'Branch',
      name: 'branch',
      desc: '',
      args: [],
    );
  }

  /// `Prefernces`
  String get prefernces {
    return Intl.message(
      'Prefernces',
      name: 'prefernces',
      desc: '',
      args: [],
    );
  }

  /// `Languages`
  String get language {
    return Intl.message(
      'Languages',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get dark_mode {
    return Intl.message(
      'Dark Mode',
      name: 'dark_mode',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get log_out {
    return Intl.message(
      'Log out',
      name: 'log_out',
      desc: '',
      args: [],
    );
  }

  /// `What will you be sharing today?`
  String get what_are_you_sharing {
    return Intl.message(
      'What will you be sharing today?',
      name: 'what_are_you_sharing',
      desc: '',
      args: [],
    );
  }

  /// `UPLOAD A NEW LESSON`
  String get uploads_new_lesson {
    return Intl.message(
      'UPLOAD A NEW LESSON',
      name: 'uploads_new_lesson',
      desc: '',
      args: [],
    );
  }

  /// `LESSON`
  String get lesson {
    return Intl.message(
      'LESSON',
      name: 'lesson',
      desc: '',
      args: [],
    );
  }

  /// `UPLOAD A NEW EXERCISE`
  String get upload_new_exercise {
    return Intl.message(
      'UPLOAD A NEW EXERCISE',
      name: 'upload_new_exercise',
      desc: '',
      args: [],
    );
  }

  /// `EXERCISE`
  String get exercise {
    return Intl.message(
      'EXERCISE',
      name: 'exercise',
      desc: '',
      args: [],
    );
  }

  /// `UPLOAD A NEW EXAM`
  String get upload_new_exam {
    return Intl.message(
      'UPLOAD A NEW EXAM',
      name: 'upload_new_exam',
      desc: '',
      args: [],
    );
  }

  /// `EXAM`
  String get exam {
    return Intl.message(
      'EXAM',
      name: 'exam',
      desc: '',
      args: [],
    );
  }

  /// `UPLOAD A NEW VIDEO`
  String get upload_new_video {
    return Intl.message(
      'UPLOAD A NEW VIDEO',
      name: 'upload_new_video',
      desc: '',
      args: [],
    );
  }

  /// `VIDEO`
  String get video {
    return Intl.message(
      'VIDEO',
      name: 'video',
      desc: '',
      args: [],
    );
  }

  /// `Trimester`
  String get trimester {
    return Intl.message(
      'Trimester',
      name: 'trimester',
      desc: '',
      args: [],
    );
  }

  /// `CHOOSE A LEVEL`
  String get choose_level {
    return Intl.message(
      'CHOOSE A LEVEL',
      name: 'choose_level',
      desc: '',
      args: [],
    );
  }

  /// `Lesson's Title`
  String get lesson_title {
    return Intl.message(
      'Lesson\'s Title',
      name: 'lesson_title',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a title`
  String get please_enter_title {
    return Intl.message(
      'Please enter a title',
      name: 'please_enter_title',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid title`
  String get please_enter_valid_title {
    return Intl.message(
      'Please enter a valid title',
      name: 'please_enter_valid_title',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Video Link`
  String get video_link {
    return Intl.message(
      'Video Link',
      name: 'video_link',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a link`
  String get please_enter_link {
    return Intl.message(
      'Please enter a link',
      name: 'please_enter_link',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid youtube link`
  String get please_enter_valid_youtube_link {
    return Intl.message(
      'Please enter a valid youtube link',
      name: 'please_enter_valid_youtube_link',
      desc: '',
      args: [],
    );
  }

  /// `Link`
  String get link {
    return Intl.message(
      'Link',
      name: 'link',
      desc: '',
      args: [],
    );
  }

  /// `File Added`
  String get file_added {
    return Intl.message(
      'File Added',
      name: 'file_added',
      desc: '',
      args: [],
    );
  }

  /// `Pick a file`
  String get pick_a_file {
    return Intl.message(
      'Pick a file',
      name: 'pick_a_file',
      desc: '',
      args: [],
    );
  }

  /// `The solution to this file is included within`
  String get solution_included {
    return Intl.message(
      'The solution to this file is included within',
      name: 'solution_included',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `File has been added successfully`
  String get file_added_successfully {
    return Intl.message(
      'File has been added successfully',
      name: 'file_added_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Upload File`
  String get upload_file {
    return Intl.message(
      'Upload File',
      name: 'upload_file',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
