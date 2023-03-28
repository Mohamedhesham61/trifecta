abstract class TrifectaStates{}

//initial states for social layout loading ,initial ,success ,and error
class TrifectaInitialState extends TrifectaStates{}


// =============================        get user     =====================
class TrifectaGetUserSuccessState extends TrifectaStates {}
class TrifectaGetUserErrorState extends TrifectaStates {}

// =============================        pick profile Image     =====================

class TrifectaPickProfileImageSuccessState extends TrifectaStates{}
class TrifectaPickProfileImageErrorState extends TrifectaStates {}

// =============================        upload profile Images     =====================
class TrifectaUpdateImagesLoadingState extends TrifectaStates{}
class TrifectaUploadProfileImageSuccessState extends TrifectaStates{}
class TrifectaUploadProfileImageErrorState extends TrifectaStates{}



// =============================        update User     =====================
class TrifectaUpdateUserLoadingState extends TrifectaStates{}
class TrifectaUpdateUserErrorState extends TrifectaStates{}

//==================   sign out ==================
class TrifectaSignOutSuccessfully extends TrifectaStates{}
class TrifectaSignOutError extends TrifectaStates{
  final String error;

  TrifectaSignOutError(this.error);

}


class GetRequestHealthCareSuccessState extends TrifectaStates {}
class CreateRequestHealthCareLoadingState extends TrifectaStates {}
class CreateRequestHealthCareSuccessState extends TrifectaStates {}
class CreateRequestHealthCareErrorState extends TrifectaStates {
  final String error;

  CreateRequestHealthCareErrorState(this.error);
}

class GetRequestRideSuccessState extends TrifectaStates {}
class CreateRequestRideLoadingState extends TrifectaStates {}
class CreateRequestRideSuccessState extends TrifectaStates {}
class CreateRequestRideErrorState extends TrifectaStates {
  final String error;

  CreateRequestRideErrorState(this.error);
}

class GetRequestDoctorSuccessState extends TrifectaStates {}
class CreateRequestDoctorSuccessState extends TrifectaStates {}
class CreateRequestDoctorLoadingState extends TrifectaStates {}
class CreateRequestDoctorErrorState extends TrifectaStates {
  final String error;

  CreateRequestDoctorErrorState(this.error);
}

class GetRequestBloodDonationSuccessState extends TrifectaStates {}
class CreateRequestBloodDonationLoadingState extends TrifectaStates {}
class CreateRequestBloodDonationSuccessState extends TrifectaStates {}
class CreateRequestBloodDonationErrorState extends TrifectaStates {
  final String error;

  CreateRequestBloodDonationErrorState(this.error);
}