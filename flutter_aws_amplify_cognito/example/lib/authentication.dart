import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import 'package:flutter_aws_amplify_cognito/flutter_aws_amplify_cognito.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool isSignedIn = false;
  UserStatus status = UserStatus.UNKNOWN;
  String username = '';
  String identityId = '';
  String idToken = '';
  String getAccessToken = '';
  String getRefreshToken = '';

  @override
  void initState() {
    FlutterAwsAmplifyCognito.initialize().then((UserStatus status) {
      print(status);
    }).catchError((error) {
      print(error);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: ListView(
        children: [
          ExpandablePanel(
              header: Text(
                'isSignedIn: $isSignedIn',
                style: TextStyle(fontSize: 17),
              ),
              theme: ExpandableThemeData(
                tapHeaderToExpand: true,
                headerAlignment: ExpandablePanelHeaderAlignment.center,
              ),
              expanded: RaisedButton(
                onPressed: () {
                  FlutterAwsAmplifyCognito.isSignedIn().then((value) {
                    setState(() {
                      isSignedIn = value;
                    });
                  }).catchError((error) {
                    print(error);
                  });
                },
                child: Text('Check'),
              )),
          ExpandablePanel(
              header: Text(
                'currentUserState: $status',
                style: TextStyle(fontSize: 17),
              ),
              theme: ExpandableThemeData(
                tapHeaderToExpand: true,
                headerAlignment: ExpandablePanelHeaderAlignment.center,
              ),
              expanded: RaisedButton(
                onPressed: () {
                  FlutterAwsAmplifyCognito.currentUserState()
                      .then((UserStatus state) {
                    setState(() {
                      status = state;
                    });
                  }).catchError((error) {
                    print(error);
                  });
                },
                child: Text('Check'),
              )),
          ExpandablePanel(
              header: Text(
                'getUserAttributes: $status',
                style: TextStyle(fontSize: 17),
              ),
              theme: ExpandableThemeData(
                tapHeaderToExpand: true,
                headerAlignment: ExpandablePanelHeaderAlignment.center,
              ),
              expanded: RaisedButton(
                onPressed: () {
                  FlutterAwsAmplifyCognito.getUserAttributes()
                      .then((attributes) {
                    print(attributes);
//                    setState(() {
//                      status = state;
//                    });
                  }).catchError((error) {
                    print(error);
                  });
                },
                child: Text('Check'),
              )),
          ExpandablePanel(
              header: Text(
                'getUsername: $username',
                style: TextStyle(fontSize: 17),
              ),
              theme: ExpandableThemeData(
                tapHeaderToExpand: true,
                headerAlignment: ExpandablePanelHeaderAlignment.center,
              ),
              expanded: RaisedButton(
                onPressed: () {
                  FlutterAwsAmplifyCognito.getUsername().then((attributes) {
                    print(username);
                    setState(() {
                      username = username;
                    });
                  }).catchError((error) {
                    print(error);
                  });
                },
                child: Text('Check'),
              )),
          ExpandablePanel(
              header: Text(
                'getIdentityId: $identityId',
                style: TextStyle(fontSize: 17),
              ),
              theme: ExpandableThemeData(
                tapHeaderToExpand: true,
                headerAlignment: ExpandablePanelHeaderAlignment.center,
              ),
              expanded: RaisedButton(
                onPressed: () {
                  FlutterAwsAmplifyCognito.getIdentityId().then((identityId) {
                    print(identityId);
                    setState(() {
                      identityId = identityId;
                    });
                  }).catchError((error) {
                    print(error);
                  });
                },
                child: Text('Check'),
              )),
          ExpandablePanel(
              header: Text(
                'getTokens: $identityId',
                style: TextStyle(fontSize: 17),
              ),
              theme: ExpandableThemeData(
                tapHeaderToExpand: true,
                headerAlignment: ExpandablePanelHeaderAlignment.center,
              ),
              expanded: RaisedButton(
                onPressed: () {
                  FlutterAwsAmplifyCognito.getTokens().then((Tokens tokens) {
                    print(tokens.idToken);
//                    setState(() {
//                      identityId = identityId;
//                    });
                  }).catchError((error) {
                    print(error);
                  });
                },
                child: Text('Check'),
              )),
          ExpandablePanel(
              header: Text(
                'getIdToken: $idToken',
                style: TextStyle(fontSize: 17),
              ),
              theme: ExpandableThemeData(
                tapHeaderToExpand: true,
                headerAlignment: ExpandablePanelHeaderAlignment.center,
              ),
              expanded: RaisedButton(
                onPressed: () {
                  FlutterAwsAmplifyCognito.getIdToken().then((idToken) {
                    print(idToken);
//                    setState(() {
//                      identityId = identityId;
//                    });
                  }).catchError((error) {
                    print(error);
                  });
                },
                child: Text('Check'),
              )),
          ExpandablePanel(
              header: Text(
                'getAccessToken: $getAccessToken',
                style: TextStyle(fontSize: 17),
              ),
              theme: ExpandableThemeData(
                tapHeaderToExpand: true,
                headerAlignment: ExpandablePanelHeaderAlignment.center,
              ),
              expanded: RaisedButton(
                onPressed: () {
                  FlutterAwsAmplifyCognito.getAccessToken().then((accessToken) {
                    print(accessToken);
//                    setState(() {
//                      identityId = identityId;
//                    });
                  }).catchError((error) {
                    print(error);
                  });
                },
                child: Text('Check'),
              )),
            ExpandablePanel(
                header: Text(
                    'getRefreshToken: $getAccessToken',
                    style: TextStyle(fontSize: 17),
                ),
                theme: ExpandableThemeData(
                    tapHeaderToExpand: true,
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                ),
                expanded: RaisedButton(
                    onPressed: () {
                        FlutterAwsAmplifyCognito.getRefreshToken().then((refreshToken) {
                            print(refreshToken);
//                    setState(() {
//                      identityId = identityId;
//                    });
                        }).catchError((error) {
                            print(error);
                        });
                    },
                    child: Text('Check'),
                )),
          ExpandablePanel(
              header: Text(
                'getAWSCredentials: $getAccessToken',
                style: TextStyle(fontSize: 17),
              ),
              theme: ExpandableThemeData(
                tapHeaderToExpand: true,
                headerAlignment: ExpandablePanelHeaderAlignment.center,
              ),
              expanded: RaisedButton(
                onPressed: () {
                  FlutterAwsAmplifyCognito.getCredentials()
                      .then((AWSCredentials credentials) {
                    print(credentials.secretKey);
                    print(credentials.accessKey);
//                    setState(() {
//                      identityId = identityId;
//                    });
                  }).catchError((error) {
                    print(error);
                  });
                },
                child: Text('Check'),
              )),
          ExpandablePanel(
              header: Text(
                'trackDevice: $getAccessToken',
                style: TextStyle(fontSize: 17),
              ),
              theme: ExpandableThemeData(
                tapHeaderToExpand: true,
                headerAlignment: ExpandablePanelHeaderAlignment.center,
              ),
              expanded: RaisedButton(
                onPressed: () {
                  FlutterAwsAmplifyCognito.trackDevice().then((tracked) {
                    print(tracked);
//                    setState(() {
//                      identityId = identityId;
//                    });
                  }).catchError((error) {
                    print(error);
                  });
                },
                child: Text('Check'),
              )),
            ExpandablePanel(
                header: Text(
                    'getDeviceDetails: $getAccessToken',
                    style: TextStyle(fontSize: 17),
                ),
                theme: ExpandableThemeData(
                    tapHeaderToExpand: true,
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                ),
                expanded: RaisedButton(
                    onPressed: () {
                        FlutterAwsAmplifyCognito.getDeviceDetails().then((tracked) {
                            print(tracked);
//                    setState(() {
//                      identityId = identityId;
//                    });
                        }).catchError((error) {
                            print(error);
                        });
                    },
                    child: Text('Check'),
                )),
            ExpandablePanel(
                header: Text(
                    'sign up: $getAccessToken',
                    style: TextStyle(fontSize: 17),
                ),
                theme: ExpandableThemeData(
                    tapHeaderToExpand: true,
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                ),
                expanded: RaisedButton(
                    onPressed: () {
                        Map<String, String> data = Map<String, String>();
                        data['email'] = 'yzvishal.vd@gmail.com';
                        FlutterAwsAmplifyCognito.signUp("yzvishal.vd@gmail.com", "vishal69123", data).then((tracked) {
                            print(tracked.confirmationState);
                            print(tracked.userCodeDeliveryDetails.destination);

//                    setState(() {
//                      identityId = identityId;
//                    });
                        }).catchError((error) {
                            print(error);
                        });
                    },
                    child: Text('Check'),
                )
            ),
            ExpandablePanel(
                header: Text(
                    'confirm sign up: $getAccessToken',
                    style: TextStyle(fontSize: 17),
                ),
                theme: ExpandableThemeData(
                    tapHeaderToExpand: true,
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                ),
                expanded: RaisedButton(
                    onPressed: () {
                        FlutterAwsAmplifyCognito.confirmSignUp("yzvishal.vd@gmail.com", "854542").then((tracked) {
                            print(tracked.confirmationState);
                            print(tracked.userCodeDeliveryDetails.destination);
//                    setState(() {
//                      identityId = identityId;
//                    });
                        }).catchError((error) {
                            print(error);
                        });
                    },
                    child: Text('Check'),
                )
            ),
            ExpandablePanel(
                header: Text(
                    'sign in: $getAccessToken',
                    style: TextStyle(fontSize: 17),
                ),
                theme: ExpandableThemeData(
                    tapHeaderToExpand: true,
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                ),
                expanded: RaisedButton(
                    onPressed: () {
                        FlutterAwsAmplifyCognito.signIn("yzvishal.vd@gmail.com", "vishalpvc").then((tracked) {
                            print(tracked.signInState);
                            print(tracked.parameters);
//                    setState(() {
//                      identityId = identityId;
//                    });
                        }).catchError((error) {
                            print(error);
                        });
                    },
                    child: Text('Check'),
                )
            ),
            ExpandablePanel(
                header: Text(
                    'sign out: $getAccessToken',
                    style: TextStyle(fontSize: 17),
                ),
                theme: ExpandableThemeData(
                    tapHeaderToExpand: true,
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                ),
                expanded: RaisedButton(
                    onPressed: () {
                        FlutterAwsAmplifyCognito.signOut().then((tracked) {

//                    setState(() {
//                      identityId = identityId;
//                    });
                        }).catchError((error) {
                            print(error);
                        });
                    },
                    child: Text('Check'),
                )
            ),
            ExpandablePanel(
                header: Text(
                    'sign out globally: $getAccessToken',
                    style: TextStyle(fontSize: 17),
                ),
                theme: ExpandableThemeData(
                    tapHeaderToExpand: true,
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                ),
                expanded: RaisedButton(
                    onPressed: () {
                        FlutterAwsAmplifyCognito.signOutGlobally().then((tracked) {
                            print(tracked);
//                    setState(() {
//                      identityId = identityId;
//                    });
                        }).catchError((error) {
                            print(error);
                        });
                    },
                    child: Text('Check'),
                )
            ),
            ExpandablePanel(
                header: Text(
                    'forgot password: $getAccessToken',
                    style: TextStyle(fontSize: 17),
                ),
                theme: ExpandableThemeData(
                    tapHeaderToExpand: true,
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                ),
                expanded: RaisedButton(
                    onPressed: () {
                        FlutterAwsAmplifyCognito.forgotPassword('yzvishal.vd@gmail.com').then((tracked) {
                            print(tracked.state);
//                    setState(() {
//                      identityId = identityId;
//                    });
                        }).catchError((error) {
                            print(error);
                        });
                    },
                    child: Text('Check'),
                )
            ),
            ExpandablePanel(
                header: Text(
                    'confirm forgot password: $getAccessToken',
                    style: TextStyle(fontSize: 17),
                ),
                theme: ExpandableThemeData(
                    tapHeaderToExpand: true,
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                ),
                expanded: RaisedButton(
                    onPressed: () {
                        FlutterAwsAmplifyCognito.confirmForgotPassword('yzvishal.vd@gmail.com', "vishalpvc", "678952").then((tracked) {
                            print(tracked.state);
//                    setState(() {
//                      identityId = identityId;
//                    });
                        }).catchError((error) {
                            print(error);
                        });
                    },
                    child: Text('Check'),
                )
            ),
        ],
      ),
    );
  }
}
