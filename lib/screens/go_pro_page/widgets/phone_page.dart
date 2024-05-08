import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vpn/generated/assets.gen.dart';
import 'package:vpn/generated/l10n.dart';
import 'package:vpn/screens/go_pro_page/bloc.dart';
import 'package:vpn/style.dart';
import 'package:vpn/utils/spaces.dart';

import 'custom_buy_button.dart';

class PhonePage extends StatelessWidget {
  final GoProBloc bloc;
  const PhonePage({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      backgroundColor: BC.white,
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
                    color: BC.black,
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
              CustomBuyButton(
                onTap: () => bloc.subscribe(context),
                title: s.one_month,
                price: '9.99',
                description: '\$/${s.month}',
              ),
              Space.h16,
              CustomBuyButton(
                onTap: () => bloc.subscribe(context),
                title: s.one_year,
                price: '4.99',
                description: '\$/${s.month}',
                discount: '50% OFF',
              ),
              Space.h32,
              GrayButton(onTap: () {}, title: s.try_premium_free),
              Space.h16,
              Text('${s.seven_days} \$/${s.month}',
                  style: BS.reg14.apply(color: BC.grey)),
            ],
          ),
        ],
      ),
    );
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