import 'package:flutter/material.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';

const String baseURL = "https://ruammitr.azurewebsites.net";
// const String api = "https://ruammitr.azurewebsites.net/api";

const String api = "http://10.0.2.2:3000";
const String loginPageRoute = "/login";
const String registerPageRoute = "/register";
const String userDataUpdateRoute = "/user";
const String userImageUpdateRoute = "/user/upload";
const String userDataRequestRoute = "/user/id";
const String userPasswordChangeOTPRoute = "/user/otp";
const String userPasswordChangeRoute = "/user/changepassword";
const String userPasswordResetRoute = "/user/reset";
const String refreshTokenRoute = "/user/refresh";
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
const String pinTheBinMyBinRoute = "/pinthebin/mybin";
const String pinTheBinDeleteBinRoute = "/pinthebin/bin";
const String restroomRoverGetRestroomRoute = "/restroom";
const String restroomRoverGetReviewRoute = "/restroom/review";
const String pinTheBinReportBinRoute = "/pinthebin/report";
const String pinTheBinReportPictureBinRoute = "/pinthebin/report/upload";


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
  "edit": "/Restroom/Edit",
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
  ));
}
