import 'package:flutter/material.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';

const String baseURL = "https://ruammitr.azurewebsites.net";
// const String api = "https://ruammitr.azurewebsites.net/api";
const String api = "http://10.0.2.2:3000";
// const String api = "http://localhost:3000";
const String loginPageRoute = "/login";
const String registerPageRoute = "/register";
const String userDataRequestRoute = "/user/id";
const String pinTheBinGetBinRoute = "/pinthebin/bin";
const String dekhorPosttoprofileRoute = "/dekhor/posttoprofile";
const String dekhorShowSaveRoute = "/dekhor/showsave";
const String dekhorSearchBlogRoute = "/dekhor/searchblog";
const String dekhorSearchBloggerRoute = "/dekhor/searchblogger";
const String dekhorWriteBloggerRoute = "/dekhor/createpost";
const String dekhorAddPictureRoute = "/dekhor/upload";
const String dekhorRandomPostRoute = "/dekhor/randompost";

const Map<String, String> ruamMitrPageRoute = {
  "home": "/RuamMitr/home",
  "homev2": "/RuamMitr/homev2",
  "profile": "/RuamMitr/profile",
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
