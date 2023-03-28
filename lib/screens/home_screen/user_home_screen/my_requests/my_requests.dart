import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trifecta/components/constant.dart';
import 'package:trifecta/models/request_blood_donation_model.dart';
import 'package:trifecta/models/request_doctor_model.dart';
import 'package:trifecta/models/request_heath_care_model.dart';
import 'package:trifecta/models/request_ride_model.dart';
import 'package:trifecta/screens/home_screen/cubit/trifecta_cubit.dart';
import 'package:trifecta/screens/home_screen/cubit/trifecta_states.dart';
import 'package:trifecta/shared/style/icon_broken.dart';

class MyRequests extends StatefulWidget {
  const MyRequests({Key? key}) : super(key: key);

  @override
  State<MyRequests> createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  bool healthcare = false;
  bool ride = false;
  bool doctor = false;
  bool blood = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<TrifectaCubit,TrifectaStates>(
        listener: (context,state){},
        builder: (context,state){
          var healthCareList = TrifectaCubit.get(context).healthCareModel;
          var rideList = TrifectaCubit.get(context).rideRequestModel;
          var doctorList = TrifectaCubit.get(context).doctorRequestModel;
          var bloodList = TrifectaCubit.get(context).bloodDonationRequestModel;
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 30,),
                  Row(
                    children: [
                      IconButton(
                        onPressed: (){Navigator.pop(context);},
                        icon: const Icon(IconBroken.Arrow___Left_2),
                      ),
                      const Text('My Requests',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Poppin'
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16,),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: healthcare? primaryColor:Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(width: 1,color: primaryColor),
                          ),
                          child: MaterialButton(
                            onPressed: (){
                              setState(() {
                                healthcare = true;
                                ride = false;
                                doctor = false;
                                blood = false;
                              });
                            },
                            child: Text('Health Care',
                              style: TextStyle(
                                fontSize: 14,
                                color: healthcare?Colors.white:primaryColor,
                                fontFamily: 'Poppin',
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: ride? primaryColor:Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(width: 1,color: primaryColor),
                          ),
                          child: MaterialButton(
                            onPressed: (){
                              setState(() {
                                healthcare = false;
                                ride = true;
                                doctor = false;
                                blood = false;
                              });
                            },
                            child: Text('Ride',
                              style: TextStyle(
                                fontSize: 16,
                                color: ride?Colors.white:primaryColor,
                                fontFamily: 'Poppin',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: doctor? primaryColor:Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(width: 1,color: primaryColor),
                          ),
                          child: MaterialButton(
                            onPressed: (){
                              setState(() {
                                healthcare = false;
                                ride = false;
                                doctor = true;
                                blood = false;
                              });
                            },
                            child: Text('Doctor',
                              style: TextStyle(
                                fontSize: 16,
                                color: doctor?Colors.white:primaryColor,
                                fontFamily: 'Poppin',
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: blood? primaryColor:Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(width: 1,color: primaryColor),
                          ),
                          child: MaterialButton(
                            onPressed: (){
                              setState(() {
                                healthcare = false;
                                ride = false;
                                doctor = false;
                                blood = true;
                              });
                            },
                            child: Text('Blood',
                              style: TextStyle(
                                fontSize: 16,
                                color: blood?Colors.white:primaryColor,
                                fontFamily: 'Poppin',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if(blood == false && healthcare == false && doctor == false && ride == false)
                    const SizedBox(height: 16,),
                  if(blood == false && healthcare == false && doctor == false && ride == false)
                    const Text('Choose a Request',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      fontFamily: 'Poppin'
                    ),
                  ),
                  const SizedBox(height: 16,),
                  if(healthcare)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context,index)=> buildHealthCareRequest(healthCareList[index], index),
                        separatorBuilder: (context,index)=>const SizedBox(height: 16,),
                        itemCount:healthCareList.length,
                      ),
                    )
                  else if(ride)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context,index)=> buildRideRequest(rideList[index], index),
                        separatorBuilder: (context,index)=>const SizedBox(height: 16,),
                        itemCount:rideList.length,
                      ),
                    )
                  else if(doctor)
                    Expanded(
                        child: ListView.separated(
                          itemBuilder: (context,index)=> buildDoctorRequest(doctorList[index], index),
                          separatorBuilder: (context,index)=>const SizedBox(height: 16,),
                          itemCount:doctorList.length,
                        ),
                      )
                  else if(blood)
                      Expanded(
                          child: ListView.separated(
                            itemBuilder: (context,index)=> buildBloodDonationRequest(bloodList[index], index),
                            separatorBuilder: (context,index)=>const SizedBox(height: 16,),
                            itemCount:bloodList.length,
                          ),
                        )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  Widget buildHealthCareRequest (RequestHealthCare healthCare,index){
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.all(8.0),
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text('Health Care',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppin'
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Text('${healthCare.date}',
                  style: const TextStyle(
                      fontSize: 17,
                      fontFamily: 'Poppin'
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16,),
            Text('Address: ${healthCare.location}',
              style: const TextStyle(
                fontFamily: 'Poopin',
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 16,),
            Text('Issue: ${healthCare.issue}',
              style: const TextStyle(
                fontFamily: 'Poopin',
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRideRequest (RequestRide ride,index){
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.all(8.0),
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text('Ride',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppin'
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Text('${ride.date}',
                  style: const TextStyle(
                      fontSize: 17,
                      fontFamily: 'Poppin'
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16,),
            Text('Address: ${ride.location}',
              style: const TextStyle(
                fontFamily: 'Poopin',
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 16,),
            Text('Issue: ${ride.issue}',
              style: const TextStyle(
                fontFamily: 'Poopin',
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDoctorRequest (RequestDoctor doctor,index){
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.all(8.0),
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text('Doctor',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppin'
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Text('${doctor.date}',
                  style: const TextStyle(
                      fontSize: 17,
                      fontFamily: 'Poppin'
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16,),
            Text('Address: ${doctor.location}',
              style: const TextStyle(
                fontFamily: 'Poopin',
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 16,),
            Text('Issue: ${doctor.issue}',
              style: const TextStyle(
                fontFamily: 'Poopin',
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBloodDonationRequest (RequestBloodDonation blood,index){
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.all(8.0),
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text('Blood Donation',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppin'
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Text('${blood.date}',
                  style: const TextStyle(
                      fontSize: 17,
                      fontFamily: 'Poppin'
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16,),
            Text('Service Type: ${blood.type}',
              style: const TextStyle(
                fontFamily: 'Poopin',
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 16,),
            Text('Blood Type: ${blood.bloodType}',
              style: const TextStyle(
                fontFamily: 'Poopin',
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 16,),
            Text('Name to Contact: ${blood.name}',
              style: const TextStyle(
                fontFamily: 'Poopin',
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 16,),
            Text('Phone: ${blood.phone}',
              style: const TextStyle(
                fontFamily: 'Poopin',
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 16,),
            Text('Address: ${blood.location}',
              style: const TextStyle(
                fontFamily: 'Poopin',
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 16,),
            Text('Issue: ${blood.note}',
              style: const TextStyle(
                fontFamily: 'Poopin',
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
