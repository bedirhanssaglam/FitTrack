import 'package:fittrack/src/core/components/popup/log_out_popup.dart';
import 'package:fittrack/src/core/constants/app/app_constants.dart';
import 'package:fittrack/src/core/extensions/num_extensions.dart';
import 'package:fittrack/src/core/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../base/singleton/base_singleton.dart';
import '../../constants/enums/icon_enums.dart';

class ViewHeaderWidget extends StatelessWidget with BaseSingleton {
  const ViewHeaderWidget({
    super.key,
    required this.title,
    required this.onTap,
    this.isRegister = false,
  });

  final String title;
  final VoidCallback onTap;
  final bool? isRegister;

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
                    IconEnums.arrowBack.iconName.toSvg,
                  ),
                ),
                1.w.pw,
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppConstants.instance.fontFamily,
                    fontSize: 19.sp,
                  ),
                ),
              ],
            ),
            isRegister!
                ? const SizedBox.shrink()
                : InkWell(
                    onTap: () => PopupUtils.logOutPopup(context),
                    child: SvgPicture.asset(IconEnums.signOut.iconName.toSvg),
                  ),
          ],
        ),
      ),
    );
  }
}
