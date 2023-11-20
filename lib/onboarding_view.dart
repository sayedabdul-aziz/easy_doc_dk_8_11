import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:se7ety_dk_8_11/core/app_color.dart';
import 'package:se7ety_dk_8_11/feature/welcome_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  var pageCon = PageController();
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const WelcomeView(),
                ));
              },
              child: Text(
                'تخطي',
                style: getbodyStyle(color: AppColors.color1),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageCon,
                itemCount: model.length,
                onPageChanged: (value) {
                  setState(() {
                    _index = value;
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SvgPicture.asset(model[index].image, height: 300),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        model[index].title,
                        style: getTitleStyle(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        model[index].desc,
                        textAlign: TextAlign.center,
                        style: getbodyStyle(),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  SmoothPageIndicator(
                      controller: pageCon, // PageController
                      count: model.length,
                      effect: WormEffect(
                        activeDotColor: AppColors.color1,
                        dotHeight: 10,
                      ),
                      onDotClicked: (index) {}),
                  const Spacer(),
                  _index == (model.length - 1)
                      ? GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const WelcomeView(),
                            ));
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                  color: AppColors.color1,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                'هيا بنا',
                                style: TextStyle(color: AppColors.white),
                              )),
                        )
                      : const SizedBox()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OnBoardingModel {
  final String image;
  final String title;
  final String desc;

  OnBoardingModel(
      {required this.image, required this.title, required this.desc});
}

List<OnBoardingModel> model = [
  OnBoardingModel(
      image: 'assets/on1.svg',
      title: 'ابحث عن دكتور متخصص',
      desc:
          'اكتشف مجموعة واسعة من الأطباء الخبراء والمتخصصين في مختلف المجالات.'),
  OnBoardingModel(
      image: 'assets/on2.svg',
      title: 'سهولة الحجز',
      desc: 'احجز المواعيد بضغطة زرار في أي وقت وفي أي مكان.'),
  OnBoardingModel(
      image: 'assets/on3.svg',
      title: 'آمن وسري',
      desc: 'كن مطمئنًا لأن خصوصيتك وأمانك هما أهم أولوياتنا.')
];
