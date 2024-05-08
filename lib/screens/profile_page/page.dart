import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vpn/generated/assets.gen.dart';
import 'package:vpn/generated/l10n.dart';
import 'package:vpn/style.dart';
import 'package:vpn/utils/custom_stream_builder.dart';
import 'package:vpn/utils/spaces.dart';
import 'package:vpn/widgets/custom_indicator.dart';
import 'package:vpn/widgets/custom_scaffold.dart';
import 'bloc.dart';
import 'widgets/vip_indicator.dart';

final ProfileBloc blocProfile = ProfileBloc();

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    blocProfile.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomStreamBuilder<ScreenState>(
        bloc: blocProfile,
        builder: (context, state) {
          final s = S.of(context);
          return CustomScaffold(
              showGoPro: 'Yellow',
              body: (!(state.loading))
                  ? const CustomIndicator()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          Space.h32,
                          if (state.isVip) const VipIndicator(),
                          Space.h24,
                          Container(
                            padding: const EdgeInsets.fromLTRB(14, 21, 14, 11),
                            decoration: BoxDecoration(
                              borderRadius: BRadius.r18,
                              color: BC.darkGrey,
                            ),
                            child: Column(
                              children: [
                                _CustomText(
                                  name: s.email,
                                  description: state.user?.user?.email,
                                ),
                                _CustomText(
                                  name: s.country,
                                  description: state.user?.geoInfo?.countryName,
                                ),
                                _CustomText(
                                  name: s.city,
                                  description: state.user?.geoInfo?.stateProv,
                                ),
                                 _CustomText(
                                  name: 'ISP',
                                  description: state.user?.geoInfo?.isp,
                                ),
                                _CustomText(
                                  name: 'IP',
                                  description: state.user?.ip,
                                ),
                              ],
                            ),
                          ),
                          Space.h8,
                          Text(
                            s.this_information_is_only_available_on_your_device,
                            style: BS.bold12,
                          ),
                          Space.h32,
                          Space.h24,
                          if (!(state.isVip))
                            InkWell(
                              borderRadius: BRadius.r18,
                              onTap: () => blocProfile.goPro(context),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 21),
                                decoration: BoxDecoration(
                                  borderRadius: BRadius.r18,
                                  color: BC.darkGrey,
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GradientText(
                                        s.get_access_to_unlimited_speed_and_premium_locations,
                                        gradient: LinearGradient(
                                          colors: [BC.purple, BC.braun],
                                        ),
                                        style: BS.bold24,
                                      ),
                                      Space.h8,
                                      Icon(
                                        Icons.keyboard_arrow_down,
                                        color: BC.black,
                                        size: 24,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ));
        });
  }
}

class _CustomText extends StatelessWidget {
  final String name;
  final String? description;

  const _CustomText({super.key, required this.name, this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '$name:',
              style: BS.reg14,
            ),
            const Spacer(),
            Text(
              description ?? '',
              style: BS.reg14,
              textAlign: TextAlign.end,
            ),
          ],
        ),
        Space.h8,
        Container(
          height: 1,
          color: BC.black,
        ),
        Space.h10
      ],
    );
  }
}

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;

  const GradientText(this.text,
      {super.key, required this.style, required this.gradient});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: Text(
        text,
        style: style.copyWith(
            foreground: Paint()
              ..shader =
                  gradient.createShader(const Rect.fromLTRB(0, 0, 350, 0))),
        textAlign: TextAlign.center,
      ),
    );
  }
}
