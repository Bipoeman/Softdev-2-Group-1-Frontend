import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ruam_mitt/PinTheBin/addbinV2.dart';
import 'package:ruam_mitt/PinTheBin/editbin.dart';
import 'package:ruam_mitt/PinTheBin/mybin.dart';
import 'package:ruam_mitt/PinTheBin/report.dart';
import 'package:ruam_mitt/Restroom/editrestroom.dart';
import 'package:ruam_mitt/Restroom/myrestroom.dart';
import 'package:ruam_mitt/Restroom/findposition.dart';
import 'package:ruam_mitt/Restroom/report_pin.dart';
import 'package:ruam_mitt/Restroom/review.dart';
import 'package:ruam_mitt/Restroom/addrestroom.dart';
import 'package:ruam_mitt/Restroom/report.dart';
import 'package:ruam_mitt/Restroom/restroom.dart';
import 'package:ruam_mitt/RuamMitr/central_v2.dart';
import 'package:ruam_mitt/RuamMitr/change_password.dart';
import 'package:ruam_mitt/RuamMitr/login.dart';
import 'package:ruam_mitt/RuamMitr/register.dart';
import 'package:ruam_mitt/RuamMitr/client_settings.dart';
import 'package:ruam_mitt/Dinodengzz/navigation.dart';
import 'package:ruam_mitt/TuachuayDekhor/admin.dart';
import 'package:ruam_mitt/TuachuayDekhor/blogger.dart';
import 'package:ruam_mitt/TuachuayDekhor/cleaning.dart';
import 'package:ruam_mitt/TuachuayDekhor/cooking.dart';
import 'package:ruam_mitt/TuachuayDekhor/decoration.dart';
import 'package:ruam_mitt/TuachuayDekhor/detailreport.dart';
import 'package:ruam_mitt/TuachuayDekhor/editdraft.dart';
import 'package:ruam_mitt/TuachuayDekhor/editpost.dart';
import 'package:ruam_mitt/TuachuayDekhor/home.dart';
import 'package:ruam_mitt/TuachuayDekhor/post.dart';
import 'package:ruam_mitt/TuachuayDekhor/profile.dart';
import 'package:ruam_mitt/TuachuayDekhor/report.dart';
import 'package:ruam_mitt/TuachuayDekhor/reportapp.dart';
import 'package:ruam_mitt/TuachuayDekhor/search.dart';
import 'package:ruam_mitt/TuachuayDekhor/story.dart';
import 'package:ruam_mitt/TuachuayDekhor/writeblog.dart';
import 'package:ruam_mitt/TuachuayDekhor/profile_blogger.dart';
import 'package:ruam_mitt/TuachuayDekhor/draft.dart';
import 'package:ruam_mitt/PinTheBin/home.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_var.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: const SuperApp(),
      ),
    );
  });
}

class SuperApp extends StatefulWidget {
  const SuperApp({super.key});

  @override
  State<SuperApp> createState() => _SuperAppState();
}

class _SuperAppState extends State<SuperApp> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = ThemesPortal.getCurrent(context);
    themeProvider.loadTheme(context);
    themeProvider.loadThemeColor();
    currentContext = context;
    return GetMaterialApp(
      initialRoute: loginPageRoute,
      routes: {
        loginPageRoute: (context) => const LoginPage(),
        registerPageRoute: (context) => const RegisterPage(),
        clientSettingsPageRoute: (context) => const ClientSettingsPage(),
        ruamMitrPageRoute["home"]!: (context) => const HomePageV2(),
        ruamMitrPageRoute["homev2"]!: (context) => const HomePageV2(),
        ruamMitrPageRoute["password-change"]!: (context) =>
            const PasswordChangePage(),
        restroomPageRoute["home"]!: (context) => const RestroomRover(),
        restroomPageRoute["review"]!: (context) => RestroomRoverReview(
              restroomData: ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>,
            ),
        restroomPageRoute["findposition"]!: (context) =>
            const RestroomRoverFindPosition(),
        restroomPageRoute["addrestroom"]!: (context) =>
            const RestroomRoverAddrestroom(),
        restroomPageRoute["report"]!: (context) => const RestroomRoverReport(),
        restroomPageRoute["reportpin"]!: (context) => RestroomRoverReportPin(
            restroomData: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        restroomPageRoute["myrestroom"]!: (context) => const MyRestroomPage(),
        restroomPageRoute["editrestroom"]!: (context) => EditRestroomPage(
            restroomData: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        dinodengzzPageRoute: (context) => const MyGame(),
        tuachuayDekhorPageRoute["home"]!: (context) =>
            const TuachuayDekhorHomePage(),
        tuachuayDekhorPageRoute["profile"]!: (context) =>
            const TuachuayDekhorProfilePage(),
        tuachuayDekhorPageRoute["search"]!: (context) =>
            const TuachuayDekhorSearchPage(),
        tuachuayDekhorPageRoute["blog"]!: (context) {
          final idPost = ModalRoute.of(context)!.settings.arguments as int;
          return TuachuayDekhorBlogPage(id_post: idPost);
        },
        tuachuayDekhorPageRoute["blogger"]!: (context) =>
            const TuachuayDekhorBloggerPage(),
        tuachuayDekhorPageRoute["writeblog"]!: (context) =>
            const TuachuayDekhorWriteBlogPage(),
        tuachuayDekhorPageRoute["editdraft"]!: (context) {
          final idDraft = ModalRoute.of(context)!.settings.arguments as int;
          return TuachuayDekhorEditDraftPage(id_draft: idDraft);
        },
        tuachuayDekhorPageRoute["editpost"]!: (context) {
          final idPost = ModalRoute.of(context)!.settings.arguments as int;
          return TuachuayDekhorEditBlogPage(id_post: idPost);
        },
        tuachuayDekhorPageRoute["draft"]!: (context) =>
            const TuachuayDekhorDraftPage(),
        tuachuayDekhorPageRoute["decoration"]!: (context) =>
            const TuachuayDekhorDecorationPage(),
        tuachuayDekhorPageRoute["story"]!: (context) =>
            const TuachuayDekhorStoryPage(),
        tuachuayDekhorPageRoute["cooking"]!: (context) =>
            const TuachuayDekhorCookingPage(),
        tuachuayDekhorPageRoute["cleaning"]!: (context) =>
            const TuachuayDekhorCleaningPage(),
        tuachuayDekhorPageRoute["profileblogger"]!: (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          final username = args['username'] as String;
          final avatarUrl = args['avatarUrl'] as String;
          return TuachuayDekhorBloggerProfilePage(
              username: username, avatarUrl: avatarUrl);
        },
        tuachuayDekhorPageRoute["report"]!: (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;

          final idPost = args['id_post'] as int;
          final idBlogger = args['id_blogger'] as int;
          return TuachuayDekhorReportPage(
              id_post: idPost, id_blogger: idBlogger);
        },
        tuachuayDekhorPageRoute["detailreport"]!: (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;

          final idPost = args['id_post'] as int;
          final idReport = args['id_report'] as int;
          return TuachuayDekhorDetailReportPage(
              id_post: idPost, id_report: idReport);
        },
        tuachuayDekhorPageRoute["reportapp"]!: (context) =>
            const TuachuayDekhorReportAppPage(),
        tuachuayDekhorPageRoute["admin"]!: (context) =>
            const TuachuayDekhorAdminPage(),
        pinthebinPageRoute["home"]!: (context) => const BinPage(),
        pinthebinPageRoute["addbin"]!: (context) => const AddbinPageV2(),
        pinthebinPageRoute["editbin"]!: (context) => EditbinPage(
            binData: ModalRoute.of(context)?.settings.arguments
                as Map<String, dynamic>),
        pinthebinPageRoute["mybin"]!: (context) => const MyBinPage(),
        pinthebinPageRoute["report"]!: (context) => const ReportPage(),
      },
      title: "RuamMitr - App for Uni Students",
      theme: ThemesPortal.appThemeFromContext(context, "RuamMitr")?.themeData,
    );
  }
}
