import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trifecta/components/components.dart';
import 'package:trifecta/components/constant.dart';
import 'package:trifecta/screens/home_screen/cubit/trifecta_cubit.dart';
import 'package:trifecta/screens/home_screen/cubit/trifecta_states.dart';
import 'package:trifecta/shared/style/icon_broken.dart';

class UpdateProfile extends StatelessWidget {
   UpdateProfile({Key? key}) : super(key: key);
   var formKey = GlobalKey<FormState>();
   var nameController = TextEditingController();
   var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrifectaCubit,TrifectaStates>(
      listener: (context,state){
        if(state is TrifectaGetUserSuccessState)
        {
          showToast(
              message: 'User Updated',
              state: ToastStates.SUCCESS
          );
        }
      },
      builder: (context,state){
        var userData = TrifectaCubit.get(context).userData;
        var cubit = TrifectaCubit.get(context);
        var profileImage = TrifectaCubit.get(context).profileImage;
        nameController.text = userData!.name!;
        phoneController.text = userData.phone!;
        return  SafeArea(
          child:  Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 16,),
                      Row(
                        children: [
                          IconButton(
                            onPressed: (){
                              Navigator.pop(context);
                              profileImage == null;
                            },
                            icon: const Icon(IconBroken.Arrow___Left_2),
                          ),
                          const Text('Update Profile',
                            style: TextStyle(
                              fontSize: 28,
                              fontFamily: 'Poppin',
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16,),
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 80,
                            backgroundImage: profileImage == null ? NetworkImage('${userData.profileImage}'):FileImage(profileImage) as ImageProvider,
                          ),
                          Positioned(
                              bottom: 0,
                              left: MediaQuery.of(context).size.width*0.25,
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 20,
                                  child: IconButton(
                                    onPressed: (){
                                      cubit.getProfileImage();
                                    },
                                    icon: const Icon(IconBroken.Camera),
                                  ),
                                ),
                              )
                          ),
                        ],
                      ),
                      const SizedBox(height: 16,),
                      defaultTextFormField(
                          controller: nameController,
                          validator: (value){
                            if(value!.isEmpty)
                            {
                              return 'Name is Empty';
                            }
                            return null;
                          },
                          inputType: TextInputType.name,
                          label: 'Name',
                          prefix: IconBroken.User,

                      ),
                      const SizedBox(height: 15,),
                      defaultTextFormField(
                          controller: phoneController,
                          validator: (value){
                            if(value!.isEmpty)
                            {
                              return 'Phone Number is Empty';
                            }
                            return null;
                          },
                          inputType: TextInputType.phone,
                          label: 'Phone Number',
                          prefix: IconBroken.Call,
                      ),
                      const SizedBox(height: 16,),
                      ConditionalBuilder(
                        condition: state is! TrifectaUpdateUserLoadingState,
                        builder: (BuildContext context)=>defaultButton(
                          radius: 100,
                            backgroundColor: primaryColor,
                            text: profileImage==null?'Update User':'Update Profile',
                            onPressed: (){
                            if(profileImage==null) {
                              cubit.updateUser(
                                name: nameController.text,
                                phone: phoneController.text
                              );
                            }
                            else{
                              TrifectaCubit.get(context).uploadProfileImage(
                                name: nameController.text,
                                phone: phoneController.text,
                              );
                            }
                          }
                        ),
                        fallback: (BuildContext context)=> Center(child: CircularProgressIndicator(color: primaryColor,),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
