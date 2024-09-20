import 'dart:ui';

import 'package:appnationdoggy/core/classes/bloc/dog_bloc.dart';
import 'package:appnationdoggy/core/classes/dog.dart';
import 'package:appnationdoggy/screens/components/bottom_scroll_sheet.dart';
import 'package:appnationdoggy/screens/settingsScreen.dart';
import 'package:appnationdoggy/theme/sizeconfig.dart';
import 'package:appnationdoggy/theme/theme.dart';
import 'package:appnationdoggy/theme/widgets/app_text.dart';
import 'package:appnationdoggy/theme/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FocusNode focusNode = FocusNode();
  bool isFocused = false;
  DraggableScrollableController scrollController =
      DraggableScrollableController();
  @override
  void initState() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          isFocused = true;
        });
      } else {
        setState(() {
          isFocused = false;
        });
      }
    });

    scrollController.addListener(() {
      if (scrollController.pixels < 140) {
        FocusScope.of(context).requestFocus(FocusNode());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
        bottomNavigationBar: !isFocused
            ? Container(
                color: AppTheme.background1,
                height: 98,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.home,
                          color: AppTheme.contrastColor1,
                          size: 32,
                        ),
                        AppText(
                          text: 'Home',
                          color: AppTheme.contrastColor1,
                          size: 11,
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (builder) {
                            return SettingsScreen();
                          },
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.wrench,
                            size: 32,
                          ),
                          AppText(
                            text: 'Settings',
                            size: 11,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : null,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Stack(
            children: [
              BlocBuilder<DogBloc, DogState>(
                builder: (context, state) {
                  if (state is DogLoaded) {
                    return Container(
                      padding: EdgeInsets.only(
                          left: paddingHorizontal,
                          right: paddingHorizontal,
                          top: AppBar().preferredSize.height),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: paddingHorizontal * .5,
                          mainAxisSpacing: paddingHorizontal * .5,
                        ),
                        itemCount: state.dogs.length,
                        itemBuilder: (BuildContext context, int index) {
                          Dog dog = state.dogs[index];
                          return GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (builder) {
                                  return BottomScrollSheet(
                                    selectedDog: dog,
                                  );
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  Container(
                                    width: double.maxFinite,
                                    height: double.maxFinite,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          paddingHorizontal * .5),
                                      image: DecorationImage(
                                          image: dog.dogImage,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  ClipRect(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 5.0,
                                        sigmaY: 5.0,
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(.24),
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(8),
                                              bottomLeft: Radius.circular(8),
                                            )),
                                        child: AppText(
                                          fontWeight: FontWeight.w600,
                                          size: 20,
                                          color: Colors.white,
                                          text: dog.dogName,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    paddingHorizontal,
                    getPaddingScreenTopHeight() + paddingHorizontal,
                    paddingHorizontal,
                    paddingHorizontal),
                decoration: BoxDecoration(color: AppTheme.background),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppLargeText(
                      fontWeight: FontWeight.w600,
                      size: 20,
                      text: "\$appname",
                    )
                  ],
                ),
              ),
              !isFocused
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.all(paddingHorizontal),
                          margin: EdgeInsets.all(paddingHorizontal),
                          decoration: BoxDecoration(
                            color: AppTheme.background,
                            borderRadius:
                                BorderRadius.circular(paddingHorizontal * .5),
                          ),
                          alignment: Alignment.bottomCenter,
                          child: CustomTextfield(
                            focusNode: focusNode,
                            hintText: 'Arama',
                          ),
                        ),
                      ],
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      child: DraggableScrollableSheet(
                        initialChildSize: 0.2,
                        controller: scrollController,
                        minChildSize: 0.15,
                        maxChildSize: .8,
                        builder: (BuildContext context, scrollController) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.0),
                                topRight: Radius.circular(16.0),
                              ),
                            ),
                            // DraggableScrollableSheet içinde bir liste olmalı
                            child: ListView(
                              controller: scrollController,
                              padding: paddingZero,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      top: paddingHorizontal * .5),
                                  width: 32,
                                  height: 2,
                                  decoration: BoxDecoration(
                                    color: HexColor('#E5E5EA'),
                                    borderRadius: BorderRadius.circular(1),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(paddingHorizontal),
                                  margin: EdgeInsets.all(paddingHorizontal),
                                  decoration: BoxDecoration(
                                    color: AppTheme.background,
                                    borderRadius: BorderRadius.circular(
                                        paddingHorizontal * .5),
                                  ),
                                  alignment: Alignment.bottomCenter,
                                  child: CustomTextfield(
                                    focusNode: focusNode,
                                    hintText: 'Arama',
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
