import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:trifecta/components/constant.dart';
import 'package:trifecta/models/request_blood_donation_model.dart';
import 'package:trifecta/models/request_doctor_model.dart';
import 'package:trifecta/models/request_heath_care_model.dart';
import 'package:trifecta/models/request_ride_model.dart';
import 'package:trifecta/models/user_models.dart';
import 'package:trifecta/screens/home_screen/cubit/trifecta_states.dart';
import 'package:trifecta/shared/local/cache_helper.dart';



class TrifectaCubit extends Cubit<TrifectaStates>
{
  TrifectaCubit(): super(TrifectaInitialState());
  static TrifectaCubit get(context) => BlocProvider.of(context);



  UserModel? userData;
  void getMyData(){
    FirebaseFirestore.instance.collection("users").doc(uId??CacheHelper.getData(key: 'uId')).get().then((value){
      userData = UserModel.fromJson(value.data()!);
      emit(TrifectaGetUserSuccessState());
    });
  }



  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage ()async
  {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if(pickedImage !=null)
    {
      profileImage = File(pickedImage.path);
      emit(TrifectaPickProfileImageSuccessState());
    }
    else
    {
      emit(TrifectaPickProfileImageErrorState());
    }
  }


  //   upload profile image

  void uploadProfileImage({
    required String name,
    required String phone,
  })
  {
    emit(TrifectaUpdateImagesLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL()
          .then((value) {
        updateUser(
            name: name,
            phone: phone,
            profile: value
        );
      })
          .catchError((error){
        emit(TrifectaUploadProfileImageErrorState());
      });
    })
        .catchError((error){
      emit(TrifectaUploadProfileImageErrorState());
    });
  }



  //update user date
  void updateUser({
    required String name,
    required String phone,
    String? profile,
  })
  {
    emit(TrifectaUpdateUserLoadingState());
    UserModel model = UserModel(
      name: name,
      phone: phone,
      email: userData!.email,
      profileImage: profile ?? userData!.profileImage,
      uId: userData!.uId,
      applyingAs: userData!.applyingAs,
      gender: userData!.gender,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userData!.uId)
        .update(model.toMap())
        .then((value) {
      getMyData();
    }).catchError((error) {
      emit(TrifectaUpdateUserErrorState());
    });
  }

  // create request health care
  void createHealthRequest({
    required String type,
    required String location,
    required String issue,
    required String date,
  }) {
    emit(CreateRequestHealthCareLoadingState());
    RequestHealthCare model = RequestHealthCare(
      serviceType: 'Request Health Care',
      type: type,
      location: location,
      uId:userData!.uId,
      issue: issue,
      date: date,
      phone: userData!.phone,
      name: userData!.name,
    );

    FirebaseFirestore.instance
        .collection('RequestHealthCare')
        .add(model.toMap())
        .then((value)
    {
      emit(CreateRequestHealthCareSuccessState());
    })
        .catchError((error) {
      emit(CreateRequestHealthCareErrorState(error.toString()));
    });
  }


  List<RequestHealthCare> healthCareModel = [];

  void getHealthCareModel()
  {
    FirebaseFirestore.instance
        .collection('RequestHealthCare')
        .get()
        .then((value) {
      for (var element in value.docs) {
        element.reference.collection('likes').get().then((value){

          healthCareModel.add(RequestHealthCare.fromJson(element.data()));

          emit(GetRequestHealthCareSuccessState());
        }).catchError((error){});
      }
    })
        .catchError((error){
      emit(CreateRequestHealthCareErrorState(error.toString()));
    });
  }

  // create request ride
  void createRideRequest({
    required String location,
    required String issue,
    required String date,
  }) {
    emit(CreateRequestRideLoadingState());
    RequestRide model = RequestRide(
        serviceType: 'Request Ride',
        location: location,
        uId:userData!.uId,
        issue: issue,
        date:date,
        phone:userData!.phone,
      name: userData!.name,
    );

    FirebaseFirestore.instance
        .collection('RequestRide')
        .add(model.toMap())
        .then((value)
    {
      emit(CreateRequestRideSuccessState());
    })
        .catchError((error) {
      emit(CreateRequestRideErrorState(error.toString()));
    });
  }

  List<RequestRide> rideRequestModel = [];

  void getRideModel()
  {
    FirebaseFirestore.instance
        .collection('RequestRide')
        .get()
        .then((value) {
      for (var element in value.docs) {
        element.reference.collection('likes').get().then((value){

          rideRequestModel.add(RequestRide.fromJson(element.data()));

          emit(GetRequestRideSuccessState());
        }).catchError((error){});
      }
    })
        .catchError((error){
      emit(CreateRequestRideErrorState(error.toString()));
    });
  }

  // create request doctor
  void createDoctorRequest({
    required String location,
    required String issue,
    required String date,
  }) {
    emit(CreateRequestDoctorLoadingState());
    RequestDoctor model = RequestDoctor(
        serviceType: 'Request Doctor',
        location: location,
        uId:userData!.uId,
        issue: issue,
      date: date,
      name: userData!.name,
      phone: userData!.phone,
    );

    FirebaseFirestore.instance
        .collection('RequestDoctor')
        .add(model.toMap())
        .then((value)
    {
      emit(CreateRequestDoctorSuccessState());
    })
        .catchError((error) {
      emit(CreateRequestDoctorErrorState(error.toString()));
    });
  }
  List<RequestDoctor> doctorRequestModel = [];

  void getDoctorModel()
  {
    FirebaseFirestore.instance
        .collection('RequestDoctor')
        .get()
        .then((value) {
      for (var element in value.docs) {
        element.reference.collection('likes').get().then((value){

          doctorRequestModel.add(RequestDoctor.fromJson(element.data()));

          emit(GetRequestDoctorSuccessState());
        }).catchError((error){});
      }
    })
        .catchError((error){
      emit(CreateRequestDoctorErrorState(error.toString()));
    });
  }




  // create request blood donation
  void createBloodDonationRequest({
    required String location,
    required String note,
    required String name,
    required String phone,
    required String type,
    required String bloodType,
    required String date,
  }) {
    emit(CreateRequestBloodDonationLoadingState());
    RequestBloodDonation model = RequestBloodDonation(
      serviceType: 'Request Blood Donation',
      location: location,
      uId:userData!.uId,
      note: note,
      name: name,
      type: type,
      phone: phone,
      bloodType: bloodType,
      date: date,
    );

    FirebaseFirestore.instance
        .collection('RequestBloodDonation')
        .add(model.toMap())
        .then((value)
    {
      emit(CreateRequestBloodDonationSuccessState());
    })
        .catchError((error) {
      emit(CreateRequestBloodDonationErrorState(error.toString()));
    });
  }

  List<RequestBloodDonation> bloodDonationRequestModel = [];

  void getBloodDonationModel()
  {
    FirebaseFirestore.instance
        .collection('RequestBloodDonation')
        .get()
        .then((value) {
      for (var element in value.docs) {
        element.reference.collection('likes').get().then((value){

          bloodDonationRequestModel.add(RequestBloodDonation.fromJson(element.data()));

          emit(GetRequestBloodDonationSuccessState());
        }).catchError((error){});
      }
    })
        .catchError((error){
      emit(CreateRequestBloodDonationErrorState(error.toString()));
    });
  }


  void signOut() {

    FirebaseAuth.instance.signOut().then((value) {
      emit(TrifectaSignOutSuccessfully());
    }
    ).catchError((error){

      emit(TrifectaSignOutError(error.toString()));
    });
  }
}