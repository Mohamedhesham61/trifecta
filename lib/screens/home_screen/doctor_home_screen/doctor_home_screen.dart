
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trifecta/components/components.dart';
import 'package:trifecta/components/constant.dart';
import 'package:trifecta/screens/home_screen/cubit/trifecta_cubit.dart';
import 'package:trifecta/screens/home_screen/cubit/trifecta_states.dart';
import 'package:trifecta/screens/home_screen/doctor_home_screen/doctor_home_screens/doctor_blood.dart';
import 'package:trifecta/screens/home_screen/doctor_home_screen/doctor_home_screens/doctor_profile.dart';
import 'package:trifecta/screens/home_screen/doctor_home_screen/doctor_home_screens/doctor_requests.dart';
import 'package:trifecta/screens/login_screen/login_screen.dart';
import 'package:trifecta/shared/local/cache_helper.dart';
import 'package:trifecta/shared/style/icon_broken.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen ({Key? key}) : super(key: key);

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  int currentScreen = 0;

  List<Widget> itemsScreens = [
    const DoctorRequestScreen(),
    const DoctorBloodDonation(),
    const ProfileDoctorScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return  Builder(
      builder: (context) {
        if(TrifectaCubit.get(context).userData == null)
        {
          TrifectaCubit.get(context).getMyData();
        }
        return BlocConsumer<TrifectaCubit,TrifectaStates>(
          listener: (context,state){
            if(state is TrifectaSignOutSuccessfully)
            {
              CacheHelper.removeData(key: 'uId');
              navigateAndFinish(context, LoginScreen());
            }
          },
          builder: (context,state){
            return Scaffold(
              backgroundColor: Colors.white,
              bottomNavigationBar: BottomNavigationBar(
                elevation: 0.0,
                items: const [
                  BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage('assets/images/request.png')),
                    label: 'Request',
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage('assets/images/blood.png')),
                    label: 'blood',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(IconBroken.Profile),
                    label: 'Profile',
                  ),
                ],
                onTap: (index){
                  setState(() {
                    currentScreen = index;
                  });
                },
                currentIndex: currentScreen,
                backgroundColor: Colors.white,
                unselectedItemColor: Colors.grey,
                selectedItemColor: primaryColor,
              ),
              body: itemsScreens[currentScreen],
            );
          },
        );
      }
    );
  }
}
