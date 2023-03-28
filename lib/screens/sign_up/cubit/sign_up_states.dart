abstract class SignUpStates {}

class SignUpInitialState extends SignUpStates {}

class SignUpChangePasswordVisibilityState extends SignUpStates {}

class SignUpLoadingState extends SignUpStates {}
class SignUpSuccessState extends SignUpStates {
  final String uid;

  SignUpSuccessState(this.uid);
}

class SignUpErrorState extends SignUpStates {
  final String error;

  SignUpErrorState(this.error);
}


class CreateUserSuccessState extends SignUpStates {
  final String uid;

  CreateUserSuccessState(this.uid);
}

class CreateUserErrorState extends SignUpStates {
  final String error;

  CreateUserErrorState(this.error);
}