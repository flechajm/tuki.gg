import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../core/framework/bloc/injection_container.dart';
import '../../../core/framework/localization/localization.dart';
import '../../../core/framework/theme/theme_manager.dart';
import '../../../core/framework/util/app_settings.dart';
import '../../../core/framework/util/general_navigator.dart';
import '../../../domain/entities/store.dart';
import '../../cubit/stores/store_cubit.dart';
import '../../widgets/tuki_logo/tuki_logo.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  final Duration _splashDuration = const Duration(seconds: 2);
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    initLocalization();

    super.initState();
  }

  void initLocalization() async {
    await Localization.init();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: ThemeManager.kBackgroundColor,
        body: BlocProvider<StoresCubit>(
          create: (context) {
            if (AppSettings.dateStoresFetched == 0) {
              return sl<StoresCubit>()..getStoreLsit();
            } else {
              DateTime dateFetched = DateTime.fromMillisecondsSinceEpoch(AppSettings.dateStoresFetched);
              if (dateFetched.difference(DateTime.now()).inDays >= 7) {
                return sl<StoresCubit>()..getStoreLsit();
              } else {
                _goToHome();
                return sl<StoresCubit>();
              }
            }
          },
          child: BlocConsumer<StoresCubit, StoresState>(
            listener: (context, state) {
              if (state is StoresLoaded) {
                List<Store> stores = state.storeResponse.where((store) => store.isActive).toList();
                _goToHome(stores: stores);
              }
            },
            builder: (context, state) {
              return Container(
                decoration: BoxDecoration(
                  color: ThemeManager.kBackgroundColor,
                ),
                alignment: Alignment.center,
                child: FadeTransition(
                  opacity: _animationController.drive(CurveTween(curve: Curves.easeIn)),
                  child: const TukiLogo(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _goToHome({List<Store>? stores}) {
    Future.delayed(_splashDuration, () async {
      if (stores != null) {
        await AppSettings.setStores(stores);
        await AppSettings.setStoresFilter(_getMapStoresFilter(stores));
        await AppSettings.setDateStoresFetched(DateTime.now());
      }

      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);

      GeneralNavigator.pushReplacement(
        const HomeScreen(),
        transitionType: PageTransitionType.fade,
      );
    });
  }

  Map<String, bool> _getMapStoresFilter(List<Store> stores) {
    return {for (Store store in stores) store.id.toString(): true};
  }
}
