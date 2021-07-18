import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:task/model/home_screen_response.dart';
import 'package:task/server/api_manager.dart';
import 'package:task/server/service_url.dart';
import 'package:task/util/colors/app_colors.dart';
import 'package:task/util/size_config/size_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  List<HomeScreenResponse> homeScreenResponse = new List<HomeScreenResponse>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoading = true;
    });
    getData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: AppColors.colorBackground,
                  height: kToolbarHeight,
                  child: Center(
                    child: Text('Dog\'s Path',
                        style: TextStyle(
                            color: AppColors.colorOffWhiteText, fontSize: 22)),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: homeScreenResponse.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 0.5,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        homeScreenResponse[index].title != null
                                            ? homeScreenResponse[index].title
                                            : '',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20)),
                                    Text(
                                        homeScreenResponse[index].subPaths !=
                                                null
                                            ? homeScreenResponse[index]
                                                    .subPaths
                                                    .length
                                                    .toString() +
                                                ' Sub paths'
                                            : '',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10)),
                                  ],
                                ),
                                Spacer(),
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 20,
                                  height: SizeConfig.blockSizeVertical * 3,
                                  color: Colors.black,
                                  child: Center(
                                    child: Text(
                                      'Open Path',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.colorBlueText),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 2,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 0.5,
                            ),
                            imageTextList(index),
                          ],
                        );
                      }),
                )
              ],
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Future<void> getData() async {
    await APIManager()
        .postData(ServiceUrl.path, '', MethodType.GET)
        .then((value) {
      if (value != null) {
        if (value.statusCode == 200) {
          json.decode(value.body).forEach((v) {
            homeScreenResponse.add(new HomeScreenResponse.fromJson(v));
          });
        }
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  Widget imageTextList(int index) {
    final ItemScrollController itemImageScrollController =
        ItemScrollController();
    final ItemScrollController itemTextScrollController =
        ItemScrollController();
    final ItemPositionsListener itemImagePositionsListener =
        ItemPositionsListener.create();
    final ItemPositionsListener itemTextPositionsListener =
        ItemPositionsListener.create();

    itemImagePositionsListener.itemPositions.addListener(() {});
    itemTextPositionsListener.itemPositions.addListener(() {});

    return Column(
      children: [
        Container(
          height: SizeConfig.blockSizeVertical * 25,
          child: new NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              double progress = scrollInfo.metrics.pixels - 60;
              int calculatedIndex = (progress ~/ 150) - 1;
              print('index $calculatedIndex');
              if (calculatedIndex > 0)
                itemTextScrollController.jumpTo(index: calculatedIndex);
              return false;
            },
            child: ScrollablePositionedList.builder(
                physics: BouncingScrollPhysics(),
                itemCount: homeScreenResponse[index].subPaths != null
                    ? homeScreenResponse[index].subPaths.length
                    : 0,
                scrollDirection: Axis.horizontal,
                itemScrollController: itemImageScrollController,
                itemPositionsListener: itemImagePositionsListener,
                // controller: _scrollController1,
                itemBuilder: (BuildContext context, int subPathIndex) {
                  return Image.network(
                      homeScreenResponse[index].subPaths[subPathIndex].image);
                }),
          ),
        ),
        Container(
          height: SizeConfig.blockSizeVertical * 5,
          color: Colors.black,
          child: ScrollablePositionedList.builder(
              physics: BouncingScrollPhysics(),
              itemCount: homeScreenResponse[index].subPaths != null
                  ? homeScreenResponse[index].subPaths.length
                  : 0,
              scrollDirection: Axis.horizontal,
              itemScrollController: itemTextScrollController,
              itemPositionsListener: itemTextPositionsListener,
              // controller: _scrollController2,
              itemBuilder: (BuildContext context, int subPathIndex) {
                return InkWell(
                  onTap: () async {
                    itemImageScrollController.scrollTo(
                        index: subPathIndex, duration: Duration(seconds: 2));
                    /*await _scrollController1.scrollToIndex(subPathIndex,
                        preferPosition: AutoScrollPosition.begin);*/
                    setState(() {
                      homeScreenResponse[index].subPaths.forEach((element) {
                        setState(() {
                          element.isSelected = false;
                        });
                      });
                      homeScreenResponse[index]
                          .subPaths[subPathIndex]
                          .isSelected = true;
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        homeScreenResponse[index].subPaths[subPathIndex].title,
                        style: TextStyle(
                            color: homeScreenResponse[index]
                                    .subPaths[subPathIndex]
                                    .isSelected
                                ? AppColors.colorWhite
                                : AppColors.colorBlueText),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 2,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: AppColors.colorWhite,
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 2,
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
