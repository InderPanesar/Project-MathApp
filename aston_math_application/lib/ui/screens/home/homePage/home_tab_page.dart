import 'package:aston_math_application/engine/auth/authentication_service.dart';
import 'package:aston_math_application/engine/model/UserDetails/UserDetails.dart';
import 'package:aston_math_application/engine/repository/user_details_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomeTabPage extends StatelessWidget {

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  UserDetailsRepository repository = GetIt.I();
  AuthenticationService service = GetIt.I();


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.red,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Name',
            ),
          ),
          TextFormField(
            controller: ageController,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Age',
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              backgroundColor: Colors.white,
            ),
            onPressed: () async {
              var details = UserDetails(name: nameController.text, age: ageController.text);
              print(FirebaseAuth.instance.currentUser!.uid);
              print(details.name);
              print(details.age);
              await repository.addUserDetails(details);
            },
            child: const Text('Submit'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              backgroundColor: Colors.white,
            ),
            onPressed: () async {
              await service.signOut();
            },
            child: const Text('Logout'),
          ),
        ],
      )
    );
  }
}