// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoper/widgets/bottom_navbar.dart';
import '../../../model/user.dart';
import '../../../provider/user_controller.dart';

class AuthService {

  final baseUrl = 'http://192.168.8.105:3000';
  // sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserModel user = UserModel(
        id: '',
        name: name,
        password: password,
        email: email,
        address: '',
        type: '',
        token: '',
      );

      http.Response res = await http.post(
        Uri.parse('$baseUrl/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );


      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Logged in successfully',
            ),
          ),
        );

     
      } else if (res.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(jsonDecode(res.body)['msg'])),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              jsonDecode(res.body)['error'],
            ),
          ),
        );
      }
    } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
             e.toString(),
            ),
          ),
        );
    }
  }

  // sign in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$baseUrl/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Logged in successfully',
            ),
          ),
        );

        final SharedPreferences ref = await SharedPreferences.getInstance();

        Provider.of<UserProvider>(context, listen: false).setUser(res.body);
        ref.setString('x-auth-token', jsonDecode(res.body)['token']);
        Navigator.pushNamedAndRemoveUntil(
          context,
          BottomNavbr.routeName,
          (route) => false,
        );
      } else if (res.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(jsonDecode(res.body)['msg'])),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              jsonDecode(res.body)['error'],
            ),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  // get user data
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
        Uri.parse('$baseUrl/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$baseUrl/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      // showSnackBar(context, e.toString());
      print(e);
    }
  }
}
























//   Future<void> createAccount(
//       {required String email,
//       required String name,
//       required String password,
//       required BuildContext context}) async {
//     try {
//       final uri = Uri.parse('$baseUrl/api/signup');
//       UserModel userModel = UserModel(
//         id: '',
//         name: name,
//         email: email,
//         password: password,
//         address: '',
//         type: 'user',
//         token: '',
//       );
//       final res = await http.post(
//         uri,
//         body: userModel.toJson(),
//         headers: <String, String>{
//           'content-type': 'application/json; charset=utf-8'
//         },
//       );

//       if (res.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text(
//               'Account created successfully',
//             ),
//           ),
//         );
//       } else if (res.statusCode == 400) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(jsonDecode(res.body)['msg'])),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               jsonDecode(res.body)['error'],
//             ),
//           ),
//         );
//       }
//     } catch (e) {
//       {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               e.toString(),
//             ),
//           ),
//         );
//       }
//     }
//   }

//   //* Sign In

//   Future<void> signin(
//       {required String email,
//       required String password,
//       required BuildContext context}) async {
//     try {
//       final uri = Uri.parse('$baseUrl/api/signIn');

//       //create uri with my IP address and posrt 30000

//       final res = await http.post(
//         uri,
//         body: jsonEncode({
//           'email': email,
//           'password': password,
//         }),
//         headers: <String, String>{
//           'content-type': 'application/json; charset=utf-8'
//         },
//       );

//       if (res.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text(
//               'Logged in successfully',
//             ),
//           ),
//         );

//         final SharedPreferences ref = await SharedPreferences.getInstance();
      

//         Provider.of<UserProvider>(context, listen: false).setUser(res.body);
//         ref.setString('x-auth-token', jsonDecode(res.body)['token']);
//         Navigator.pushNamedAndRemoveUntil(
//           context,
//           HomeScreen.routeName,
//           (route) => false,
//         );
//       } else if (res.statusCode == 400) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(jsonDecode(res.body)['msg'])),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               jsonDecode(res.body)['error'],
//             ),
//           ),
//         );
//       }
//     } catch (e) {
//       {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               e.toString(),
//             ),
//           ),
//         );
//       }
//     }
//   }

// //* get user data

//   Future<void> getUserData(BuildContext context) async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? token = prefs.getString('x-auth-token');
//       // print(token);

//       if (token == null) {
//         prefs.setString('x-auth-token', '');
//       }

//       final uri = Uri.parse('$baseUrl/isTokenValid');

//       final tokenRes = await http.post(
//         uri,
//         headers: <String, String>{
//           'content-type': 'application/json; charset=utf-8',
//           'x-auth-token': token!
//         },
//       );

//       var response = jsonDecode(tokenRes.body);
//       // print(response);
//       if (response == true) {
//         final res = await http.get(
//           Uri.parse('$baseUrl/'),
//           headers: <String, String>{
//             'content-type': 'application/json; charset=utf-8',
//             'x-auth-token': token
//           },
//         );

//        Provider.of<UserProvider>(context, listen: false).setUser(res.body);
//       }

//       Navigator.pushNamedAndRemoveUntil(
//         context,
//         HomeScreen.routeName,
//         (route) => false,
//       );
//     } catch (e) {
//       {
//         // ScaffoldMessenger.of(context).showSnackBar(
//         //   SnackBar(
//         //     content: Text(
//         //       e.toString(),
//         //     ),
//         //   ),
//         // );
//       }
//     }
//   }
// }