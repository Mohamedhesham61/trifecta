
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:trifecta/components/components.dart';
import 'package:trifecta/components/constant.dart';
import 'package:trifecta/screens/home_screen/cubit/trifecta_cubit.dart';
import 'package:trifecta/screens/home_screen/cubit/trifecta_states.dart';
import 'package:trifecta/shared/style/icon_broken.dart';

class RequestDoctor extends StatefulWidget {
  const RequestDoctor({Key? key}) : super(key: key);

  @override
  State<RequestDoctor> createState() => _RequestDoctorState();
}

class _RequestDoctorState extends State<RequestDoctor> {

  String location ='Null, Press Button';
  String address = 'search';
  Future<Position> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
  Future<void> getAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    address = '${place.street} ,${place.subAdministrativeArea} ,${place.administrativeArea} ,${place.country}';
    setState(()  {
    });
  }

  var now =  DateTime.now();
  var formatter =  DateFormat('dd / MM / yyyy').format(DateTime.now());

  var issueController  = TextEditingController();
  var locationController  = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<TrifectaCubit,TrifectaStates>(
        listener: (context,state){
          if(state is CreateRequestDoctorSuccessState)
            {
              showToast(message: 'Request Done', state: ToastStates.SUCCESS);
            }
        },
        builder: (context,state){
          var cubit = TrifectaCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30,),
                  Row(
                    children: [
                      IconButton(
                        onPressed: (){Navigator.pop(context);},
                        icon: const Icon(IconBroken.Arrow___Left_2),
                      ),
                      const Text('Request a Doctor',
                        style: TextStyle(
                            fontSize: 28,
                            fontFamily: 'Poppin'
                        ),
                      )
                    ],
                  ),
                  const Text('Where are you Located?',
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Poppin'
                    ),
                  ),
                  const SizedBox(height: 16,),
                  Row(
                    children: [
                      Expanded(
                        child: Text(address,
                          style: const TextStyle(
                              fontFamily: 'Poppin',
                              fontSize: 20
                          ),
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: MaterialButton(
                          onPressed: ()async{
                            Position position = await getGeoLocationPosition();
                            location ='Lat: ${position.latitude} , Long: ${position.longitude}';
                            getAddressFromLatLong(position);
                          },
                          child: const Text('Get Current Location',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  defaultTextFormField(
                    max: 5,
                    controller: issueController,
                    validator: (value){
                      if(value!.isEmpty){return 'Enter Your Issue';}
                      return null;
                    },
                    inputType: TextInputType.text,
                    label: 'Describe Your Issue',
                    prefix: Icons.description_outlined,
                  ),
                  const Spacer(),
                  ConditionalBuilder(
                    condition: state is! CreateRequestDoctorLoadingState,
                    builder: (BuildContext context)=> defaultButton(
                        text: 'Request',
                        onPressed: (){
                          cubit.createDoctorRequest(location: address, issue: issueController.text,date: formatter);
                        },
                        radius: 100,
                        textColor: Colors.white,
                        backgroundColor: primaryColor
                    ),
                    fallback: (BuildContext context)=>Center(child: CircularProgressIndicator(color: primaryColor,),),
                  ),
                  const SizedBox(height: 30,),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

