import 'dart:convert';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:video_player_app/video_info.dart';

import 'constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List info = [];

  _initData() {
    DefaultAssetBundle.of(context).loadString('json/info.json').then((value) {
      info = jsonDecode(value);
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    double _h = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.homePageBackground,
      body: Container(
        padding: const EdgeInsets.only(top: 65, left: 15, right: 15),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Training',
                  style: TextStyle(
                      fontSize: _w * 0.11,
                      color: AppColor.homePageTitle,
                      fontWeight: FontWeight.w700),
                ),
                Expanded(child: Container()),
                Icon(
                  Icons.arrow_back_ios,
                  size: _w / 19,
                  color: AppColor.homePageIcons,
                ),
                SizedBox(
                  width: _w * 0.001,
                ),
                Icon(
                  Icons.calendar_today_outlined,
                  size: _w / 15,
                  color: AppColor.homePageIcons,
                ),
                SizedBox(
                  width: _w * 0.014,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: _w / 19,
                  color: AppColor.homePageIcons,
                ),
              ],
            ),
            SizedBox(height: _h * 0.026),
            Row(
              children: [
                Text(
                  'Your Programs',
                  style: TextStyle(
                      fontSize: _w * 0.05,
                      color: AppColor.homePageTitle,
                      fontWeight: FontWeight.w700),
                ),
                Expanded(child: Container()),
                Text(
                  'Details',
                  style: TextStyle(
                      fontSize: _w * 0.05,
                      color: AppColor.homePageDetail,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(width: _w * 0.014),
                InkWell(
                  onTap: () {
                    Get.to(() => VideoInfo());
                  },
                  child: Icon(
                    Icons.arrow_forward,
                    size: _w / 19,
                    color: AppColor.homePageIcons,
                  ),
                ),
              ],
            ),
            SizedBox(height: _h * 0.025),
            Container(
              width: _w,
              height: _h * 0.259,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColor.gradientFirst.withOpacity(0.8),
                      AppColor.gradientSecond.withOpacity(0.9)
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(70),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(5, 10),
                        blurRadius: 20,
                        color: AppColor.gradientSecond.withOpacity(0.3))
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(left: 18, top: 24, right: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Next workout',
                      style: TextStyle(
                        fontSize: _w * 0.04,
                        color: AppColor.homePageContainerTextSmall,
                      ),
                    ),
                    SizedBox(
                      height: _w * 0.014,
                    ),
                    Text(
                      'Legs Toning',
                      style: TextStyle(
                        fontSize: _w * 0.07,
                        color: AppColor.homePageContainerTextSmall,
                      ),
                    ),
                    Text(
                      'and Glutues Workout',
                      style: TextStyle(
                        fontSize: _w * 0.07,
                        color: AppColor.homePageContainerTextSmall,
                      ),
                    ),
                    SizedBox(height: _h * 0.016),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.timer,
                              size: _w * 0.049,
                              color: AppColor.homePageContainerTextSmall,
                            ),
                            SizedBox(
                              width: _w * 0.014,
                            ),
                            Text(
                              '68 min',
                              style: TextStyle(
                                fontSize: _w * 0.04,
                                color: AppColor.homePageContainerTextSmall,
                              ),
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              boxShadow: [
                                BoxShadow(
                                    color: AppColor.gradientFirst,
                                    blurRadius: 10,
                                    offset: Offset(4, 8))
                              ]),
                          child: Icon(
                            Icons.play_circle_fill,
                            size: _w * 0.15,
                            color: AppColor.homePageContainerTextSmall,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 2),
            Container(
              height: _w * 0.365,
              width: _w,
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    width: _w,
                    height: _h * 0.2,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/card.jpg',
                            ),
                            fit: BoxFit.fill),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 40,
                              offset: Offset(8, 10),
                              color: AppColor.gradientSecond.withOpacity(0.3))
                        ]),
                  ),
                  Container(
                    height: _h * 0.2,
                    width: _w,
                    margin: const EdgeInsets.only(right: 200, bottom: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/figure.png',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    height: _w * 0.25,
                    margin: const EdgeInsets.only(left: 123, top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'You are doing great',
                          style: TextStyle(
                              fontSize: _w / 20,
                              fontWeight: FontWeight.bold,
                              color: AppColor.homePageDetail),
                        ),
                        SizedBox(height: _h / 100),
                        RichText(
                          text: TextSpan(
                              text: "keep it up\n",
                              style: TextStyle(
                                  fontSize: _w / 23,
                                  color: AppColor.homePagePlanColor),
                              children: [TextSpan(text: "Stick to your plan")]),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  'Area of Focus',
                  style: TextStyle(
                      fontSize: _w * 0.05,
                      fontWeight: FontWeight.w700,
                      color: AppColor.homePageTitle),
                ),
              ],
            ),
            Expanded(
                child: OverflowBox(
              maxWidth: _w * 0.9,
              child: ListView.builder(
                  itemCount: info.length.toDouble() ~/ 2.toInt(), //2
                  itemBuilder: (_, i) {
                    return Row(
                      children: [
                        Container(
                          width: _w * 0.45,
                          height: 170,
                          padding: EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 3,
                                  offset: Offset(5, 5),
                                  color:
                                      AppColor.gradientSecond.withOpacity(0.1)),
                              BoxShadow(
                                  blurRadius: 3,
                                  offset: Offset(-5, -5),
                                  color:
                                      AppColor.gradientSecond.withOpacity(0.1)),
                            ],
                            image: DecorationImage(
                                image: AssetImage(info[i]['img'])),
                          ),
                          child: Center(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                info[i]['title'],
                                style: TextStyle(
                                  fontSize: _w / 20,
                                  color: AppColor.homePageDetail,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            )),
          ],
        ),
      ),
    );
  }
}
