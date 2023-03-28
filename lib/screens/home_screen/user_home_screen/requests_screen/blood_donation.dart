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

class BloodDonation extends StatefulWidget {
  const BloodDonation({Key? key}) : super(key: key);

  @override
  State<BloodDonation> createState() => _BloodDonationState();
}

class _BloodDonationState extends State<BloodDonation> {

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

  bool bloodDonor = false;
  bool donateBlood = false;
  bool a = false;
  bool b = false;
  bool aB = false;
  bool o = false;
  bool felix = false;
  bool aPo = false;
  bool aNe = false;
  bool bPo = false;
  bool bNe = false;
  bool aBPo = false;
  bool aBNe = false;
  bool oPo = false;
  bool oNe = false;
  var locationController  = TextEditingController();
  var nameController  = TextEditingController();
  var phoneController  = TextEditingController();
  var noteController  = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<TrifectaCubit,TrifectaStates>(
        listener: (context,state){
          if(state is CreateRequestBloodDonationSuccessState){
            showToast(message: 'Request Done', state: ToastStates.SUCCESS);
          }
        },
        builder: (context,state){
          var cubit = TrifectaCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
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
                        const Text('Blood Donation',
                          style: TextStyle(
                              fontSize: 28,
                              fontFamily: 'Poppin'
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 64,
                            decoration: BoxDecoration(
                              color: bloodDonor?primaryColor:Colors.white,
                              border: Border.all(color: primaryColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: MaterialButton(
                              onPressed: (){
                                setState(() {
                                  bloodDonor = true;
                                  donateBlood = false;
                                });
                              },
                              child: Text('Place a Request',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppin',
                                  color: bloodDonor?Colors.white:primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: Container(
                            height: 64,
                            decoration: BoxDecoration(
                              color: donateBlood?primaryColor:Colors.white,
                              border: Border.all(color: primaryColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: MaterialButton(
                              onPressed: (){
                                setState(() {
                                  bloodDonor = false;
                                  donateBlood = true;
                                });
                              },
                              child: Text('Donate Blood',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppin',
                                  color: donateBlood?Colors.white:primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                      ],
                    ),
                    const SizedBox(height: 16,),
                    const Text('Blood Type',
                      style: TextStyle(
                          fontFamily: 'Poopin',
                          fontSize: 17
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 64,
                                decoration: BoxDecoration(
                                  color: a?primaryColor:Colors.white,
                                  border: Border.all(color: primaryColor),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: MaterialButton(
                                  onPressed: (){
                                    setState(() {
                                      a = true;
                                      b = false;
                                      aB = false;
                                      o = false;
                                      felix = false;
                                    });
                                  },
                                  child: Text('A',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontFamily: 'Poppin',
                                      color: a?Colors.white:primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              child: Container(
                                height: 64,
                                decoration: BoxDecoration(
                                  color: b?primaryColor:Colors.white,
                                  border: Border.all(color: primaryColor),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: MaterialButton(
                                  onPressed: (){
                                    setState(() {
                                      a = false;
                                      b = true;
                                      aB = false;
                                      o = false;
                                      felix = false;
                                    });
                                  },
                                  child: Text('B',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontFamily: 'Poppin',
                                      color: b?Colors.white:primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              child: Container(
                                height: 64,
                                decoration: BoxDecoration(
                                  color: aB?primaryColor:Colors.white,
                                  border: Border.all(color: primaryColor),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: MaterialButton(
                                  onPressed: (){
                                    setState(() {
                                      a = false;
                                      b = false;
                                      aB = true;
                                      o = false;
                                      felix = false;
                                    });
                                  },
                                  child: Text('AB',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontFamily: 'Poppin',
                                      color: aB?Colors.white:primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              child: Container(
                                height: 64,
                                decoration: BoxDecoration(
                                  color: o?primaryColor:Colors.white,
                                  border: Border.all(color: primaryColor),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: MaterialButton(
                                  onPressed: (){
                                    setState(() {
                                      a = false;
                                      b = false;
                                      aB = false;
                                      o = true;
                                      felix = false;
                                    });
                                  },
                                  child: Text('O',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontFamily: 'Poppin',
                                      color: o?Colors.white:primaryColor,
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
                                height: 64,
                                decoration: BoxDecoration(
                                  color: felix?primaryColor:Colors.white,
                                  border: Border.all(color: primaryColor),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: MaterialButton(
                                  onPressed: (){
                                    setState(() {
                                      a = false;
                                      b = false;
                                      aB = false;
                                      o = false;
                                      felix = true;
                                    });
                                  },
                                  child: Text('Type Flexible',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontFamily: 'Poppin',
                                      color: felix?Colors.white:primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if(a == true||b==true||aB==true||o==true)
                      const SizedBox(height: 16,),
                    if(a == true||b==true||aB==true||o==true)
                      const Text('Choose Blood Type',
                        style: TextStyle(
                            fontFamily: 'Poopin',
                            fontSize: 17
                        ),
                      ),
                    if(a==true)
                      const SizedBox(height: 8,),
                    if(a==true)
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 64,
                              decoration: BoxDecoration(
                                color: aPo?primaryColor:Colors.white,
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: MaterialButton(
                                onPressed: (){
                                  setState(() {
                                    aPo = true;
                                    aNe = false;
                                  });
                                },
                                child: Text('A+',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontFamily: 'Poppin',
                                    color: aPo?Colors.white:primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Expanded(
                            child: Container(
                              height: 64,
                              decoration: BoxDecoration(
                                color: aNe?primaryColor:Colors.white,
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: MaterialButton(
                                onPressed: (){
                                  setState(() {
                                    aPo = false;
                                    aNe = true;
                                  });
                                },
                                child: Text('A-',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontFamily: 'Poppin',
                                    color: aNe?Colors.white:primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    if(b==true)
                      const SizedBox(height: 8,),
                    if(b==true)
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 64,
                              decoration: BoxDecoration(
                                color: bPo?primaryColor:Colors.white,
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: MaterialButton(
                                onPressed: (){
                                  setState(() {
                                    bPo = true;
                                    bNe = false;
                                  });
                                },
                                child: Text('B+',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontFamily: 'Poppin',
                                    color: bPo?Colors.white:primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Expanded(
                            child: Container(
                              height: 64,
                              decoration: BoxDecoration(
                                color: bNe?primaryColor:Colors.white,
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: MaterialButton(
                                onPressed: (){
                                  setState(() {
                                    bPo = false;
                                    bNe = true;
                                  });
                                },
                                child: Text('B-',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontFamily: 'Poppin',
                                    color: bNe?Colors.white:primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    if(aB==true)
                      const SizedBox(height: 8,),
                    if(aB==true)
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 64,
                              decoration: BoxDecoration(
                                color: aBPo?primaryColor:Colors.white,
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: MaterialButton(
                                onPressed: (){
                                  setState(() {
                                    aBPo = true;
                                    aBNe = false;
                                  });
                                },
                                child: Text('AB+',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontFamily: 'Poppin',
                                    color: aBPo?Colors.white:primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Expanded(
                            child: Container(
                              height: 64,
                              decoration: BoxDecoration(
                                color: aBNe?primaryColor:Colors.white,
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: MaterialButton(
                                onPressed: (){
                                  setState(() {
                                    aBPo = false;
                                    aBNe = true;
                                  });
                                },
                                child: Text('AB-',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontFamily: 'Poppin',
                                    color: aBNe?Colors.white:primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    if(o==true)
                      const SizedBox(height: 8,),
                    if(o==true)
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 64,
                              decoration: BoxDecoration(
                                color: oPo?primaryColor:Colors.white,
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: MaterialButton(
                                onPressed: (){
                                  setState(() {
                                    oPo = true;
                                    oNe = false;
                                  });
                                },
                                child: Text('O+',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontFamily: 'Poppin',
                                    color: oPo?Colors.white:primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Expanded(
                            child: Container(
                              height: 64,
                              decoration: BoxDecoration(
                                color: oNe?primaryColor:Colors.white,
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: MaterialButton(
                                onPressed: (){
                                  setState(() {
                                    oPo = false;
                                    oNe = true;
                                  });
                                },
                                child: Text('O-',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontFamily: 'Poppin',
                                    color: oNe?Colors.white:primaryColor,
                                  ),
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
                    defaultTextFormField(
                      controller: nameController,
                      validator: (value){
                        if(value!.isEmpty){return 'Enter Your Name';}
                        return null;
                      },
                      inputType: TextInputType.name,
                      label: 'Who to contact?',
                      prefix: IconBroken.User1,
                    ),
                    const SizedBox(height: 16,),
                    defaultTextFormField(
                      controller: phoneController,
                      validator: (value){
                        if(value!.isEmpty){return 'Enter Your Phone';}
                        return null;
                      },
                      inputType: TextInputType.phone,
                      label: 'Phone Number',
                      prefix: IconBroken.Call,
                    ),
                    const SizedBox(height: 16,),
                    defaultTextFormField(
                      max: 4,
                      controller: noteController,
                      validator: (value){
                        if(value!.isEmpty){return 'Enter Your Notes';}
                        return null;
                      },
                      inputType: TextInputType.text,
                      label: 'Notes',
                      prefix: Icons.note_add,
                    ),
                    const SizedBox(height: 16,),
                    ConditionalBuilder(
                      condition: state is! CreateRequestBloodDonationLoadingState,
                      builder: (BuildContext context) =>defaultButton(
                          text: 'Request',
                          onPressed: (){
                            String? bloodDonateType;
                            if(felix){bloodDonateType = 'Type Flexible';}
                            else if(aPo){bloodDonateType = 'A+';}
                            else if(aNe){bloodDonateType = 'A-';}
                            else if(bPo){bloodDonateType = 'B+';}
                            else if(bNe){bloodDonateType = 'B-';}
                            else if(aBPo){bloodDonateType = 'AB+';}
                            else if(aBNe){bloodDonateType = 'AB-';}
                            else if(oPo){bloodDonateType = 'O+';}
                            else if(oNe){bloodDonateType = 'O-';}
                            cubit.createBloodDonationRequest(
                              location: address,
                              note: noteController.text,
                              name: nameController.text,
                              phone: phoneController.text,
                              type: bloodDonor?'PLace a Request':'Donate Blood',
                              bloodType: bloodDonateType!,
                              date: formatter
                            );
                          },
                          radius: 100,
                          textColor: Colors.white,
                          backgroundColor: primaryColor
                      ),
                      fallback: (BuildContext context) =>Center(child: CircularProgressIndicator(color: primaryColor,),),
                    ),

                    const SizedBox(height: 30,),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}