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
const String pinTheBinGetBinRoute = "/pinthebin/bin";
const String dekhorPosttoprofileRoute = "/dekhor/posttoprofile";
const String dekhorShowSaveRoute = "/dekhor/showsave";
const String dekhorSearchBlogRoute = "/dekhor/searchblog";
const String dekhorSearchBloggerRoute = "/dekhor/searchblogger";
const String dekhorWriteBloggerRoute = "/dekhor/createpost";
const String dekhorAddPictureRoute = "/dekhor/upload";
const String dekhorRandomPostRoute = "/dekhor/randompost";
const String dekhorPosttocleaningRoute = "/dekhor/posttocategory/cleaning";
const String dekhorPosttocookingRoute = "/dekhor/posttocategory/cooking";
const String dekhorPosttodecorationRoute = "/dekhor/posttocategory/decoration";
const String dekhorPosttostoryRoute = "/dekhor/posttocategory/story";
const String pinTheBinMyBinRoute = "/pinthebin/mybin";

const Map<String, String> ruamMitrPageRoute = {
  "home": "/RuamMitr/home",
  "homev2": "/RuamMitr/homev2",
  "profile": "/RuamMitr/profile",
  "edit-profile": "/RuamMitr/profile/edit",
  "settings": "/RuamMitr/settings",
  "restroom": "/RuamMitr/restroom",
};
const Map<String, String> restroomPageRoute = {
  "home": "/Restroom/home",
  "review": "/Restroom/Review"
};
const String dinodengzzPageRoute = "/game";
const Map<String, String> tuachuayDekhorPageRoute = {
  "home": "/TuachuayDekhor/home",
  "profile": "/TuachuayDekhor/profile",
  "blog": "/TuachuayDekhor/blog",
  "search": "/TuachuayDekhor/search",
  "blogger": "/TuachuayDekhor/blogger",
  "writeblog": "/TuachuayDekhor/writeblog",
  "draft": "/TuachuayDekhor/draft",
  "decoration": "/TuachuayDekhor/decoration",
  "story": "/TuachuayDekhor/story",
  "cooking": "/TuachuayDekhor/cooking",
  "cleaning": "/TuachuayDekhor/cleaning",
};
const Map<String, String> pinthebinPageRoute = {
  "home": "/PinTheBin/home",
  "addbin": "/PinTheBin/addbin",
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
