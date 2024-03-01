import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ruam_mitt/PinTheBin/addbinV2.dart';
import 'package:ruam_mitt/PinTheBin/editbin.dart';
import 'package:ruam_mitt/PinTheBin/mybin.dart';
import 'package:ruam_mitt/PinTheBin/report.dart';
import 'package:ruam_mitt/Restroom/myrestroom.dart';
import 'package:ruam_mitt/Restroom/findposition.dart';
import 'package:ruam_mitt/Restroom/report_pin.dart';
import 'package:ruam_mitt/Restroom/review.dart';
import 'package:ruam_mitt/Restroom/addrestroom.dart';
import 'package:ruam_mitt/Restroom/report.dart';
import 'package:ruam_mitt/Restroom/restroom.dart';
import 'package:ruam_mitt/RuamMitr/InternetControl/injection.dart';
import 'package:ruam_mitt/RuamMitr/central_v2.dart';
import 'package:ruam_mitt/RuamMitr/login.dart';
import 'package:ruam_mitt/RuamMitr/register.dart';
import 'package:ruam_mitt/Dinodengzz/navigation.dart';
import 'package:ruam_mitt/TuachuayDekhor/blogger.dart';
import 'package:ruam_mitt/TuachuayDekhor/cleaning.dart';
import 'package:ruam_mitt/TuachuayDekhor/cooking.dart';
import 'package:ruam_mitt/TuachuayDekhor/decoration.dart';
import 'package:ruam_mitt/TuachuayDekhor/editdraft.dart';
import 'package:ruam_mitt/TuachuayDekhor/editpost.dart';
import 'package:ruam_mitt/TuachuayDekhor/home.dart';
import 'package:ruam_mitt/TuachuayDekhor/post.dart';
import 'package:ruam_mitt/TuachuayDekhor/profile.dart';
import 'package:ruam_mitt/TuachuayDekhor/report.dart';
import 'package:ruam_mitt/TuachuayDekhor/search.dart';
import 'package:ruam_mitt/TuachuayDekhor/story.dart';
import 'package:ruam_mitt/TuachuayDekhor/writeblog.dart';
import 'package:ruam_mitt/TuachuayDekhor/profile_blogger.dart';
import 'package:ruam_mitt/TuachuayDekhor/draft.dart';
import 'package:ruam_mitt/PinTheBin/home.dart';
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const SuperApp(),
    ),
  );
  DependencyInjection.init();
}

class SuperApp extends StatefulWidget {
  const SuperApp({super.key});

  @override
  State<SuperApp> createState() => _SuperAppState();
}

class _SuperAppState extends State<SuperApp> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themes = Provider.of<ThemeProvider>(context);

    return GetMaterialApp(
      initialRoute: loginPageRoute,
      routes: {
        loginPageRoute: (context) => const LoginPage(),
        registerPageRoute: (context) => const RegisterPage(),
        ruamMitrPageRoute["home"]!: (context) => const HomePageV2(),
        ruamMitrPageRoute["homev2"]!: (context) => const HomePageV2(),
        restroomPageRoute["home"]!: (context) => const RestroomRover(),
        restroomPageRoute["review"]!: (context) => RestroomRoverReview(
            restroomData: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        restroomPageRoute["findposition"]!: (context) =>
            const RestroomRoverFindPosition(),
        restroomPageRoute["addrestroom"]!: (context) =>
            const RestroomRoverAddrestroom(),
        restroomPageRoute["report"]!: (context) => const RestroomRoverReport(),
        restroomPageRoute["reportpin"]!: (context) => RestroomRoverReportPin(restroomData: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        restroomPageRoute["edit"]!: (context) => const MyRestroomPage(),
        dinodengzzPageRoute: (context) => const MyGame(),
        tuachuayDekhorPageRoute["home"]!: (context) =>
            const TuachuayDekhorHomePage(),
        tuachuayDekhorPageRoute["profile"]!: (context) =>
            const TuachuayDekhorProfilePage(),
        tuachuayDekhorPageRoute["search"]!: (context) =>
            const TuachuayDekhorSearchPage(),
        tuachuayDekhorPageRoute["blog"]!: (context) {
          final id_post = ModalRoute.of(context)!.settings.arguments as int;
          return TuachuayDekhorBlogPage(id_post: id_post);
        },
        tuachuayDekhorPageRoute["blogger"]!: (context) =>
            const TuachuayDekhorBloggerPage(),
        tuachuayDekhorPageRoute["writeblog"]!: (context) =>
            const TuachuayDekhorWriteBlogPage(),
        tuachuayDekhorPageRoute["editdraft"]!: (context) {
          final id_draft = ModalRoute.of(context)!.settings.arguments as int;
          return TuachuayDekhorEditDraftPage(id_draft: id_draft);
        },
        tuachuayDekhorPageRoute["editpost"]!: (context) {
          final id_post = ModalRoute.of(context)!.settings.arguments as int;
          return TuachuayDekhorEditBlogPage(id_post: id_post);
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
          final id_post = ModalRoute.of(context)!.settings.arguments as int;
          return TuachuayDekhorReportPage(id_post: id_post);
        },
        pinthebinPageRoute["home"]!: (context) => const BinPage(),
        pinthebinPageRoute["addbin"]!: (context) => const AddbinPageV2(),
        pinthebinPageRoute["editbin"]!: (context) => const EditbinPage(),
        pinthebinPageRoute["mybin"]!: (context) => const MyBinPage(),
        pinthebinPageRoute["report"]!: (context) => const ReportPage(),
      },
      title: "RuamMitr - App for Uni Students",
      theme: themes.themeFrom("RuamMitr")?.themeData,
    );
  }
}
