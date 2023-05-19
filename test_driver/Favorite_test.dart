
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/scaffolding.dart';

void main() {
  group("Flutter Auth App Test", () {
    final delField = find.byType("delfav");
    final navigateField = find.byType("navigate");
    
     

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

     test(" favorite",() async{
      
      await driver!.tap(delField);
      await driver!.waitUntilNoTransientCallbacks();

         await driver!.tap(navigateField);
      await driver!.waitUntilNoTransientCallbacks();
    });

  });
}