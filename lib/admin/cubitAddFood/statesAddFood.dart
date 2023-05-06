abstract class AddFoodStates {}

class AddFoodInitialState extends AddFoodStates {}

class AddFoodLoadingState extends AddFoodStates {}

// class AddFoodSuccessState extends AddFoodStates
// {
//   final String uId;

//   AddFoodSuccessState(this.uId);
// }

// class AddFoodErrorState extends AddFoodStates
// {
//   final String error;

//   AddFoodErrorState(this.error);
// }

class CreateFoodSuccessState extends AddFoodStates{}

class CreateFoodErrorState extends AddFoodStates
{
  final String error;

 CreateFoodErrorState(this.error);
}

class categorySuccessState extends AddFoodStates{}



class AddFoodProfileImagePickedSuccessState extends AddFoodStates {}

class AddFoodProfileImagePickedErrorState extends AddFoodStates{}

class AddFoodUserUpdateLoadingState extends AddFoodStates {}




class AddFoodUploadProfileImageSuccessState extends AddFoodStates {}

class AddFoodUploadProfileImageErrorState extends AddFoodStates {}


class updateFood extends AddFoodStates {}