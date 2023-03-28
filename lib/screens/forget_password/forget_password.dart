import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trifecta/components/components.dart';
import 'package:trifecta/components/constant.dart';
import 'package:trifecta/screens/login_screen/cubit/login_cubit.dart';
import 'package:trifecta/screens/login_screen/cubit/login_states.dart';
import 'package:trifecta/shared/style/icon_broken.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  var emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (BuildContext context)=>LoginCubit(),
        child: BlocConsumer<LoginCubit,LoginStates>(
          listener: (context,state){
            if(state is LoginResetPasswordSuccessState)
            {
              showToast(
                  message: 'Code Sent', state: ToastStates.SUCCESS);
            }
          },
          builder: (context,state){
            var cubit = LoginCubit.get(context);
            return Scaffold(
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 26,),
                      Row(
                        children: [
                          IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(IconBroken.Arrow___Left_2)),
                          const Text('Forget Password',
                            style: TextStyle(
                              fontSize: 28,
                              fontFamily: 'Poppin',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16,),
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
                      ),
                      const Spacer(),
                      ConditionalBuilder(
                        condition: state is! LoginResetPasswordLoadingState,
                        builder: (BuildContext context)=>defaultButton(
                          text: 'Send Link',
                          backgroundColor: primaryColor,
                          radius: 100,
                          onPressed: (){
                            if(formKey.currentState!.validate())
                              {
                                cubit.resetPassword(email: emailController.text);
                              }
                          }
                        ),
                        fallback: (BuildContext context)=>Center(child: CircularProgressIndicator(color: primaryColor,),),
                      ),
                      const SizedBox(height: 30,),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
