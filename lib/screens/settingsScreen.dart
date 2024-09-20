
import 'package:appnationdoggy/theme/sizeconfig.dart';
import 'package:appnationdoggy/theme/theme.dart';
import 'package:appnationdoggy/theme/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static const platform = MethodChannel('platform_channel');

  String _platformVersion = 'Unknown';

  Future<void> _getPlatformVersion() async {
    String platformVersion;
    try {
      platformVersion = await platform.invokeMethod('getPlatformVersion');
    } on PlatformException catch (e) {
      platformVersion = "'${e.message}'.";
    }

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  void initState() {
    super.initState();
    _getPlatformVersion();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          color: AppTheme.background,
          padding: EdgeInsets.fromLTRB(
              paddingHorizontal,
              getPaddingScreenTopHeight() + paddingHorizontal,
              paddingHorizontal,
              paddingHorizontal),
          child: ListView(
            controller: scrollController,
            padding: paddingZero,
            children: [
              SettingsComponent(
                icon: FontAwesomeIcons.infoCircle,
                componentText: 'Help Us',
              ),
              SettingsComponent(
                icon: FontAwesomeIcons.star,
                componentText: 'Rate Us',
              ),
              SettingsComponent(
                icon: FontAwesomeIcons.arrowUpFromBracket,
                componentText: 'Share with Friends',
              ),
              SettingsComponent(
                icon: FontAwesomeIcons.fileContract,
                componentText: 'Terms of Use',
              ),
              SettingsComponent(
                icon: FontAwesomeIcons.a,
                componentText: 'Help Us',
              ),
              SettingsComponent(
                icon: FontAwesomeIcons.codeBranch,
                componentText: 'OS Version',
                infoText: AppText(
                  text: _platformVersion,
                  size: 13,
                  color: HexColor('#3C3C43'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SettingsComponent extends StatelessWidget {
  const SettingsComponent({
    super.key,
    required this.icon,
    required this.componentText,
    this.infoText,
  });
  final IconData icon;
  final String componentText;
  final Widget? infoText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: paddingHorizontal),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(color: HexColor('#E5E5EA'), width: 2),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              FaIcon(
                icon,
                size: 16,
              ),
              Container(
                  padding: EdgeInsets.only(left: paddingHorizontal * .5),
                  child: AppLargeText(
                    text: componentText,
                    size: 16,
                  )),
            ],
          ),
          infoText ??
              FaIcon(
                FontAwesomeIcons.arrowUpRightFromSquare,
                size: 16,
                color: HexColor('#C7C7CC'),
              )
        ],
      ),
    );
  }
}
