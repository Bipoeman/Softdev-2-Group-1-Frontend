import 'package:flutter/material.dart';
import 'dart:async';

String publicToken = "";
String refreshToken = "";
Map<String, dynamic> profileData = {};
bool isOnceLogin = false;
BuildContext currentContext = null as dynamic;

Timer? otpTimer;
bool isOTPTimerActive = false;
int currentOTPTimer = 60;

Timer? dashboardTimer;
bool isDashboardTimerActive = false;
int currentActiveTimer = 0;
int timeoutCount = 0;
