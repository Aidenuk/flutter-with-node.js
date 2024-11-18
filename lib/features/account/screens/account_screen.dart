import 'package:clone_carrot/constants/global_variables.dart';
import 'package:clone_carrot/features/account/widgets/below_app_bar.dart';
import 'package:clone_carrot/features/account/widgets/top_buttons.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    child: RichText(
                        text: TextSpan(
                      text: 'Chang Market',
                      style: const TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 36, 77, 189),
                      ),
                    ))),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 15),
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(Icons.notifications_outlined),
                      ),
                      Icon(
                        Icons.search,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
      body: Column(
        children: const [
          BelowAppBar(),
          SizedBox(height: 10),
          TopButtons(),
          SizedBox(height: 20),
          // Orders(),
        ],
      ),
    );
  }
}
