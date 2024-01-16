import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mended/navigation/bottom_nav_bar.dart';
import 'package:mended/views/auth/forgot_password_screen.dart';
import 'package:mended/views/auth/login_screen.dart';
import 'package:mended/views/auth/signup_screen.dart';
import 'package:mended/views/auth/verify_email_screen.dart';
import 'package:mended/views/buddy/buddy_category_screen.dart';
import 'package:mended/views/buddy/buddy_connecting_screenn.dart';
import 'package:mended/views/buddy/buddy_list_screen.dart';
import 'package:mended/views/buddy/buddy_screen.dart';
import 'package:mended/views/call/messages_screen.dart';
import 'package:mended/views/call/new_call_screen.dart';
import 'package:mended/views/chat/screen/chating_screen.dart';
import 'package:mended/views/flicks/add_flicks_screen.dart';
import 'package:mended/views/flicks/flicks_screen.dart';
import 'package:mended/views/group/create_group_screen.dart';
import 'package:mended/views/group/edit_gorup_profile_screen.dart';
import 'package:mended/views/group/group_add_post_screen.dart';
import 'package:mended/views/group/group_post_screen.dart';
import 'package:mended/views/group/group_settings_screen.dart';
import 'package:mended/views/memeland/memeland_screen.dart';
import 'package:mended/views/memeland/memeland_upload_screen.dart';
import 'package:mended/views/memeland/memland_post_screen.dart';
import 'package:mended/views/mender/mender_list_screen.dart';
import 'package:mended/views/onboarding/onboardingscreen.dart';
import 'package:mended/views/profile/account/account_screen.dart';
import 'package:mended/views/profile/account/change_password_screen.dart';
import 'package:mended/views/profile/account/share_profile_screen.dart';
import 'package:mended/views/profile/content/content_preferences_screen.dart';
import 'package:mended/views/profile/help_and_information/help_screen.dart';
import 'package:mended/views/profile/help_and_information/report_a_problem_screen.dart';
import 'package:mended/views/profile/help_and_information/terms_and_conditions_screen.dart';
import 'package:mended/views/profile/mender_profile_screen.dart';
import 'package:mended/views/profile/privacy/privacy_policy_screen.dart';
import 'package:mended/views/profile/settings_privacy_screen.dart';
import 'package:mended/views/reels/add_new_flicks_screen.dart';
import 'package:mended/views/reels/flicks_screen.dart';
import 'package:mended/views/splash/splash_service.dart';

class Routes {
  static String splash = "splash";
  static String onboarding = "onboarding";
  static String login = "login";
  static String signup = "signup";
  static String verifyEmail = "verify-email";
  static String forgotPassword = "forgot-password";
  static String navbar = "navbar";
  static String uploadMemeland = "upload-memeland";
  static String memelandPostScreen = "memeland-post";
  static String createGroup = "create-group";
  static String groupPost = "group-post";
  static String groupSetting = "group-setting";
  static String groupaddPost = "group-add-post";
  static String editGroupProfile = "edit-group-profile";
  static String addflick = "add-flick";
  static String flicks = "flicks";
  static String buddyCategory = "buddy-category";
  static String buddyConnecting = "buddy-connecting";
  static String buddyFind = "buddy-find";
  static String buddyList = "buddy-list";
  static String chattingScreen = "chatting";
  static String menderProfile = "mender-profile";
  static String newCallScreen = "new-call_screen";
  static String findBuddiesConnecting = "find-buddies-connecting";
  static String menderList = "mender-list";
  static String messagesScreen = "messages-screen";
  static String viewAccountSettings = "view-account-settings";
  static String shareProfile = "share-profile";
  static String mendedAccount = "mended_account";
  static String changePassword = "change-password";
  static String contentPreferences = "content-preferences";
  static String reportProblem = "report-problem";
  static String mendedHelp = "mended-help";
  static String termsConditions = "terms-conditions";
  static String privacyPolicy = "privacy-policy";

  GoRouter myrouter = GoRouter(
    routes: [
      GoRoute(
        name: splash,
        path: '/',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: SplashService(),
          );
        },
      ),
      GoRoute(
        name: onboarding,
        path: '/$onboarding',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: OnboardingScreen(),
          );
        },
      ),
      GoRoute(
        name: login,
        path: '/$login',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: LoginScreen(),
          );
        },
      ),
      GoRoute(
        name: signup,
        path: '/$signup',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: SignupScreen(),
          );
        },
      ),
      GoRoute(
        name: verifyEmail,
        path: '/$verifyEmail',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: VerifyEmailScreen(),
          );
        },
      ),
      GoRoute(
        name: forgotPassword,
        path: '/$forgotPassword',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: ForgotPasswordScreen(),
          );
        },
      ),
      GoRoute(
        name: navbar,
        path: '/$navbar',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: BottomNavBar(),
          );
        },
      ),
      GoRoute(
        name: uploadMemeland,
        path: '/$uploadMemeland',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: UploadMemeScreen(),
          );
        },
      ),
      GoRoute(
        name: memelandPostScreen,
        path: '/$memelandPostScreen/:id',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: MemelandPostScreen(
              id: state.pathParameters['id']!,
            ),
          );
        },
      ),
      GoRoute(
        name: createGroup,
        path: '/$createGroup',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: CreateGroupScreen(),
          );
        },
      ),
      GoRoute(
        name: groupPost,
        path: '/$groupPost/:id',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: GroupPostScreen(
              id: state.pathParameters['id']!,
            ),
          );
        },
      ),
      GoRoute(
        name: groupSetting,
        path: '/$groupSetting/:id',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: GroupSettingsScreen(
              id: state.pathParameters['id']!,
            ),
          );
        },
      ),
      GoRoute(
        name: groupaddPost,
        path: '/$groupaddPost/:id',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: GroupAddPostScreen(
              id: state.pathParameters['id']!,
            ),
          );
        },
      ),
      GoRoute(
        name: editGroupProfile,
        path: '/$editGroupProfile/:id',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: EditProfileForThisGroupScreen(
              id: state.pathParameters['id']!,
            ),
          );
        },
      ),
      GoRoute(
        name: addflick,
        path: '/$addflick',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: AddFlickScreen(),
          );
        },
      ),
      GoRoute(
        name: flicks,
        path: '/$flicks',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: FlicksScreen(),
          );
        },
      ),
      GoRoute(
        name: buddyCategory,
        path: '/$buddyCategory',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: BuddiesCategoryScreen(),
          );
        },
      ),
      GoRoute(
        name: buddyConnecting,
        path: '/$buddyConnecting/:category',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: BuddyConnectingScreen(
              category: state.pathParameters['category']!,
            ),
          );
        },
      ),
      GoRoute(
        name: buddyFind,
        path: '/$buddyFind/:id/:category',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: BuddyScreen(
              id: state.pathParameters['id'].toString(),
              category: state.pathParameters['category'].toString(),
            ),
          );
        },
      ),
      GoRoute(
        name: buddyList,
        path: '/$buddyList',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: BuddyListScreen(),
          );
        },
      ),
      GoRoute(
        name: chattingScreen,
        path: '/$chattingScreen/:id',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: chating_screen(
              id: state.pathParameters['id']!,
            ),
          );
        },
      ),
      GoRoute(
        name: menderProfile,
        path: '/$menderProfile/:id',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: MenderProfileScreen(
              id: state.pathParameters['id']!,
            ),
          );
        },
      ),
      GoRoute(
        name: menderList,
        path: '/$menderList',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: MenderListScreen(),
          );
        },
      ),
      GoRoute(
        name: messagesScreen,
        path: '/$messagesScreen',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: MessagesScreen(),
          );
        },
      ),
      GoRoute(
          name: viewAccountSettings,
          path: '/$viewAccountSettings',
          builder: (BuildContext context, GoRouterState state) {
            return const SettingsPrivacyScreen();
          }),
      GoRoute(
          name: shareProfile,
          path: '/$shareProfile',
          builder: (BuildContext context, GoRouterState state) {
            return const ShareProfileScreen();
          }),
      GoRoute(
          name: mendedAccount,
          path: '/$mendedAccount',
          builder: (BuildContext context, GoRouterState state) {
            return const AccountScreen();
          }),
      GoRoute(
          name: changePassword,
          path: '/$changePassword',
          builder: (BuildContext context, GoRouterState state) {
            return const ChangePasswordScreen();
          }),
      GoRoute(
          name: contentPreferences,
          path: '/$contentPreferences',
          builder: (BuildContext context, GoRouterState state) {
            return const ContentPreferencesScreen();
          }),
      GoRoute(
          name: reportProblem,
          path: '/$reportProblem',
          builder: (BuildContext context, GoRouterState state) {
            return const ReportAProblemScreen();
          }),
      GoRoute(
          name: mendedHelp,
          path: '/$mendedHelp',
          builder: (BuildContext context, GoRouterState state) {
            return const HelpScreen();
          }),
      GoRoute(
          name: termsConditions,
          path: '/$termsConditions',
          builder: (BuildContext context, GoRouterState state) {
            return const TermsAndConditionsScreen();
          }),
      GoRoute(
          name: privacyPolicy,
          path: '/$privacyPolicy',
          builder: (BuildContext context, GoRouterState state) {
            return const PrivacyPolicyScreen();
          }),
    ],
  );
}
