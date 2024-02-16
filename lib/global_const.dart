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
  "restroom": "/RuamMitr/restroom",
};
const Map<String, String> restroomPageRoute = {
  "home": "/Restroom/home",
  "review": "/Restroom/Review"
};
const String dinodengzzPageRoute = "/game";
