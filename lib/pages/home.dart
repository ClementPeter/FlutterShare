import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttershare/pages/pages.dart';
import 'package:fluttershare/pages/profile.dart';
import 'package:google_sign_in/google_sign_in.dart';

//Prompts Google Sign in Page
GoogleSignIn googleSignIn = GoogleSignIn();

//Home page of our App
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Boolean value to control the screen displayed
  bool isAuth = false;
  PageController _pageController = PageController();
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    //controls the pageview widget
    _pageController = PageController();

    //Check to see if any user is signed in
    googleSignIn.onCurrentUserChanged.listen(
      (event) {
        handleSignIn(event);
      },
      //callback to detect any Error in the user state
      onError: (error) {
        print("Error signing in $error");
      },
    );
    //Reauthenticating the user when app is reopened
    googleSignIn
        .signInSilently(suppressErrors: false)
        .then((account) => handleSignIn(account));
  }

  //Handles Sign In of users in the App and toggles Authentication Screen
  handleSignIn(GoogleSignInAccount account) {
    if (account != null) {
      print('User signed in $account');
      setState(() {
        bool isAuth = true;
      });
    } else {
      setState(() {
        bool isAuth = false;
      });
      print('User not signed in $account');
    }
  }

  //Method to prompt google sign in
  login() {
    googleSignIn.signIn();
  }

  //Method to prompt google sign out
  logOut() {
    googleSignIn.signOut();
  }

  // ignore: must_call_super
  void dispose() {
    super.dispose;
    _pageController.dispose();
  }

  //When PageView is changed update pageNumber
  onPagedChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  //When Bottom Nav bar is changed
  onTap(int pageIndex) {
    _pageController.jumpToPage(pageIndex);
    // _pageController.animateToPage(
    //   duration :Duration(millisecond:300)
    //   curve: Curves.
    //   //pageIndex,
    // );
  }

  //User Authenticated Screen --Shows when user is logged in
  Widget buildAuthScreen() {
    return Scaffold(
      body: PageView(
        children: [
          Timeline(),
          ActivityFeed(),
          Upload(),
          Search(),
          Profile(),
        ],
        controller: _pageController,
        onPageChanged: onPagedChanged(pageIndex),
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        onTap: onTap,
        currentIndex: pageIndex,
        activeColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.whatshot)),
          BottomNavigationBarItem(icon: Icon(Icons.photo_camera)),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle)),
        ],
      ),
    );
  }

  //User UnAuthenticated Screen--Displays Google Sign In Button
  Widget buildUnAuthScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.purple,
              Colors.teal,
            ],
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Flutter Share',
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Signatra",
                fontSize: 90,
              ),
            ),
            GestureDetector(
              onTap: () {
                login();
              },
              child: Container(
                width: 260.0,
                height: 60.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/google_signin_button.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}
