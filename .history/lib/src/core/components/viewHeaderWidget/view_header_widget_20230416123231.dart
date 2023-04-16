import 'package:fittrack/src/core/base/services/firebase_services.dart';
import 'package:fittrack/src/core/constants/enums/route_enums.dart';
import 'package:fittrack/src/core/extensions/num_extensions.dart';
import 'package:fittrack/src/core/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:sizer/sizer.dart';

import '../../base/singleton/base_singleton.dart';
import '../text/custom_text.dart';

class ViewHeaderWidget extends StatelessWidget with BaseSingleton {
  const ViewHeaderWidget({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15.h,
      width: double.infinity,
      color: colors.mainColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: onTap,
                  child: SvgPicture.asset(
                    "arrow_back".toSvg,
                  ),
                ),
                1.w.pw,
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Moderat',
                    fontSize: 14.sp,
                  ),
                
                ),
              ],
            ),
            InkWell(
              onTap: () async {
                FirebaseServices()
                    .signOut()
                    .then((_) => context.go(RouteEnums.login.routeName));
              },
              child: SvgPicture.asset("sign_out".toSvg),
            ),
          ],
        ),
      ),
    );
  }
}