import 'package:appnationdoggy/core/classes/bloc/dog_bloc.dart';
import 'package:appnationdoggy/core/classes/dog.dart';
import 'package:appnationdoggy/theme/sizeconfig.dart';
import 'package:appnationdoggy/theme/theme.dart';
import 'package:appnationdoggy/theme/widgets/logoContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DogBloc>().add(FetchDogs());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DogBloc, DogState>(
      listener: (context, state) {
        if (state is DogLoaded) {
          // Eğer veri başarıyla yüklendiyse ana ekrana yönlendir
          Navigator.pushNamed(
            context,
            '/home'
          );
        } else if (state is DogError) {
          print('Veri yüklenemedi: ${state.message}');
        }
      },
      child: Container(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
          top: getPaddingScreenTopHeight(),
          bottom: getPaddingScreenBottomHeight(),
        ),
        color: AppTheme.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Logo(),
            Padding(
              padding: EdgeInsets.only(bottom: paddingHorizontal),
              child: Center(
                child: Container(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    color: AppTheme.textColor,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
