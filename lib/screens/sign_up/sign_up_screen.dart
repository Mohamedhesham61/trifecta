
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trifecta/components/components.dart';
import 'package:trifecta/components/constant.dart';
import 'package:trifecta/screens/login_screen/login_screen.dart';
import 'package:trifecta/screens/sign_up/cubit/sign_up_cubit.dart';
import 'package:trifecta/screens/sign_up/cubit/sign_up_states.dart';
import 'package:trifecta/shared/local/cache_helper.dart';
import 'package:trifecta/shared/style/icon_broken.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}


class _SignUpScreenState extends State<SignUpScreen> {
  String userType = "Applying as?";
  String genderValue = "Gender";
  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Doctor", child: Text("Doctor")),
      const DropdownMenuItem(value: "Driver", child: Text("Driver")),
      const DropdownMenuItem(value: "User", child:  Text("Normal User")),
      const DropdownMenuItem(value: "Nurse", child:  Text("Nurse")),
    ];
    return menuItems;
  }
  List<DropdownMenuItem<String>> get genderList{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "male", child: Text("Male")),
      const DropdownMenuItem(value: "female", child: Text("Female")),
    ];
    return menuItems;
  }
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (BuildContext context)=>SignUpCubit(),
        child: BlocConsumer<SignUpCubit,SignUpStates>(
          listener: (context,state){
            if(state is CreateUserSuccessState)
            {
              navigateAndFinish(context, LoginScreen());
              CacheHelper.saveData(
                key: 'uId',
                value: state.uid
              );
              showToast(message: 'Account Created', state: ToastStates.SUCCESS);
            }
          },
          builder: (context,state){
            var cubit = SignUpCubit.get(context);
            return Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 26,),
                        const Text('Create an account',
                          style: TextStyle(
                            fontFamily: 'Poppin',
                            fontSize: 28,
                          ),
                        ),
                        const SizedBox(height: 20,),
                        const Text('Applying as?',
                          style: TextStyle(
                            fontFamily: 'Poppin',
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        DropdownButtonFormField(
                            decoration:  InputDecoration(
                              enabledBorder: OutlineInputBorder( //<-- SEE HERE
                                borderSide: BorderSide(color: primaryColor, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder( //<-- SEE HERE
                                borderSide: BorderSide(color: primaryColor, width: 1),
                              ),
                              errorBorder: OutlineInputBorder( //<-- SEE HERE
                                borderSide: BorderSide(color: primaryColor, width: 1),
                              ),
                            ),

                            icon: const Icon(IconBroken.Arrow___Down_2),
                            validator: (value){
                              if(value == null)
                              {
                                return 'Select User Type';
                              }
                              return null;
                            },
                            onChanged: (String? newValue){
                              setState(() {
                                userType = newValue!;
                              });
                            },
                            items: dropdownItems
                        ),
                        const SizedBox(height: 16,),
                        defaultTextFormField(
                          controller: nameController,
                          validator: (value){
                            if(value!.isEmpty)
                            {
                              return 'Enter Your Full Name';
                            }
                            else {return null;}
                          },
                          inputType: TextInputType.name,
                          label: 'Full Name',
                          prefix: IconBroken.User,
                          max: 1
                        ),
                        const SizedBox(height: 16,),
                        defaultTextFormField(
                            controller: emailController,
                            validator: (value){
                              if(value!.isEmpty)
                              {
                                return 'Enter Your Email';
                              }
                              else {return null;}
                            },
                            inputType: TextInputType.emailAddress,
                            label: 'Email Address',
                            prefix: IconBroken.Message,
                          max: 1
                        ),
                        const SizedBox(height: 16,),
                        defaultTextFormField(
                          max: 1,
                          controller: passwordController,
                          validator: (value){
                            if(value!.isEmpty)
                            {
                              return 'Enter Your password';
                            }
                            else {return null;}
                          },
                          inputType: TextInputType.visiblePassword,
                          label: 'Password',
                          prefix: IconBroken.Password,
                          suffix: cubit.suffixIcon,
                          isPassword: cubit.isPassword,
                          onSuffixPressed: (){
                            cubit.changePasswordVisibility();
                          }
                        ),
                        const SizedBox(height: 16,),
                        const Text('Gender',
                          style: TextStyle(
                            fontFamily: 'Poppin',
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        DropdownButtonFormField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder( //<-- SEE HERE
                                borderSide: BorderSide(color: primaryColor, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder( //<-- SEE HERE
                                borderSide: BorderSide(color: primaryColor, width: 1),
                              ),
                              errorBorder: OutlineInputBorder( //<-- SEE HERE
                                borderSide: BorderSide(color: primaryColor, width: 1),
                              ),
                            ),

                            icon: const Icon(IconBroken.Arrow___Down_2),
                            validator: (value){
                              if(value == null)
                              {
                                return 'Gender';
                              }
                              return null;
                            },
                            onChanged: (String? newValue){
                              setState(() {
                                genderValue = newValue!;
                              });
                            },
                            elevation: 16,
                            items: genderList
                        ),
                        const SizedBox(height: 16,),
                        defaultTextFormField(
                          max: 1,
                            controller: phoneController,
                            validator: (value){
                              if(value!.isEmpty)
                              {
                                return 'Enter Your Phone';
                              }
                              else {return null;}
                            },
                            inputType: TextInputType.phone,
                            label: 'Phone Number',
                            prefix: IconBroken.Call
                        ),
                        const SizedBox(height: 10,),
                        ConditionalBuilder(
                          condition: state is! SignUpLoadingState,
                          builder: (BuildContext context)=>defaultButton(
                            radius: 100,
                            text: 'Create Account',
                            backgroundColor: primaryColor,
                            onPressed: (){
                              if(formKey.currentState!.validate())
                                {
                                  cubit.userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                    applyingAs: userType,
                                    gender: genderValue
                                  );
                                }
                            }
                          ),
                          fallback: (BuildContext context)=>Center(child: CircularProgressIndicator(color: primaryColor,),),
                        ),

                        const SizedBox(height: 10,),
                        defaultButton(
                            radius: 100,
                            textColor: primaryColor,
                            text: 'Have an account? Login',
                            onPressed: (){navigateAndFinish(context, LoginScreen());}
                        ),
                        const SizedBox(height: 30,),
                      ],
                    ),
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
