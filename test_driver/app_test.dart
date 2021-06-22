// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
// ignore: deprecated_member_use
import 'package:test/test.dart';
void main() {
  group('CenticBids', () {

    //login screen
    final usernameField = find.byValueKey('username');
    final passwordField = find.byValueKey('password');
    final logInButton = find.byValueKey('login');
    final registerLink = find.byValueKey('register');
    final createAccountButton = find.byValueKey('createAccount');

    //home screen
    final logOutButton = find.byValueKey('logout');

    FlutterDriver driver;

    Future<bool> isPresent(SerializableFinder byValueKey,
        {Duration timeout = const Duration(seconds: 1)}) async {
      try {
        await driver.waitFor(byValueKey, timeout: timeout);
        return true;
      } catch (exception) {
        return false;
      }
    }

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('create account', () async {
      if (await isPresent(logOutButton)) {
        await driver.tap(logOutButton);
      }
      await driver.tap(registerLink);
      await driver.tap(usernameField);
      await driver.enterText("testuser@gmail.com");

      await driver.tap(passwordField);
      await driver.enterText("testuser123");

      await driver.tap(createAccountButton);
    });

    test('login', () async {
      if (await isPresent(logOutButton)) {
        await driver.tap(logOutButton);
      }

      await driver.tap(usernameField);
      await driver.enterText("testuser@gmail.com");

      await driver.tap(passwordField);
      await driver.enterText("testuser123");

      await driver.tap(logInButton);
    });


  });
}
