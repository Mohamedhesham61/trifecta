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

class HealthCareRequest extends StatefulWidget {
  const HealthCareRequest({Key? key}) : super(key: key);

  @override
  State<HealthCareRequest> createState() => _HealthCareRequestState();
}

class _HealthCareRequestState extends State<HealthCareRequest> {
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

  bool elder = false;
  bool special = false;
  bool other = false;
  var issueController  = TextEditingController();
  var situationController  = TextEditingController();
  Position? currentPosition;
  String? currentAddress;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<TrifectaCubit,TrifectaStates>(
        listener: (context,state){
          if(state is CreateRequestHealthCareSuccessState) {
            showToast(message: 'Request Done', state: ToastStates.SUCCESS);
          }
        },
        builder: (context, state){
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
                      const Text('Request Health Care Staff Member',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Poppin'
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 64,
                          decoration: BoxDecoration(
                            color: elder?primaryColor:Colors.white,
                            border: Border.all(color: primaryColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: MaterialButton(
                            onPressed: (){
                              setState(() {
                                elder = true;
                                special = false;
                                other = false;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/elder.png',height: 30,color: elder?Colors.white:primaryColor,),
                                const SizedBox(width: 10,),
                                SizedBox(
                                  width: 40,
                                  child: Text('Elder Care',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppin',
                                      color: elder?Colors.white:primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: Container(
                          height: 64,
                          decoration: BoxDecoration(
                            color: special?primaryColor:Colors.white,
                            border: Border.all(color: primaryColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: MaterialButton(
                            onPressed: (){
                              setState(() {
                                elder = false;
                                special = true;
                                other = false;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/special.png',height: 30,color: special?Colors.white:primaryColor,),
                                const SizedBox(width: 10,),
                                SizedBox(
                                  width: 50,
                                  child: Text('Special Care',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppin',
                                      color: special?Colors.white:primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              elder = false;
                              special = false;
                              other = true;
                            });
                          },
                          child: Container(
                            height: 64,
                            decoration: BoxDecoration(
                              color: other?primaryColor:Colors.white,
                              border: Border.all(color: primaryColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/blood.png',height: 30,color: other?Colors.white:primaryColor,),
                                const SizedBox(width: 10,),
                                SizedBox(
                                  width: 50,
                                  child: Text('Others',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: other?Colors.white:primaryColor,
                                      fontFamily: 'Poppin',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16,),
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
                  if(other)
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
                  if(elder == true || special == true)
                    defaultTextFormField(
                      max: 5,
                      controller: situationController,
                      validator: (value){
                        if(value!.isEmpty){return 'Enter Your Situation';}
                        return null;
                      },
                      inputType: TextInputType.text,
                      label: 'Describe Your Situation',
                      prefix: Icons.description_outlined,
                    ),
                  const Spacer(),
                  ConditionalBuilder(
                    condition: state is! CreateRequestHealthCareLoadingState,
                    builder: (BuildContext context) =>defaultButton(
                        text: 'Request',
                        onPressed: (){
                          String? text;
                          if(elder) {text = 'Elder Care';}
                          else if(special){text = 'Special Care';}
                          else {text = 'Others';}
                          cubit.createHealthRequest(
                            type: text,
                            location: address,
                            issue: other?issueController.text:situationController.text,
                            date:formatter
                          );
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
