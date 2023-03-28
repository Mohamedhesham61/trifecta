import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trifecta/components/components.dart';
import 'package:trifecta/components/constant.dart';
import 'package:trifecta/screens/login_screen/login_screen.dart';
import 'package:trifecta/shared/local/cache_helper.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/onBoarding1.png',
      title: 'Save Lives',
      body: 'Trifecta App is an essential tool for emergencies that can help save lives. This app is designed to provide a fast and effective way to contact',
    ),
    BoardingModel(
        image: 'assets/images/onBoarding2.png',
        title: 'Ride Share',
        body: 'Trifecta Ride share is an excellent option for emergency transportation needs. Whether you need to get to a hospital quickly or make it to an important meeting on time'
    ),
    BoardingModel(
        image: 'assets/images/onBoarding3.png',
        title: 'Find Doctor',
        body: 'Trifecta Find Doctor Emergency is a comprehensive and efficient healthcare service that provides individuals with a convenient way to find a doctor in an emergency.'
    ),
  ];

  var boardController = PageController();

  var _isLast = false;

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(
          context,
          LoginScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: [
            defaultTextButton(
              function: (){
                CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
                  if (value) {
                    navigateAndFinish(
                      context,
                      LoginScreen(),
                    );
                  }
                });
              },
              text: 'Skip',
              color: const Color(0xffEFF1F1),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: boardController,
                  itemBuilder: (BuildContext context, int index) =>
                      buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                  onPageChanged: (index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        _isLast = true;
                      });
                    } else {
                      setState(() {
                        _isLast = false;
                      });
                    }
                  },
                ),
              ),
              SmoothPageIndicator(
                controller: boardController,
                count: boarding.length,
                effect:  ExpandingDotsEffect(
                  dotColor: const Color(0xffEFF1F1),
                  activeDotColor: primaryColor,
                  dotHeight: 4,
                  dotWidth: 10,
                  expansionFactor: 3,
                  spacing: 5
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: MaterialButton(
                  onPressed: () {
                    if (_isLast) {
                      CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
                        if (value) {
                          navigateAndFinish(
                            context,
                            LoginScreen(),
                          );
                        }
                      });
                    }
                    else
                    {
                      boardController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn
                      );
                    }
                  },
                  child: Text(
                    _isLast?'Get Started':'Next',
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontFamily: 'Poppin',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(height: 67,),
      Image(
        image: AssetImage(model.image,),
      ),
      Text(
        model.title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 32,
          fontFamily: 'Poppin'
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Text(
        model.body,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'Poppin'
        ),
      ),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}
