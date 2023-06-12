import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trifecta/components/components.dart';
import 'package:trifecta/components/constant.dart';
import 'package:trifecta/screens/forget_password/forget_password.dart';
import 'package:trifecta/screens/home_screen/main_home_screen.dart';
import 'package:trifecta/screens/login_screen/cubit/login_cubit.dart';
import 'package:trifecta/screens/login_screen/cubit/login_states.dart';
import 'package:trifecta/screens/sign_up/sign_up_screen.dart';
import 'package:trifecta/shared/local/cache_helper.dart';
import 'package:trifecta/shared/style/icon_broken.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (BuildContext context)=>LoginCubit(),
        child: BlocConsumer<LoginCubit,LoginStates>(
          listener: (context,state){
            if(state is LoginErrorState)
            {
              showToast(
                  message: state.error,
                  state: ToastStates.ERROR
              );
            }
            if(state is LoginSuccessState)
            {
              showToast(
                  message: 'Login successfully',
                  state: ToastStates.SUCCESS
              );
              CacheHelper.saveData(
                  key: 'uId',
                  value: state.uid
              ).then((value){
                navigateAndFinish(context, MainHomeScreen());
              });
            }
          },
          builder: (context,state){
            var cubit = LoginCubit.get(context);
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 26,),
                      const Text('Login',
                        style: TextStyle(
                          fontFamily: 'Poppin',
                          fontSize: 28,
                        ),
                      ),
                      const Text('Welcome back',
                        style: TextStyle(
                          fontFamily: 'Poppin',
                          fontSize: 14,
                          letterSpacing: 1
                        ),
                      ),
                      const SizedBox(height: 24,),
                      defaultTextFormField(
                        controller: emailController,
                        validator: (value){
                          if(value!.isEmpty)
                          {
                            return 'Enter email Address';
                          }
                          else{
                            return null;
                          }
                        },
                        inputType: TextInputType.emailAddress,
                        label: 'Email Address',
                        prefix: IconBroken.Message,
                        max: 1
                      ),
                      const SizedBox(height: 24,),
                      defaultTextFormField(
                        controller: passwordController,
                        validator: (value){
                          if(value!.isEmpty)
                          {
                            return 'Enter Password';
                          }
                          else{
                            return null;
                          }
                        },
                        inputType: TextInputType.visiblePassword,
                        label: 'Password',
                        prefix: IconBroken.Password,
                        isPassword: cubit.isPassword,
                        suffix: cubit.suffixIcon,
                        onSuffixPressed: (){cubit.changePasswordVisibility();},
                        max: 1
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          defaultTextButton(
                            function: (){navigateTo(context, const ForgetPassword());},
                            text: 'Forget password?',
                            color: primaryColor
                          ),
                        ],
                      ),
                      const Spacer(),
                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        builder: (BuildContext context)=>defaultButton(
                            radius: 100,
                            text: 'Login',
                            backgroundColor:primaryColor,
                            onPressed: (){
                              if(formKey.currentState!.validate())
                              {
                                cubit.userLogin(email: emailController.text, password: passwordController.text);
                              }
                            }
                        ),
                        fallback: (BuildContext context)=> Center(child: CircularProgressIndicator(color: primaryColor,),),
                      ),
                      const SizedBox(height: 10,),
                      defaultButton(
                        radius: 100,
                        textColor: primaryColor,
                        text: 'Don\'t have an account? Create account',
                        onPressed: (){
                          navigateAndFinish(context, const SignUpScreen());}
                      ),
                      const SizedBox(height: 30,),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      )
    );
  }
}
