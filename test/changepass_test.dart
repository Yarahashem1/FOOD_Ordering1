import 'package:flutter/material.dart';
import 'package:flutter_application_1/login/cubit/cubit.dart';
import 'package:flutter_application_1/login/cubit/states.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late SocialLoginCubit socialLoginCubit;

  setUp(() {
    socialLoginCubit = SocialLoginCubit();
  });

  test('change password visibility should toggle password visibility and icon', () {
    expect(socialLoginCubit.isPassword, isTrue);
    expect(socialLoginCubit.suffix, Icons.visibility_outlined);

    socialLoginCubit.changePasswordVisibility();
    expect(socialLoginCubit.isPassword, isFalse);
    expect(socialLoginCubit.suffix, Icons.visibility_off_outlined);

    socialLoginCubit.changePasswordVisibility();
    expect(socialLoginCubit.isPassword, isTrue);
    expect(socialLoginCubit.suffix, Icons.visibility_outlined);
  });
}
