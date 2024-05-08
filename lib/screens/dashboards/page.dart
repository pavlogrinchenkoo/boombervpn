import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vpn/generated/assets.gen.dart';
import 'package:vpn/routers/routes.dart';
import 'package:vpn/style.dart';

import 'widgets/export.dart';

@RoutePage()
class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(context) {
    // TODO вынести в константы из билда
    final List<NavigationBarItem> items = [
      NavigationBarItem(
        icon: Assets.icons.profile.svg(),
        label: '',
      ),
      NavigationBarItem(
        icon: Assets.icons.home.svg(),
        label: '',
      ),
      NavigationBarItem(
        icon: Assets.icons.settings.svg(),
        label: '',
      ),
    ];
    return AutoTabsScaffold(
      extendBody: true,
      routes:  [
        const ProfileRoute(),
        const HomeRoute(),
        const SettingsRoute(),
        ListLocationsRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return Container(
          height: 70,
          padding: const EdgeInsets.only(top: 4, bottom: 4),
          decoration: BoxDecoration(
            color: BC.white,
          ),
          width: double.infinity,
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int i = 0; i < items.length; i++)
                  CustomIcon(
                    onTap: () {
                      tabsRouter.setActiveIndex(i);
                    },
                    icon: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            i == tabsRouter.activeIndex ? BC.purple : BC.grey,
                            BlendMode.srcIn,
                          ),
                          child: items[i].icon,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class NavigationBarItem {
  final Widget icon;
  final String label;

  NavigationBarItem({required this.icon, required this.label});
}
