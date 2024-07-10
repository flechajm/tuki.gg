import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/framework/bloc/injection_container.dart';
import '../../../core/framework/localization/localization.dart';
import '../../../core/framework/theme/theme_manager.dart';
import '../../../core/framework/util/app_settings.dart';
import '../../../core/framework/util/lifecycle_event_handler.dart';
import '../../../core/framework/util/notification_service.dart';
import '../../../core/framework/util/util.dart';
import '../../../domain/entities/deal_info.dart';
import '../../../domain/usecases/deal_info/params/params_deal.dart';
import '../../cubit/deals/deals_cubit.dart';
import '../../widgets/common/center_circle_loading/center_circle_loading.dart';
import '../../widgets/common/cool_app_bar/cool_app_bar.dart';
import '../../widgets/common/simple_button/simple_button.dart';
import '../../widgets/common/simple_scroll/simple_scroll.dart';
import '../../widgets/error_message/error_message.dart';
import '../../widgets/game_card/game_card.dart';

class HomeScreen extends StatefulWidget {
  final String? openUrl;

  const HomeScreen({
    super.key,
    this.openUrl,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  late BuildContext _blocDealContext;

  List<DealInfo> _dealInfoList = [];
  bool _searchMode = false;
  bool _hasMoreItems = false;
  bool _isEmpty = false;

  ParamsDeal _paramsDeal = ParamsDeal(
    storeIds: AppSettings.getJoinedStoresId(),
    pageSize: AppSettings.pageSize,
    priceRange: RangeValues(AppSettings.startPriceRangeFilter, AppSettings.endPriceRangeFilter),
    metacriticScore: AppSettings.metacriticScoreFilter,
    steamRating: AppSettings.steamRatingFilter,
    aaa: AppSettings.isAAAGameFilter,
    onSale: AppSettings.isOnSaleFilter,
    sortBy: AppSettings.sortByOptionSelected,
    desc: AppSettings.sortIsDescending,
  );

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_handleScrollbar);

    if (widget.openUrl != null) {
      Util.openUrl(widget.openUrl!);
    }

    WidgetsBinding.instance.addObserver(LifecycleEventHandler(resumeCallBack: () async {
      if (mounted) NotificationService().updateNotificationsStatus();
    }));
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScrollbar);
    super.dispose();
  }

  void _handleScrollbar() {
    if (_scrollController.position.maxScrollExtent == _scrollController.offset && _hasMoreItems) {
      _blocDealContext.read<DealsCubit>().getDeals(_paramsDeal);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CoolAppBar(
        showBackButton: false,
        showLogo: true,
        searchMode: _searchMode,
        filterFunction: applyFilter,
        filterParams: _paramsDeal,
      ),
      body: BlocProvider<DealsCubit>(
        create: (context) => sl<DealsCubit>()..getDeals(_paramsDeal),
        child: BlocConsumer<DealsCubit, DealsState>(
          listener: (context, state) {
            if (state is DealsLoaded) {
              _isEmpty = state.dealsResponse.isEmpty;
              if (state.dealsResponse.isNotEmpty && state.dealsResponse.length >= 10) {
                _paramsDeal.pageNumber += 1;
                _hasMoreItems = true;
              } else {
                _hasMoreItems = false;
              }
            }
          },
          builder: (context, state) {
            _blocDealContext = context;
            if (state is DealsLoaded) {
              if (_dealInfoList.isEmpty) {
                _dealInfoList = state.dealsResponse;
              } else if (_dealInfoList != state.dealsResponse) {
                _dealInfoList.addAll(state.dealsResponse);
              }
            } else if (state is DealsError) {
              return ErrorMessage(
                repeat: false,
                image: "assets/images/general/error.json",
                text: state.failure.message,
                child: SimpleButton(
                  text: Localization.xHome.searchAgain,
                  onTap: () async => context.read<DealsCubit>().getDeals(_paramsDeal),
                ),
              );
            }

            return _isEmpty
                ? ErrorMessage(
                    image: "assets/images/general/empty_results.json",
                    text: Localization.xErrors.empty,
                    child: SimpleButton(
                      text: Localization.xHome.searchAgain,
                      onTap: () async => context.read<DealsCubit>().getDeals(_paramsDeal),
                    ),
                  )
                : RefreshIndicator(
                    displacement: 40,
                    backgroundColor: ThemeManager.kPrimaryColor,
                    color: Colors.white,
                    onRefresh: () async {
                      setState(() {
                        _paramsDeal.pageNumber = 0;
                      });
                      applyFilter(_paramsDeal);
                    },
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          child: SimpleScroll(
                            onlyDisableGlow: true,
                            child: ListView.builder(
                              controller: _scrollController,
                              padding: EdgeInsets.zero,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: _dealInfoList.length + 1,
                              itemBuilder: (context, index) {
                                if (state is DealsInitial || (state is DealsLoading && _paramsDeal.pageNumber == 0)) {
                                  return const CenterCircleLoading(heightDivider: 1.2);
                                }

                                if (index < _dealInfoList.length) {
                                  DealInfo deal = _dealInfoList[index];

                                  return GameCard(deal: deal);
                                } else if (_hasMoreItems) {
                                  return const SizedBox(
                                    height: 80,
                                    child: CenterCircleLoading(size: 20),
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  void applyFilter(ParamsDeal paramsDeal) {
    setState(() {
      _isEmpty = false;
      _hasMoreItems = false;
      _dealInfoList.clear();
      _paramsDeal = paramsDeal;
      _searchMode = false;
    });
    _blocDealContext.read<DealsCubit>().getDeals(_paramsDeal);
  }
}
