import 'package:flutter/material.dart';
import 'package:vpn/generated/assets.gen.dart';
import 'package:vpn/style.dart';
import 'package:vpn/utils/spaces.dart';

class CustomCard extends StatelessWidget {
  final Function()? onTap;
  final String? title;
  final String? image;
  final String? status;
  final String? ip;
  final bool isConnected;
  const CustomCard({super.key, this.onTap, this.title, this.image, this.status, this.ip, required this.isConnected });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BRadius.r18,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(color: BC.darkGrey, borderRadius: BRadius.r18),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(color: BC.white, shape: BoxShape.circle, image: DecorationImage(image: NetworkImage(image ?? ''), fit: BoxFit.fill)),
            ),
            Space.w8,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                 isConnected ? 'Status: connected' : 'Status: not connected',
                  style: BS.bold12,
                ),
                Text(
                  'IP: 0.0.0.0 ${title ?? ''}',
                  style: BS.bold12,
                ),
              ],
            ),
            const Spacer(),
            Text(
              'SELECT LOCATION',
              style: BS.bold12,
              textAlign: TextAlign.end,
            ),
            Space.w4,
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: BC.white,
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
    return InkWell(
      onTap: onTap,
      borderRadius: BRadius.r18,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(color: BC.darkGrey, borderRadius: BRadius.r18),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(color: BC.white, shape: BoxShape.circle, image: DecorationImage(image: NetworkImage(image ?? 'https://picsum.photos/200/300', ), fit: BoxFit.cover)),
            ),
            Space.w8,
            Text(
              title ?? 'Status: not connected',
              style: BS.bold12,
            ),
            const Spacer(),
            Text(
              'Select',
              style: BS.bold12,
              textAlign: TextAlign.end,
            ),
            Space.w10,
            Assets.icons.signal1.svg(),
            Space.w4,
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: BC.white,
            ),
          ],
        ),
      ),
    );
  }
}
