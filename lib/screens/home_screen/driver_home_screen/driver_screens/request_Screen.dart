import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trifecta/components/constant.dart';
import 'package:trifecta/models/request_ride_model.dart';
import 'package:trifecta/screens/home_screen/cubit/trifecta_cubit.dart';
import 'package:trifecta/screens/home_screen/cubit/trifecta_states.dart';

class DriverRequestScreen extends StatefulWidget {
  const DriverRequestScreen({Key? key}) : super(key: key);

  @override
  State<DriverRequestScreen> createState() => _DriverRequestScreenState();
}

class _DriverRequestScreenState extends State<DriverRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          if(TrifectaCubit.get(context).userData == null)
          {
            TrifectaCubit.get(context).getMyData();
          }
          return BlocConsumer<TrifectaCubit,TrifectaStates>(
            listener: (context,state){},
            builder: (context,state){
              var rideList = TrifectaCubit.get(context).rideRequestModel;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16,),
                    Text('Welcome Driver. ${TrifectaCubit.get(context).userData?.name} 👋🏻',
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Poppin',
                      ),
                    ),
                    const SizedBox(height: 24,),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context,index)=> buildDoctorRequest(rideList[index], index),
                        separatorBuilder: (context,index)=>const SizedBox(height: 16,),
                        itemCount:rideList.length,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
    );
  }

  Widget buildDoctorRequest (RequestRide ride,index){
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
                  child:  Center(
                    child: Padding(
                      padding:const EdgeInsets.all(12.0),
                      child: Text('${ride.serviceType}',
                        style: const TextStyle(
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
            Text('Name: ${ride.name}',
              style: const TextStyle(
                fontFamily: 'Poopin',
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 16,),
            Text('Phone: ${ride.phone}',
              style: const TextStyle(
                fontFamily: 'Poopin',
                fontSize: 17,
              ),
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
}
