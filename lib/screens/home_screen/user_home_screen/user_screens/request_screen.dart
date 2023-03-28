
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trifecta/components/components.dart';
import 'package:trifecta/components/constant.dart';
import 'package:trifecta/screens/home_screen/cubit/trifecta_cubit.dart';
import 'package:trifecta/screens/home_screen/cubit/trifecta_states.dart';
import 'package:trifecta/screens/home_screen/user_home_screen/requests_screen/blood_donation.dart';
import 'package:trifecta/screens/home_screen/user_home_screen/requests_screen/heath_care_request.dart';
import 'package:trifecta/screens/home_screen/user_home_screen/requests_screen/request_doctor.dart';
import 'package:trifecta/screens/home_screen/user_home_screen/requests_screen/request_ride.dart';

class RequestUserScreen extends StatelessWidget {
  const RequestUserScreen ({Key? key}) : super(key: key);
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
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16,),
                        Text('Welcome ${TrifectaCubit.get(context).userData?.name} 👋🏻',
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'Poppin',
                          ),
                        ),
                        const SizedBox(height: 24,),
                        defaultButton(
                            backgroundColor: primaryColor,
                            radius: 100,
                            height: 72,
                            text: 'In dangerous case Need Help? SOS!',
                            onPressed: (){}
                        ),
                        const SizedBox(height: 16,),
                        Container(
                          height: 2,
                          color: const Color(0xffEDDEE8),
                        ),
                        const SizedBox(height: 16,),
                        const Text('If not, How can we help you today?',
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'Poppin',
                          ),
                        ),
                        const SizedBox(height: 16,),
                        Container(
                          height: 130,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: MaterialButton(
                            onPressed: (){navigateTo(context, const HealthCareRequest());},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                children: [
                                  Image.asset('assets/images/health_care.png',height: 30,),
                                  const SizedBox(width: 30,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text('Request Health Care Staff Member',
                                          style: TextStyle(
                                            fontFamily: 'Poppin',
                                            fontSize: 17,
                                          ),
                                        ),
                                        const SizedBox(height: 8,),
                                        Row(
                                          children: [
                                            buildSuchAsContainer(text: 'Elder'),
                                            const SizedBox(width: 8,),
                                            buildSuchAsContainer(text: 'Special Needs'),
                                            const SizedBox(width: 8,),
                                            buildSuchAsContainer(text: 'Others'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16,),
                        Container(
                          height: 130,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: MaterialButton(
                            onPressed: (){navigateTo(context, const RequestRide());},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                children: [
                                  Image.asset('assets/images/ride.png',height: 30,),
                                  const SizedBox(width: 30,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text('Request a Rides',
                                          style: TextStyle(
                                            fontFamily: 'Poppin',
                                            fontSize: 17,
                                          ),
                                        ),
                                        const SizedBox(height: 8,),
                                        Row(
                                          children: [
                                            buildSuchAsContainer(text: 'Move Around'),
                                            const SizedBox(width: 8,),
                                            buildSuchAsContainer(text: 'Reach Places'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16,),
                        Container(
                          height: 130,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: MaterialButton(
                            onPressed: (){navigateTo(context,const RequestDoctor());},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                children: [
                                  Image.asset('assets/images/doctor.png',height: 30,),
                                  const SizedBox(width: 30,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text('Request a Doctor',
                                          style: TextStyle(
                                            fontFamily: 'Poppin',
                                            fontSize: 17,
                                          ),
                                        ),
                                        const SizedBox(height: 8,),
                                        Row(
                                          children: [
                                            buildSuchAsContainer(text: 'Medical Needs'),
                                            const SizedBox(width: 8,),
                                            buildSuchAsContainer(text: 'Specialist'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16,),
                        Container(
                          height: 130,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: MaterialButton(
                            onPressed: (){navigateTo(context, const BloodDonation());},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                children: [
                                  Image.asset('assets/images/blood.png',height: 30,),
                                  const SizedBox(width: 30,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text('Blood Donation',
                                          style: TextStyle(
                                            fontFamily: 'Poppin',
                                            fontSize: 17,
                                          ),
                                        ),
                                        const SizedBox(height: 8,),
                                        Row(
                                          children: [
                                            buildSuchAsContainer(text: 'Blood Type'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
    );
  }
}
