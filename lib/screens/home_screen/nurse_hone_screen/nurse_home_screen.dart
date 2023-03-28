import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trifecta/components/components.dart';
import 'package:trifecta/components/constant.dart';
import 'package:trifecta/screens/home_screen/cubit/trifecta_cubit.dart';
import 'package:trifecta/screens/home_screen/cubit/trifecta_states.dart';
import 'package:trifecta/screens/home_screen/nurse_hone_screen/nurse_screens/nurse_blood.dart';
import 'package:trifecta/screens/home_screen/nurse_hone_screen/nurse_screens/nurse_profile.dart';
import 'package:trifecta/screens/home_screen/nurse_hone_screen/nurse_screens/nurse_request.dart';
import 'package:trifecta/screens/login_screen/login_screen.dart';
import 'package:trifecta/shared/local/cache_helper.dart';
import 'package:trifecta/shared/style/icon_broken.dart';

class NurseHomeScreen extends StatefulWidget {
  const NurseHomeScreen({Key? key}) : super(key: key);

  @override
  State<NurseHomeScreen> createState() => _NurseHomeScreenState();
}

class _NurseHomeScreenState extends State<NurseHomeScreen> {
  int currentScreen = 0;

  List<Widget> itemsScreens = [
    const NurseRequestScreen(),
    const NurseBloodScreen(),
    const NurseProfileScreen(),
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
