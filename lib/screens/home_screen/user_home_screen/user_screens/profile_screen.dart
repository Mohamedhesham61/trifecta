
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trifecta/components/components.dart';
import 'package:trifecta/components/constant.dart';
import 'package:trifecta/screens/home_screen/cubit/trifecta_cubit.dart';
import 'package:trifecta/screens/home_screen/cubit/trifecta_states.dart';
import 'package:trifecta/screens/home_screen/user_home_screen/my_requests/my_requests.dart';
import 'package:trifecta/screens/home_screen/user_home_screen/update_profile/update_profile.dart';
import 'package:trifecta/screens/login_screen/login_screen.dart';
import 'package:trifecta/shared/local/cache_helper.dart';
import 'package:trifecta/shared/style/icon_broken.dart';

class ProfileUserScreen extends StatelessWidget {
  const ProfileUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrifectaCubit,TrifectaStates>(
      listener: (context,state){
        if(state is TrifectaSignOutSuccessfully)
        {
          CacheHelper.removeData(key: 'uId');
          navigateAndFinish(context, LoginScreen());
        }
      },
      builder: (context,state){
        var userData = TrifectaCubit.get(context).userData;
        var cubit = TrifectaCubit.get(context);
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 16,),
                CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage('${userData!.profileImage}'),
                ),
                const SizedBox(height: 20,),
                Text('${userData.name}',
                  style: const TextStyle(
                    fontFamily: 'Poppin',
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 10,),
                Text('${userData.phone}',
                  style: const TextStyle(
                    fontFamily: 'Poppin',
                    fontSize: 17
                  ),
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: primaryColor,width: 1),
                        ),
                        child: MaterialButton(
                          onPressed: (){navigateTo(context, UpdateProfile());},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [
                              Icon(IconBroken.Profile,color: primaryColor,size: 30,),
                              const SizedBox(height: 10,),
                              Text('Edit Profile',
                                style: TextStyle(
                                  fontFamily: 'Poppin',
                                  fontSize: 20,
                                  color: primaryColor
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: primaryColor,width: 1),
                        ),
                        child: MaterialButton(
                          onPressed: (){navigateTo(context,const MyRequests());},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [
                              Image.asset('assets/images/request.png',color: primaryColor,),
                              const SizedBox(height: 10,),
                              Text('My Requests',
                                style: TextStyle(
                                  fontFamily: 'Poppin',
                                  fontSize: 20,
                                  color: primaryColor
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                defaultButton(
                  radius: 100,
                  backgroundColor: primaryColor,
                  text: 'Log Out',
                  onPressed: (){
                    cubit.signOut();
                  }
                ),
                const SizedBox(height: 10,),
              ],
            ),
          ),
        );
      },
    );
  }
}
