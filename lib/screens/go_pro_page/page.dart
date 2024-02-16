import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vpn/generated/assets.gen.dart';
import 'package:vpn/generated/l10n.dart';
import 'package:vpn/style.dart';
import 'package:vpn/utils/custom_stream_builder.dart';
import 'package:vpn/utils/spaces.dart';
import 'bloc.dart';

@RoutePage()
class GoProPage extends StatefulWidget {
  const GoProPage({super.key});

  @override
  State<GoProPage> createState() => _GoProPageState();
}

class _GoProPageState extends State<GoProPage> {
  late GoProBloc bloc = GoProBloc();

  @override
  void initState() {
    bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return CustomStreamBuilder(
        bloc: bloc,
        builder: (BuildContext context, state) {
          return Scaffold(
            backgroundColor: BC.black,
            body: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Space.h24,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () => context.router.pop(),
                        icon: Icon(
                          Icons.close,
                          color: BC.white,
                        ))
                  ],
                ),
                Space.h32,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Assets.icons.premium.svg(),
                    Space.h16,
                    Text(s.premium_features, style: BS.med24),
                    GridView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 50,
                        childAspectRatio: 1.3,
                      ),
                      children: [
                        _CustomContainerGrid(
                          title: s.anonymous,
                          description: s.hide_your_ip_with_anonymous_surfing,
                          icon: Assets.icons.incognito.svg(),
                        ),
                        _CustomContainerGrid(
                          title: s.fast,
                          description: s.up_to_mb_s_bandwidth_to_explore,
                          icon: Assets.icons.rocket.svg(),
                        ),
                        _CustomContainerGrid(
                          title: s.remove_ads,
                          description: s.enjoy_the_app_without_annoying_ads,
                          icon: Assets.icons.add.svg(
                            width: 30,
                            height: 30,
                          ),
                        ),
                        _CustomContainerGrid(
                          title: s.secure,
                          description: s.transfer_traffic_viaencrypted_tunnel,
                          icon: Assets.icons.shieldCheck.svg(),
                        ),
                      ],
                    ),
                    Space.h32,
                    _CustomBuyButton(
                      onTap: () {},
                      title: s.one_month,
                      price: '9.99',
                      description: '\$/${s.month}',
                    ),
                    Space.h16,
                    _CustomBuyButton(
                      onTap: () {},
                      title: s.one_year,
                      price: '4.99',
                      description: '\$/${s.month}',
                      discount: '50% OFF',
                    ),
                    Space.h32,
                    _GrayButtton(onTap: () {}, title: s.try_premium_free),
                    Space.h16,
                    Text('${s.seven_days} \$/${s.month}',
                        style: BS.reg14.apply(color: BC.grey)),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

class _CustomContainerGrid extends StatelessWidget {
  final String title;
  final String description;
  final Widget icon;

  const _CustomContainerGrid(
      {super.key,
      required this.title,
      required this.description,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            icon,
            Space.w10,
            Text(title, style: BS.bold16),
          ],
        ),
        Space.h12,
        Text(description, style: BS.reg14),
      ],
    );
  }
}

class _CustomBuyButton extends StatelessWidget {
  final String title;
  final String price;
  final String description;
  final Function() onTap;
  final String? discount;

  const _CustomBuyButton(
      {super.key,
      required this.title,
      required this.price,
      required this.description,
      required this.onTap,
      this.discount});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BRadius.r30,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BRadius.r30,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [BC.braun, BC.yellow],
          ),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: BS.med18,
            ),
            Space.w4,
            if (discount != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BRadius.r20,
                  color: BC.white,
                ),
                child: Text(
                  discount ?? '',
                  style: BS.med10.apply(color: BC.braun),
                ),
              ),
            const Spacer(),
            Text(
              price,
              style: BS.bold24,
            ),
            Space.w4,
            Text(description, style: BS.med18),
          ],
        ),
      ),
    );
  }
}

class _GrayButtton extends StatelessWidget {
  final Function()? onTap;
  final String title;

  const _GrayButtton({super.key, this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BRadius.r30,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        decoration:
            BoxDecoration(borderRadius: BRadius.r30, color: BC.darkGrey),
        child: Center(
          child: Text(
            title,
            style: BS.bold16,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
