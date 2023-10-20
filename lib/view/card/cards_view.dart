import 'package:card_swiper/card_swiper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../common/color_extension.dart';
import '../settings/settings_view.dart';

class CardsView extends StatefulWidget {
  const CardsView({super.key});

  @override
  State<CardsView> createState() => _CardsViewState();
}

class _CardsViewState extends State<CardsView> {
  List subArr = [
    {"name": "Spotify", "icon": "assets/img/spotify_logo.png", "price": "5.99"},
    {
      "name": "YouTube Premium",
      "icon": "assets/img/youtube_logo.png",
      "price": "18.99"
    },
    {
      "name": "Microsoft OneDrive",
      "icon": "assets/img/onedrive_logo.png",
      "price": "29.99"
    },
    {"name": "NetFlix", "icon": "assets/img/netflix_logo.png", "price": "15.00"}
  ];

  List carArr = [
    {
      "name": "Muhammed Sinan CP",
      "number": "**** **** **** 2197",
      "month_year": "08/27"
    },
    {
      "name": "Muhammed Sahal CP",
      "number": "**** **** **** 6512",
      "month_year": "12/27"
    },
    {
      "name": "Muhammed Sinan CP",
      "number": "**** **** **** 7932",
      "month_year": "07/24"
    },
    {
      "name": "Muhammed Nihal CP",
      "number": "**** **** **** 1864",
      "month_year": "05/30"
    },
  ];

  SwiperController controller = SwiperController();

  Widget buildSwiper() {
    return SafeArea(
      child: Swiper(
        itemCount: carArr.length,
        customLayoutOption: CustomLayoutOption(startIndex: -1, stateCount: 3)
          ..addRotate([-45.0 / 180, 0.0, 45.0 / 180])
          ..addTranslate([
            const Offset(-370.0, -40.0),
            Offset.zero,
            const Offset(370.0, -40.0),
          ]),
        fade: 1.0,
        onIndexChanged: (index) {
          print(index);
        },
        scale: 0.8,
        itemWidth: 232.0,
        itemHeight: 350,
        controller: controller,
        layout: SwiperLayout.STACK,
        viewportFraction: 0.8,
        itemBuilder: ((context, index) {
          var cObj = carArr[index] as Map? ?? {};
          return Container(
            decoration: BoxDecoration(
                color: TColor.gray70,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 4)
                ]),
            child: Stack(fit: StackFit.expand, children: [
              Image.asset(
                "assets/img/card_blank.png",
                width: 232.0,
                height: 350,
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset("assets/img/mastercard_logo.png", width: 50),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Master Card",
                    style: TextStyle(
                        color: TColor.white.withOpacity(0.4),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 115,
                  ),
                  Text(
                    cObj["name"] ?? "Muhammed Sinan CP",
                    style: TextStyle(
                        color: TColor.gray20,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    cObj["number"] ?? "**** **** **** 2197",
                    style: TextStyle(
                        color: TColor.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    cObj["month_year"] ?? "08/27",
                    style: TextStyle(
                        color: TColor.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )
            ]),
          );
        }),
        autoplayDisableOnInteraction: false,
        axisDirection: AxisDirection.right,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              width: double.infinity,
              height: 550,
              child: buildSwiper(),
            ),
            Column(
              children: [
                SafeArea(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Credit Cards",
                            style: TextStyle(
                                color: TColor.gray30,
                                fontSize: 19,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SettingsView()));
                              },
                              icon: Image.asset("assets/img/settings.png",
                                  width: 25, height: 25, color: TColor.gray30))
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: media.width * 1.15,
                ),
                Text(
                  "Subscriptions",
                  style: TextStyle(
                      color: TColor.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: subArr.map((sObj) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 8),
                      child: Image.asset(
                        sObj["icon"],
                        width: 40,
                        height: 40,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                      color: TColor.gray70.withOpacity(0.5),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {},
                          child: DottedBorder(
                            dashPattern: const [5, 4],
                            strokeWidth: 1,
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(16),
                            color: TColor.border.withOpacity(0.1),
                            child: Container(
                              height: 50,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Add new card",
                                    style: TextStyle(
                                        color: TColor.gray30,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Image.asset(
                                    "assets/img/add.png",
                                    width: 12,
                                    height: 12,
                                    color: TColor.gray30,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
