import 'package:flutter/material.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';

const String api = "https://softwaredev2.ddns.net";

const String loginPageRoute = "/login";
const String registerPageRoute = "/register";
const String clientSettingsPageRoute = "/client_settings";
const String userDataUpdateRoute = "/user";
const String userDashboardRoute = "/user/dashboard";
const String userImageUpdateRoute = "/user/upload";
const String userDataRequestRoute = "/user/id";
const String requestOTPRoute = "/user/otp";
const String userPasswordChangeRoute = "/user/changepassword";
const String userPasswordResetRoute = "/user/reset";
const String userPostIssueRoute = "/issue";
const String adminAcceptIssueRoute = "/issue";
const String refreshTokenRoute = "/user/refresh";
const String reportRoute = "/issue";
const String pinTheBinGetBinRoute = "/pinthebin/bin";
const String dekhorPosttoprofileRoute = "/dekhor/posttoprofile";
const String dekhorShowSaveRoute = "/dekhor/showsave";
const String dekhorPosttoprofilebloggerRoute = "/dekhor/posttoprofileblogger";
const String dekhorShowSavebloggerRoute = "/dekhor/showsaveblogger";
const String dekhorSearchBlogRoute = "/dekhor/searchblog";
const String dekhorSearchBloggerRoute = "/dekhor/searchblogger";
const String dekhorWriteBlogRoute = "/dekhor/createpost";
const String dekhorAddPictureRoute = "/dekhor/createpic";
const String dekhorRandomPostRoute = "/dekhor/randompost";
const String dekhorPosttocleaningRoute = "/dekhor/posttocategory/cleaning";
const String dekhorPosttocookingRoute = "/dekhor/posttocategory/cooking";
const String dekhorPosttodecorationRoute = "/dekhor/posttocategory/decoration";
const String dekhorPosttostoryRoute = "/dekhor/posttocategory/story";
const String dekhorDetailPostRoute = "/dekhor/detailpost";
const String dekhorCommentPostRoute = "/dekhor/commentpost";
const String dekhorShowcommentPostRoute = "/dekhor/showcomment";
const String dekhorSavePostRoute = "/dekhor/savepost";
const String dekhorUnsavePostRoute = "/dekhor/unsave";
const String dekhorCountsavePostRoute = "/dekhor/countsave";
const String dekhorNumsavePostRoute = "/dekhor/numsave";
const String dekhorDeletePostRoute = "/dekhor/deletepost";
const String dekhorEditPostRoute = "/dekhor/editpost";
const String dekhorDraftPostRoute = "/dekhor/draftpost";
const String dekhorPosttoDraftRoute = "/dekhor/posttodraft";
const String dekhorDetailDraftRoute = "/dekhor/detaildraft";
const String dekhorEditDraftRoute = "/dekhor/editdraft";
const String dekhorDeleteDraftRoute = "/dekhor/deletedraft";
const String dekhorReportRoute = "/dekhor/report";
const String dekhorUpdatePicRoute = "/dekhor/updatepicture";
const String dekhorUpdatePicDraftRoute = "/dekhor/updatepic";
const String dekhorDrafttoPostBlogRoute = "/dekhor/drafttopostblog";
const String dekhorShowReportRoute = "/dekhor/showreport";
const String dekhorDeleteReportRoute = "/dekhor/deletereport";
const String dekhorDetailReportRoute = "/dekhor/detailreport";
const String dekhorDescriptionRoute = "/dekhor/bloggerdescription";
const String pinTheBinMyBinRoute = "/pinthebin/mybin";
const String pinTheBinDeleteBinRoute = "/pinthebin/bin";
const String pinTheBinAddpicRoute = "/pinthebin/bin/upload";
const String pinTheBinEditpicRoute = "/pinthebin/bin/upload";
const String pinTheBinaddbinRoute = "/pinthebin/bin";
const String pinTheBineditbinRoute = "/pinthebin/bin";
const String restroomRoverRestroomRoute = "/restroom";
const String restroomRoverMyRestroomRoute = "/restroom/mytoilet";
const String restroomRoverReviewRoute = "/restroom/review";
const String restroomRoverUploadToiletPictureRoute = "/restroom/upload";
const String restroomRoverUploadReviewPictureRoute = "/restroom/upload/review";
const String pinTheBinReportBinRoute = "/pinthebin/report";
const String pinTheBinReportPictureBinRoute = "/pinthebin/report/upload";

const String allIssueRoute = "/issue";
const String aceptedIssueRoute = "/issue/accept";
const String rejectedIssueRoute = "/issue/reject";
const String ruammitrIssueRoute = "/issue/ruammitr";
const String pintheebinIssueRoute = "/issue/pinthebin";
const String restroomIssueRoute = "/issue/restroom";
const String dekhorIssueRoute = "/issue/dekhor";

const Map<String, String> ruamMitrPageRoute = {
  "home": "/RuamMitr/home",
  "homev2": "/RuamMitr/homev2",
  "profile": "/RuamMitr/profile",
  "edit-profile": "/RuamMitr/profile/edit",
  "password-change": "/RuamMitr/password",
  "settings": "/RuamMitr/settings",
  "restroom": "/RuamMitr/restroom",
};
const Map<String, String> restroomPageRoute = {
  "home": "/Restroom/home",
  "review": "/Restroom/Review",
  "findposition": "/Restroom/Findposition",
  "addrestroom": "/Restroom/Addrestroom",
  "report": "/Restroom/Report",
  "reportpin": "/Restroom/ReportPin",
  "myrestroom": "/Restroom/MyRestroom",
  "editrestroom": "/Restroom/EditRestroom",
};
const String dinodengzzPageRoute = "/game";
const Map<String, String> tuachuayDekhorPageRoute = {
  "home": "/TuachuayDekhor/home",
  "profile": "/TuachuayDekhor/profile",
  "profileblogger": "/TuachuayDekhor/profileblogger",
  "blog": "/TuachuayDekhor/blog",
  "detaildraft": "/TuachuayDekhor/detaildraft",
  "search": "/TuachuayDekhor/search",
  "blogger": "/TuachuayDekhor/blogger",
  "writeblog": "/TuachuayDekhor/writeblog",
  "editpost": "/TuachuayDekhor/editpost",
  "draft": "/TuachuayDekhor/draft",
  "editdraft": "/TuachuayDekhor/editdraft",
  "decoration": "/TuachuayDekhor/decoration",
  "story": "/TuachuayDekhor/story",
  "cooking": "/TuachuayDekhor/cooking",
  "cleaning": "/TuachuayDekhor/cleaning",
  "report": "/TuachuayDekhor/report",
  "reportapp": "/TuachuayDekhor/reportapp",
  "admin": "/TuachuayDekhor/admin",
  "detailreport": "/TuachuayDekhor/detailreport",
};
const Map<String, String> pinthebinPageRoute = {
  "home": "/PinTheBin/home",
  "addbin": "/PinTheBin/addbinV2",
  "editbin": "/PinTheBin/editbin",
  "report": "/PinTheBin/report",
  "mybin": "/PinTheBin/mybin",
};

BoxDecoration ruamMitrBackgroundGradient(ThemeProvider themes) {
  return BoxDecoration(
    gradient: LinearGradient(
      // stops: const [-0.5, 0.8],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        themes.themeFrom("RuamMitr")!.customColors["backgroundStart"]!,
        themes.themeFrom("RuamMitr")!.customColors["backgroundEnd"]!
      ],
    ),
  );
}

LinearGradient backgroundGradient(BuildContext context, String themeName) {
  CustomThemes customTheme = ThemesPortal.appThemeFromContext(context, themeName)!;
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      customTheme.customColors["backgroundStart"]!,
      customTheme.customColors["backgroundEnd"]!
    ],
  );
}

const Map<String, String> restroomPinImg = <String, String>{
  "Free": "assets/images/RestroomRover/Pingreen.png",
  "Must Paid": "assets/images/RestroomRover/Pinred.png",
  "Toilet In Stores": "assets/images/RestroomRover/Pinorange3.png",
};
