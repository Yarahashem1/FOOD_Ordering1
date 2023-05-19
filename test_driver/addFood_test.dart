
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/scaffolding.dart';

void main() {
  group("Flutter Auth App Test", () {
    final nameField = find.byValueKey("foodname");
    final priceField = find.byValueKey("foodprice");
    final descriptionField = find.byValueKey("fooddescription");
    final imageField = find.byValueKey("image");
    final categoryField = find.byValueKey("catego");
    final signInButton = find.byValueKey("addfood");
    final userInfoPage = find.byType("adminHome");

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

      await driver!.tap(signInButton);
      assert(userInfoPage == null);
      await driver!.waitUntilNoTransientCallbacks();
    });

   


  });
}