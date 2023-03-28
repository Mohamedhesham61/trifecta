import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trifecta/components/constant.dart';
import 'package:trifecta/models/user_models.dart';
import 'package:trifecta/screens/login_screen/cubit/login_states.dart';
import 'package:trifecta/shared/local/cache_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitState());

  void userLogin({
    required String email,
    required String password,
  })
  {
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      emit(LoginSuccessState(value.user!.uid));
    }
    ).catchError((error){
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }


  UserModel? userData;
  void getMyData(){
    FirebaseFirestore.instance.collection("users").doc(uId??CacheHelper.getData(key: 'uId')).get().then((value){
      userData = UserModel.fromJson(value.data()!);
      emit(LoginGetUserSuccessState());
    });
  }

  static LoginCubit get(context) => BlocProvider.of(context);

  IconData suffixIcon = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisibilityState());
  }


  void resetPassword ({required String email})
  {
    emit(LoginResetPasswordLoadingState());
    FirebaseAuth.instance.sendPasswordResetEmail(email: email)
        .then((value){
      emit(LoginResetPasswordSuccessState());
    })
        .catchError((error){
      print(error.toString());
      emit(LoginResetPasswordErrorState(error));
    });
  }
}
