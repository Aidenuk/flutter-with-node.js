import 'package:clone_carrot/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: '구매내역',
              onTap: () {},
            ),
            AccountButton(
              text: '판매내역',
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            AccountButton(
              text: '장바구니',
              onTap: () => {},
            ),
            AccountButton(
              text: '로그아웃',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
