import 'package:flutter/material.dart';
import 'package:vpn/generated/assets.gen.dart';
import 'package:vpn/generated/l10n.dart';
import 'package:vpn/style.dart';
import 'package:vpn/utils/spaces.dart';

class CustomCard extends StatelessWidget {
  final Function()? onTap;
  final String? title;
  final String? image;
  final String? status;
  final String ip;
  final bool isConnected;
  const CustomCard({super.key, this.onTap, this.title, this.image, this.status, required this.ip, required this.isConnected });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BRadius.r18,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(color: BC.white1, borderRadius: BRadius.r18,
        boxShadow: BShadow.light2),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(color: BC.black, shape: BoxShape.circle, image: DecorationImage(image: NetworkImage(image ?? ''), fit: BoxFit.fill)),
            ),
            Space.w8,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                 isConnected ? s.status_connected : s.status_not_connected,
                  style: BS.bold12,
                ),
                Text(
                  (ip.isNotEmpty) ?
                  'IP: ${ip ?? ''} ${title ?? ''}' : title ?? '',
                  style: BS.bold12,
                ),
              ],
            ),
            const Spacer(),
            Text(
              s.select_location,
              style: BS.bold12,
              textAlign: TextAlign.end,
            ),
            Space.w4,
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: BC.black,
            ),
          ],
        ),
      ),
    );
  }
}


class CustomCardLocation extends StatelessWidget {
  final Function()? onTap;
  final String? title;
  final String? image;
  const CustomCardLocation({super.key, this.onTap, this.title, this.image});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BRadius.r18,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(color: BC.white1, borderRadius: BRadius.r18, boxShadow: BShadow.light2),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(color: BC.black, shape: BoxShape.circle, image: DecorationImage(image: NetworkImage(image ?? 'https://picsum.photos/200/300', ), fit: BoxFit.cover)),
            ),
            Space.w8,
            Text(
              title ?? s.status_not_connected,
              style: BS.bold12,
            ),
            const Spacer(),
            Text(
              s.select,
              style: BS.bold12,
              textAlign: TextAlign.end,
            ),
            Space.w10,
            Assets.icons.signal1.svg(),
            Space.w4,
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: BC.black,
            ),
          ],
        ),
      ),
    );
  }
}
