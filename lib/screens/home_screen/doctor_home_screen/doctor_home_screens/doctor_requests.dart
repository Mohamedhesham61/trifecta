import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trifecta/components/constant.dart';
import 'package:trifecta/models/request_doctor_model.dart';
import 'package:trifecta/screens/home_screen/cubit/trifecta_cubit.dart';
import 'package:trifecta/screens/home_screen/cubit/trifecta_states.dart';

class DoctorRequestScreen extends StatelessWidget {
  const DoctorRequestScreen({Key? key}) : super(key: key);

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
            var doctorList = TrifectaCubit.get(context).doctorRequestModel;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16,),
                  Text('Welcome Dr. ${TrifectaCubit.get(context).userData?.name} 👋🏻',
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppin',
                    ),
                  ),
                  const SizedBox(height: 24,),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context,index)=> buildDoctorRequest(doctorList[index], index),
                      separatorBuilder: (context,index)=>const SizedBox(height: 16,),
                      itemCount:doctorList.length,
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
                  child:  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('${doctor.serviceType}',
                        style: const TextStyle(
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
            Text('Name: ${doctor.name}',
              style: const TextStyle(
                fontFamily: 'Poopin',
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 16,),
            Text('Phone: ${doctor.phone}',
              style: const TextStyle(
                fontFamily: 'Poopin',
                fontSize: 17,
              ),
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
}
