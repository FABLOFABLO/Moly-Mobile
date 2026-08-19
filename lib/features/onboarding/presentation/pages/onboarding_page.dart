import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moly_mobile/common/widgets/moly_background.dart';
import 'package:moly_mobile/common/widgets/moly_button.dart';
import 'package:moly_mobile/common/widgets/moly_scaffold.dart';
import 'package:moly_mobile/core/constants/assets.dart';
import 'package:moly_mobile/core/constants/color.dart';
import 'package:moly_mobile/core/constants/text_style.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MolyScaffold(
      backgroundVariant: MolyBackgroundVariant.one,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const Spacer(flex: 3),
            SvgPicture.asset(SvgAssets.logo),
            const Spacer(flex: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '아직 계정이 없으신가요?',
                  style: MolyTextStyle.captionMedium.copyWith(
                    color: MolyColor.gray300,
                  ),
                ),
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () {
                    context.push('/signUp');
                  },
                  child: Text(
                    '회원가입',
                    style: MolyTextStyle.captionBold.copyWith(
                      color: MolyColor.brown100,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            MolyButton(
              label: '로그인',
              onPressed: () {
                context.push('/signIn');
              },
            ),
            const SizedBox(height: 12),
            MolyButton(
              label: '구글로 시작하기',
              onPressed: () {
                // TODO: oauth 연동
                context.go('/map');
              },
              backgroundColor: MolyColor.white,
              hasBorder: true,
              textStyle: MolyTextStyle.buttonBold.copyWith(
                color: MolyColor.brown100,
              ),
              icon: Image.asset(PngAssets.google),
            ),
            const SizedBox(height: 46),
          ],
        ),
      ),
    );
  }
}
