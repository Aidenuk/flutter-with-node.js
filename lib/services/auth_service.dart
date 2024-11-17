// import 'dart:convert';

// import 'package:clone_carrot/constants/error_handling.dart';
// import 'package:clone_carrot/constants/utils.dart';
// import 'package:clone_carrot/home/screen/home_screen.dart';
// import 'package:clone_carrot/models/user.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:clone_carrot/constants/global_variables.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:provider/provider.dart';
// import 'package:clone_carrot/provider/user_provider.dart';

// class AuthService {
//   void signUpUser({
//     required BuildContext context,
//     required String email,
//     required String password,
//     required String name,
//   }) async {
//     try {
//       User user = User(
//           id: "",
//           name: name,
//           email: email,
//           password: password,
//           address: "",
//           type: "",
//           token: "");
//       http.Response res = await http.post(
//         Uri.parse('$uri/api/signup'),
//         body: user.toJson(),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//       );
//       httpErrorHandle(
//           response: res,
//           context: context,
//           onSuccess: () {
//             showSnackBar(context, "account created!");
//           });
//     } catch (e) {
//       showSnackBar(context, e.toString());
//     }
//   }

//   void signInUser({
//     required BuildContext context,
//     required String email,
//     required String password,
//   }) async {
//     try {
//       http.Response res = await http.post(
//         Uri.parse('$uri/api/signin'),
//         body: jsonEncode({
//           'email': email,
//           'password': password,
//         }),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//       );
//       httpErrorHandle(
//         response: res,
//         context: context,
//         onSuccess: () async {
//           //사용자의 토큰값을 디바이스에 저장하기
//           SharedPreferences prefs = await SharedPreferences.getInstance();
//           Provider.of<UserProvider>(context, listen: false).setUser(res.body);
//           await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
//           if (context.mounted) {
//             Navigator.pushNamedAndRemoveUntil(
//               context,
//               HomeScreen.routeName,
//               (route) => false,
//             );
//           } else {
//             debugPrint("Context is no longer mounted. Navigation skipped.");
//           }
//         },
//       );
//     } catch (e) {
//       showSnackBar(context, e.toString());
//     }
//   }

//   void getUserData(
//     BuildContext context,
//   ) async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? token = prefs.getString('x-auth-token');

//       if (token == null) {
//         prefs.setString('x-auth-token', '');
//       }

//       var tokenRes = await http.post(
//         Uri.parse('$uri/tokenIsValid'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//           'x-auth-token': token!
//         },
//       );

//       var response = jsonDecode(tokenRes.body);

//       if (response == true) {
//         http.Response userRes = await http.get(
//           Uri.parse('$uri/'),
//           headers: <String, String>{
//             'Content-Type': 'application/json; charset=UTF-8',
//             'x-auth-token': token
//           },
//         );

//         var userProvider = Provider.of<UserProvider>(context, listen: false);
//         userProvider.setUser(userRes.body);
//       }
//     } catch (e) {
//       showSnackBar(context, e.toString());
//     }
//   }
// }

import 'dart:convert';

import 'package:clone_carrot/constants/error_handling.dart';
import 'package:clone_carrot/constants/utils.dart';
import 'package:clone_carrot/home/screen/home_screen.dart';
import 'package:clone_carrot/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:clone_carrot/constants/global_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:clone_carrot/provider/user_provider.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: "",
        name: name,
        email: email,
        password: password,
        address: "",
        type: "",
        token: "",
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          if (context.mounted) {
            showSnackBar(context, "Account created!");
          }
        },
      );
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);

          if (context.mounted) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              HomeScreen.routeName,
              (route) => false,
            );
          }
        },
      );
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        if (context.mounted) {
          var userProvider = Provider.of<UserProvider>(context, listen: false);
          userProvider.setUser(userRes.body);
        }
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }
}
