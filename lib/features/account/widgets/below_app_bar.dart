import 'package:clone_carrot/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clone_carrot/provider/user_provider.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Container(
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      padding: const EdgeInsets.only(left: 25, right: 15, bottom: 10),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              text: '반가워요! ',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: "${user.name}님",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
