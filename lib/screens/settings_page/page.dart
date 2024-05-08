import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vpn/generated/assets.gen.dart';
import 'package:vpn/generated/l10n.dart';
import 'package:vpn/routers/routes.dart';
import 'package:vpn/style.dart';
import 'package:vpn/utils/custom_stream_builder.dart';
import 'package:vpn/utils/spaces.dart';
import 'package:vpn/widgets/custom_buttom.dart';
import 'bloc.dart';

@RoutePage()
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SettingsBloc bloc = SettingsBloc();

  @override
  void initState() {
    bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return CustomStreamBuilder<ScreenState>(
        bloc: bloc,
        builder: (BuildContext context, ScreenState state) {
          return Scaffold(
            backgroundColor: BC.white,
            appBar: AppBar(
              backgroundColor: BC.white,
              title: Text(s.logo, style: BS.med20),
              centerTitle: false,
            ),
            body: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                _CustomContainer(
                  title: s.connection_mode,
                  name: s.open_vpn,
                  onTap: () {},
                  isShowButton: state.isOpenVpn,
                ),
                Space.h16,
                _CustomContainerSwitch(
                  title: s.kill_switch,
                  name: s.block_internet_when_connecting_or_changing_servers,
                  value: state.isBlockInternet,
                  isShowVip: true,
                  onTap: (value) => bloc.changeBlockInternet(state.isBlockInternet, context),
                ),
                Space.h16,
                _CustomContainerSwitch(
                  title: s.connection,
                  name: s.connect_when_prime_vpn_starts,
                  value: state.isPrimeVpn,
                  onTap: (value) => bloc.changePrimeVpn(state.isPrimeVpn),
                ),
                Space.h16,
                _CustomContainerSwitch(
                  title: s.kill_switch,
                  name: s.show_notification_when_prime_vpn_is_not_connected,
                  value: state.isShowNotification,
                  onTap: (value) => bloc.changeShowNotification(state.isShowNotification),
                ),
                Space.h32,
                CustomButtonGray(
                  onTap: () => bloc.logout(context),
                  text: s.logout,
                )
              ],
            ),
          );
        });
  }
}

class _CustomContainerSwitch extends StatelessWidget {
  final String title;
  final String name;
  final bool value;
  final bool? isShowVip;
  final Function(bool value)? onTap;

  const _CustomContainerSwitch(
      {super.key,
      required this.title,
      required this.name,
      this.onTap,
      required this.value,
      this.isShowVip = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: BS.reg14.apply(color: BC.grey),
            ),
            const Spacer(),
            if (isShowVip == true) Assets.icons.vector.svg(),
          ],
        ),
        Space.h16,
        Row(
          children: [
            Expanded(
                flex: 20,
                child: Text(
                  name,
                  style: BS.reg18,
                )),
            const Spacer(),
            Space.w22,
            Switch(
              value: value,
              onChanged: onTap,
              activeColor: BC.purple,
              inactiveThumbColor: BC.purple,
              inactiveTrackColor: BC.grey,
            ),
          ],
        ),
        Space.h16,
        Container(
          height: 1,
          color: BC.grey,
        ),
      ],
    );
  }
}

class _CustomContainer extends StatelessWidget {
  final String title;
  final String name;
  final Function()? onTap;
  final bool isShowButton;

  const _CustomContainer(
      {super.key,
      required this.title,
      required this.name,
      this.onTap,
      required this.isShowButton});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: BS.reg14.apply(color: BC.grey),
        ),
        Space.h16,
        Row(
          children: [
            Text(
              name,
              style: BS.reg18,
            ),
            const Spacer(),
            InkWell(
              onTap: onTap,
              borderRadius: BRadius.r50,
              child: Container(
                height: 22,
                width: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: isShowButton ? BC.purple : BC.grey),
                ),
                child: isShowButton
                    ? Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: BC.purple,
                        ),
                        margin: const EdgeInsets.all(4),
                      )
                    : null,
              ),
            ),
          ],
        ),
        Space.h16,
        Container(
          height: 1,
          color: BC.grey,
        ),
      ],
    );
  }
}
