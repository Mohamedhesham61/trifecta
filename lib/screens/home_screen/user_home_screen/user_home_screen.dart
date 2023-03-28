
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trifecta/components/constant.dart';
import 'package:trifecta/screens/home_screen/cubit/trifecta_cubit.dart';
import 'package:trifecta/screens/home_screen/cubit/trifecta_states.dart';
import 'package:trifecta/screens/home_screen/user_home_screen/user_screens/profile_screen.dart';
import 'package:trifecta/screens/home_screen/user_home_screen/user_screens/request_screen.dart';
import 'package:trifecta/screens/home_screen/user_home_screen/user_screens/first_aids_screen.dart';
import 'package:trifecta/shared/style/icon_broken.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen ({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  int currentScreen = 0;

  List<Widget> itemsScreens = [
    const RequestUserScreen(),
    const TutorialUserScreen(),
    const ProfileUserScreen(),
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
          listener: (context,state){},
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
                    icon: Icon(Icons.menu_book),
                    label: 'Tutorial',
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
