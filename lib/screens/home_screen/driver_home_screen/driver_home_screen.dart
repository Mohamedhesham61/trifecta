import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trifecta/components/components.dart';
import 'package:trifecta/components/constant.dart';
import 'package:trifecta/screens/home_screen/cubit/trifecta_cubit.dart';
import 'package:trifecta/screens/home_screen/cubit/trifecta_states.dart';
import 'package:trifecta/screens/home_screen/driver_home_screen/driver_screens/blood_driver_screen.dart';
import 'package:trifecta/screens/home_screen/driver_home_screen/driver_screens/driver_profile.dart';
import 'package:trifecta/screens/home_screen/driver_home_screen/driver_screens/request_Screen.dart';
import 'package:trifecta/screens/login_screen/login_screen.dart';
import 'package:trifecta/shared/local/cache_helper.dart';
import 'package:trifecta/shared/style/icon_broken.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({Key? key}) : super(key: key);

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {

  int currentScreen = 0;

  List<Widget> itemsScreens = [
    const DriverRequestScreen(),
    const DriverBloodRequestScreen(),
    const DriverProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Builder(
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
              return SafeArea(
                child: Scaffold(
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
                ),
              );
            },
          );
        }
    );
  }
}
