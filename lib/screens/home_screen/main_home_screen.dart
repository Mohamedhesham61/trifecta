import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trifecta/screens/home_screen/cubit/trifecta_cubit.dart';
import 'package:trifecta/screens/home_screen/cubit/trifecta_states.dart';
import 'package:trifecta/screens/home_screen/doctor_home_screen/doctor_home_screen.dart';
import 'package:trifecta/screens/home_screen/driver_home_screen/driver_home_screen.dart';
import 'package:trifecta/screens/home_screen/nurse_hone_screen/nurse_home_screen.dart';
import 'package:trifecta/screens/home_screen/user_home_screen/user_home_screen.dart';

class MainHomeScreen extends StatefulWidget {
   MainHomeScreen({Key? key}) : super(key: key);

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
   Widget? homeScreen;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context)
      {
        if(TrifectaCubit.get(context).userData == null)
        {
          TrifectaCubit.get(context).getMyData();
        }
        return BlocConsumer<TrifectaCubit,TrifectaStates>(
          listener: (context,state){},
          builder: (context,state){
           if(TrifectaCubit.get(context).userData?.applyingAs=='Doctor'){
             homeScreen = const DoctorHomeScreen();
           }
           else if(TrifectaCubit.get(context).userData?.applyingAs=='User')
             {
               homeScreen = const UserHomeScreen();
             }
           else if(TrifectaCubit.get(context).userData?.applyingAs=='Driver')
           {
             homeScreen = const DriverHomeScreen();
           }
           else if(TrifectaCubit.get(context).userData?.applyingAs=='Nurse')
           {
             homeScreen = const NurseHomeScreen();
           }
            return SafeArea(
              child: Scaffold(
                body: homeScreen,
              ),
            );
          }

        );
      },
    );
  }
}
