// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:ruam_mitt/RuamMitr/Component/theme.dart';
import 'package:ruam_mitt/RuamMitr/login.dart';

import 'package:ruam_mitt/main.dart';

// class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class FakeRoute extends Fake implements Route {}
void main() {
  // WidgetController.hitTestWarningShouldBeFatal =
  testWidgets('Main Route Test', (WidgetTester tester) async {
    //   // Build our app and trigger a frame.
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const SuperApp(),
    ));

    //   // Verify that our counter starts at 0.
    print("find credentials field");
    expect(find.text('Email or Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    // //   // Tap the '+' icon and trigger a frame.
    // await Future.delayed(Duration(seconds: 1));
    //   await tester.pump();

    //   // Verify that our counter has incremented.
    //   expect(find.text('0'), findsNothing);
    //   expect(find.text('1'), findsOneWidget);
  });
  testWidgets("Login Page Test", (tester) async {

    await tester.pumpWidget(const MaterialApp(
      home: LoginPage(),
    ));
    final emailField = find.ancestor(
      of: find.text('Email or Username'),
      matching: find.byType(TextFormField),
    );
    await tester.enterText(emailField, "admin");
    expect(find.text('admin') , findsOneWidget);
    await tester.enterText(emailField, "");

    final passwordField = find.ancestor(
      of: find.text('Password'),
      matching: find.byType(TextFormField),
    );
    await tester.enterText(passwordField, "admin");
    expect(find.text('admin') , findsOneWidget);
    // NavigatorObserver navigatorObserver = NavigatorObserver();
    // tester.tap(find.text("Login")); 
    // navigatorObserver.didPop();

  });
  // test("login", () => {

  // });
}
