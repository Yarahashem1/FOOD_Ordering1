
import 'package:flutter_application_1/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context); 
}