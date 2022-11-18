import 'package:counseling_cell_app/counsellorHomePage.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';
const List<Widget> role = <Widget>[Text('Counsellor'), Text('User')];
final List<bool> _selectedRole = <bool>[true, false];
var _usernameController = TextEditingController();
var _passwordController = TextEditingController();
class LoginDemo extends StatefulWidget {
  const LoginDemo({
    super.key,
  });

  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  _LoginDemoState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: const Text(
            "Login",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Image.asset('assets/images/logo.png'),
                ToggleButtons(
                  isSelected: _selectedRole,
                  onPressed: (int index) {
                    setState(() {
                      // The button that is tapped is set to true, and the others to false.
                      for (int i = 0; i < _selectedRole.length; i++) {
                        _selectedRole[i] = i == index;
                      }
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(22)),
                  selectedBorderColor: Colors.blueGrey,
                  selectedColor: Colors.white,
                  fillColor: Colors.blueGrey,
                  color: Colors.white70,
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 100.0,
                  ),
                  children: role,
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Username',
                  ),
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(hintText: 'Enter Password'),
                ),
                ElevatedButton(
                    onPressed:  () {
                      if(_selectedRole[0]){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const counsellorHomePage()),
                        );
                      }
                      else{
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      }

                    },
                    child: const Text('Login')),

              ],
            ),
          ),
        ));
  }
}
