import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trifecta/components/constant.dart';


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

class TutorialUserScreen extends StatefulWidget {
   const TutorialUserScreen({Key? key}) : super(key: key);

  @override
  State<TutorialUserScreen> createState() => _TutorialUserScreenState();
}

class _TutorialUserScreenState extends State<TutorialUserScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/burns.jpg',
      title: 'Burns',
      body: 'Cool the burn under cool running water for at least ten minutes. If the burn requires medical care, loosely  cover the burn with '
          'plastic wrap or a clean plastic bag. Otherwise, it does not need plastic covering.'
          'if necessary, call # # # or get someone else to do it.'
    ),
    BoardingModel(
        image: 'assets/images/bleeding.jpg',
        title: 'Bleeding',
        body: 'Put pressure on the wound with whatever is available to stop or slow down the flow of blood.'
            'If the bleeding is severe ,call # # # or get someone else to do it. Keep '
            'pressure on the wound until help arrives.'
    ),
    BoardingModel(
        image: 'assets/images/broken_bone.jpg',
        title: 'Broken Bone',
        body: 'Encourage the person to support the injury with their hand, or use a cushion or items of clothing to prevent unnecessary movement.'
            'If the injury area is obviously deformed, significantly painful or needed for transport. call # # # or get someone else to do it.'
            'Make sure the injury is supported until help arrives.'
    ),
    BoardingModel(
        image: 'assets/images/asthma.jpg',
        title: 'Asthma Attack',
        body:'Help the person sit in a comfortable position and help them take their medication,'
            'Reassure the person. If the attack becomes severe, the don\'t have their medication or they don\'t improve with medication,'
            ' call # # # or get someone else to do it.',
    ),
    BoardingModel(
        image: 'assets/images/head_injury.jpg',
        title: 'Head Injury',
        body: 'Ask them to rest and apply a cold compress to the injury.'
            'If they become confused, drowsy, vomit or if the fall was greater than 2 times their heights,'
            ' call # # # or get someone else to do it.'
    ),
    BoardingModel(
        image: 'assets/images/head_stroke.jpg',
        title: 'Head Stroke',
        body: 'Think F.A.S.T. Face: is there weakness on one side of their face? \n'
            'Arms: can their raise both arms?\n '
            'Speech: is their speech easily understood? \n'
            'Time: to call # # #. '
            'Immediately call # # # or get someone else to do it.'
            ' Talk to the person to reassure them while you wait for the ambulance.',
    ),
    BoardingModel(
        image: 'assets/images/heart_attack.jpg',
        title: 'Heart Attack',
        body: 'The person may have persistent vice-like chest pain, or isolated unexplained discomfort in arms neck, jaw, back, or stomach.'
            ' call # # # or get someone else to do it.'
            ' Give them aspirin, as long as they are not allergic. The best is one not enteric.'
            ' Make sure they are in a position that is comfortable for them.'
            ' Give them constant reassurance while waiting for the ambulance.'
    ),
    BoardingModel(
        image: 'assets/images/heat_stroke.jpg',
        title: 'Heat Stroke',
        body: 'The person\'s skin may be hot or red, and may also be dry or moist, they may be experiencing changes in consciousness, as well as vomiting'
            ' and a high body temperature. Call # # # as soon as possible, Move the person to a cooler place. Remove or loosen tight clothes and apply'
            ' cool, wet clothes or towels to the skin. Fan the person. if they are conscious, give a small amounts of cool water to drink. Make '
            ' sure they are drink slowly. If needed, continue rapid cooling  by applying ice or cold packs wrapped in a cloth to the wrists, '
            'ankles groin, neck, and armpits.'
    ),
    BoardingModel(
        image: 'assets/images/stings.jpg',
        title: 'Stings / Bites',
        body: 'Bites and Stings can cause serious injury or illness. Protect Yourself and your family by following these precautions for general '
            'bites and stings or those from ticks.'
    ),
    BoardingModel(
        image: 'assets/images/poisoning.jpg',
        title: 'Poisoning',
        body: 'Establish what the have token, when, and how much. '
            'Call POISON CONTROL, Call # # # if they become unconscious, have a change in behaviour, have difficulty breathing, '
            'or if you think they are suicidal.'
            ' Do not make the person sick or give them anything to drink unless instructed to do so by POISON CONTROL',
    ),
  ];

   var boardController = PageController();
  var _isLast = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const SizedBox(height: 16,),
          const Text('First Aids Tutorials',
            style: TextStyle(
              fontSize: 28,
              fontFamily: 'Poppin'
            ),
          ),
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
        ],
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
             fontSize: 35,
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
             fontSize: 17,
             fontFamily: 'Poppin'
         ),
       ),
       const SizedBox(
         height: 20,
       ),
     ],
   );
}
