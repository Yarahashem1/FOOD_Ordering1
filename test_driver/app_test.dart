
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/scaffolding.dart';

void main() {
  group("Flutter Auth App Test", () {
    final emailField = find.byValueKey("emailField");
    final passwordField = find.byValueKey("passwordField");
    final signInButton = find.byValueKey("loginButton");
    final userInfoPage = find.byType("Category");


     final favField = find.byValueKey("fav");
     final delField = find.byValueKey("delfav");
    final navigateField = find.byValueKey("navigate");
    final backField = find.byValueKey("back");
    final delField1 = find.byType("favorite");
    final navigateField1 = find.byType("FoodListingBody");

    final butField = find.byValueKey("but");
    final nameField = find.byValueKey("foodname");
    final priceField = find.byValueKey("foodprice");
    final descriptionField = find.byValueKey("fooddescription");
    final imageField = find.byValueKey("image");
    final categoryField = find.byValueKey("catego");
    final signInButtonn = find.byValueKey("addfood");
    final userInfoPagee = find.byType("adminHome");
     

    FlutterDriver? driver;
    setUpAll(() async{
      driver = await FlutterDriver.connect();
      await driver!.waitUntilFirstFrameRasterized();
    });

    tearDownAll(()async{
      if(driver != null) {
        driver!.close();
      }
    });

    test("login fails with incorrect email and password",() async{
      await driver!.tap(emailField);
      await driver!.enterText("yara1@gmail.com");
      await driver!.tap(passwordField);
      await driver!.enterText("yara hashem@@");
      await driver!.tap(signInButton);
      assert(userInfoPage == null);
      await driver!.waitUntilNoTransientCallbacks();

       await driver!.tap(favField);
       assert(delField1 == null);
      await driver!.waitUntilNoTransientCallbacks();

       

      await driver!.tap(navigateField);
     // await Future.delayed(Duration(seconds: 5));
     // assert(navigateField1 == null);
      // await Future.delayed(Duration(seconds: 5));
      await driver!.waitUntilNoTransientCallbacks();
      await Future.delayed(Duration(seconds: 5));

      await driver!.tap(delField);
       assert(delField1 == null);
      await driver!.waitUntilNoTransientCallbacks();
      await Future.delayed(Duration(seconds: 5));

       await driver!.tap(backField);
       assert(userInfoPage == null);
      await driver!.waitUntilNoTransientCallbacks();
    });

     test("login fails with incorrect email and password",() async{
      await driver!.tap(emailField);
      await driver!.enterText("ahmaad6220@gmail.com");
      await driver!.tap(passwordField);
      await driver!.enterText("yara hashem@@");
      await driver!.tap(signInButton);
      assert(userInfoPage == null);
      await driver!.waitUntilNoTransientCallbacks();

         
      await driver!.tap(butField);
      await driver!.waitUntilNoTransientCallbacks();

      await driver!.tap(nameField);
      await driver!.enterText("shoclate");
      await driver!.tap(priceField);
      await driver!.enterText("7");
       await driver!.tap(descriptionField);
      await driver!.enterText("whithout suger");
      await driver!.tap(imageField);
      await driver!.waitUntilNoTransientCallbacks();
      await driver!.tap(categoryField);
      await driver!.waitUntilNoTransientCallbacks();

     //  await driver!.waitFor(signInButton);
      //await driver!.waitUntilNoTransientCallbacks();

      await driver!.tap(signInButtonn);
      assert(userInfoPagee == null);
      await driver!.waitUntilNoTransientCallbacks();
    });


    
    

     test("login fails with incorrect email and password",() async{
      await driver!.tap(emailField);
      await driver!.enterText("test@testmail.com");
      await driver!.tap(passwordField);
      await driver!.enterText("test");
      await driver!.tap(signInButton);
      assert(userInfoPage == null);
      await driver!.waitUntilNoTransientCallbacks();
    });


  });
}