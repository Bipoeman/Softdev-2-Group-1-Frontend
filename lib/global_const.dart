import 'package:flutter/material.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';

const String baseURL = "https://ruammitr.azurewebsites.net";
const String api = "http://10.0.2.2:3000"; // points to local pc
// const String api = "https://ruammitr.azurewebsites.net/api";

const String loginPageRoute = "/login";
const String registerPageRoute = "/register";
const String userDataRequestRoute = "/user/id";
const Map<String, String> ruamMitrPageRoute = {
  "home": "/RuamMitr/home",
  "homev2": "/RuamMitr/homev2",
  "profile": "/RuamMitr/profile",
  "settings": "/RuamMitr/settings",
};
const String dinodengzzPageRoute = "/game";

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
