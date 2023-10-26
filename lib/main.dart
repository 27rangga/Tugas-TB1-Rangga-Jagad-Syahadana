import 'package:flutter/material.dart';

void main() {
  List<Map<String, String>> accounts = [
    {'email': 'example@gmail.com', 'password': 'example@gmail.com'}
  ];

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => LoginPage(accounts: accounts),
      '/home': (context) => HomePage(),
      '/forget_password': (context) => ForgetPasswordPage(),
      '/create_account': (context) => CreateAccountPage(
        accounts: accounts,
        onAccountCreated: (newAccount) {
          accounts.add(newAccount);
        },
      ),
    },
  ));
}


class LoginPage extends StatefulWidget {
  final List<Map<String, String>> accounts;

  LoginPage({required this.accounts});

  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';

  List<Map<String, String>> accounts = [
    {'email': 'example@gmail.com', 'password': 'example@gmail.com'}
  ];

  bool isValidCredentials() {
    for (var account in widget.accounts) {
      if (account['email'] == email && account['password'] == password) {
        return true;
      }
    }
    return false;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: Image.asset('images/flutter.png'),
              ),
              Container(
                width: 300.0,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                width: 300.0,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (isValidCredentials()) {
                    Navigator.pushNamed(context, '/home');
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Login Failed'),
                          content: Text('Account not found, please register on the create an account page.'),
                          actions: [
                            TextButton(
                              child: Text('Close'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text("Login"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/forget_password');
                },
                child: Text("Forget Password"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/create_account');
                },
                child: Text("Create Account"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class CreateAccountPage extends StatefulWidget {
  final List<Map<String, String>> accounts;
  final Function(Map<String, String>) onAccountCreated;

  CreateAccountPage({required this.accounts, required this.onAccountCreated});

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Image.asset('images/flutter.png'),
            ),
            Container(
              width: 300.0,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: 300.0,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (email.isNotEmpty && password.isNotEmpty) {
                  // Simpan akun yang dibuat ke dalam daftar akun
                  widget.onAccountCreated({'email': email, 'password': password});

                  // Kembali ke halaman login
                  Navigator.pop(context);
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Create Account Failed'),
                        content: Text('Email and password are required.'),
                        actions: [
                          TextButton(
                            child: Text('Close'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text("Create Account"),
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: Container(
          width: 200.0,
          height: 100.0,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Text(
              "Welcome",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class ForgetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget Password Page"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 20.0),
                child: Image.asset('images/flutter.png'),
              ),
              Container(
                width: 300.0,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                width: 300.0,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "New Password",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                width: 300.0,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}







