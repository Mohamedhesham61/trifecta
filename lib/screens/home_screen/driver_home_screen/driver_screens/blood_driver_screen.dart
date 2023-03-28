import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trifecta/components/constant.dart';
import 'package:trifecta/models/request_blood_donation_model.dart';
import 'package:trifecta/screens/home_screen/cubit/trifecta_cubit.dart';
import 'package:trifecta/screens/home_screen/cubit/trifecta_states.dart';

class DriverBloodRequestScreen extends StatefulWidget {
  const DriverBloodRequestScreen({Key? key}) : super(key: key);

  @override
  State<DriverBloodRequestScreen> createState() => _DriverBloodRequestScreenState();
}

class _DriverBloodRequestScreenState extends State<DriverBloodRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrifectaCubit,TrifectaStates>(
      listener: (context,state){},
      builder: (context,state){
        var bloodList = TrifectaCubit.get(context).bloodDonationRequestModel;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16,),
              const Text('Blood Donation',
                style: TextStyle(
                  fontFamily: 'Poppin',
                  fontSize: 28,
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context,index)=> buildBloodDonationRequest(bloodList[index], index),
                  separatorBuilder: (context,index)=>const SizedBox(height: 16,),
                  itemCount:bloodList.length,
                ),
              )
            ],
          ),
        );
      },
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
