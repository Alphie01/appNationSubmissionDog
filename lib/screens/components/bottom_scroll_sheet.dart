import 'dart:ui';
import 'package:appnationdoggy/core/classes/dog.dart';
import 'package:appnationdoggy/theme/sizeconfig.dart';
import 'package:appnationdoggy/theme/theme.dart';
import 'package:appnationdoggy/theme/widgets/app_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomScrollSheet extends StatelessWidget {
  const BottomScrollSheet({super.key, required this.selectedDog});
  final Dog selectedDog;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      builder: (BuildContext context, ScrollController scrollController) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.transparent,
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                    color: AppTheme.background,
                    borderRadius: BorderRadius.circular(12)),
                height: 630,
                margin: EdgeInsets.symmetric(horizontal: paddingHorizontal),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(paddingHorizontal),
                        alignment: Alignment.topRight,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(12)),
                          image: DecorationImage(
                            image: selectedDog.dogImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            padding: EdgeInsets.all(paddingHorizontal * .5),
                            decoration: BoxDecoration(
                              color: AppTheme.background,
                              shape: BoxShape.circle,
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.x,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView(
                                padding: paddingZero,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(vertical: 11),
                                    child: AppLargeText(
                                      text: 'Tür',
                                      size: 20,
                                      color: AppTheme.contrastColor1,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(bottom: 11),
                                    width: 280,
                                    height: 2,
                                    color: HexColor('#F2F2F7'),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(bottom: 11),
                                    child: AppLargeText(
                                      text: selectedDog.dogName,
                                      size: 16,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(bottom: 11),
                                    child: AppLargeText(
                                      text: 'Alt Tür',
                                      size: 20,
                                      color: AppTheme.contrastColor1,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(bottom: 11),
                                    width: 280,
                                    height: 2,
                                    color: HexColor('#F2F2F7'),
                                  ),
                                  selectedDog.dogSubBreeed.isNotEmpty
                                      ? ListView.builder(
                                          itemCount:
                                              selectedDog.dogSubBreeed.length,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Container(
                                              alignment: Alignment.center,
                                              margin:
                                                  EdgeInsets.only(bottom: 11),
                                              child: AppLargeText(
                                                text: selectedDog
                                                    .dogSubBreeed[index],
                                                size: 16,
                                              ),
                                            );
                                          },
                                        )
                                      : AppLargeText(
                                          text: 'Alt Türü Bulunmamaktadır.',
                                          align: TextAlign.center,
                                        ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (builder) {
                                    return GeneratedPhotos(
                                        selectedDogPhoto: selectedDog.dogImage);
                                  },
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.all(paddingHorizontal),
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                decoration: BoxDecoration(
                                    color: AppTheme.contrastColor2,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AppLargeText(
                                      text: 'Generate',
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class GeneratedPhotos extends StatelessWidget {
  const GeneratedPhotos({super.key, required this.selectedDogPhoto});
  final CachedNetworkImageProvider selectedDogPhoto;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      builder: (BuildContext context, ScrollController scrollController) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.transparent,
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(paddingHorizontal),
                    width: 240,
                    height: 240,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12)),
                      image: DecorationImage(
                        image: selectedDogPhoto,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      margin: EdgeInsets.all(paddingHorizontal),
                      padding: EdgeInsets.all(paddingHorizontal * .5),
                      decoration: BoxDecoration(
                        color: AppTheme.background,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: FaIcon(FontAwesomeIcons.x),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
