import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:macos_demo/credentials.dart';
import 'package:macos_demo/github_login_widget.dart';
import 'package:window_to_front/window_to_front.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Client',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'GitHub Client'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return GithubLoginWidget(
      githubClientId: githubClient,
      githubClientSecret: githubSecret,
      githubScopes: githubScopes,
      builder: (context, client) {
        WindowToFront.activate();
        return FutureBuilder<CurrentUser>(
          future: _getUser(client.credentials.accessToken),
          builder: (context, user) {
            if (!user.hasData) {
              return const SizedBox();
            }
            return Scaffold(
              appBar: AppBar(
                title: Text(title),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'You are logged in as ${user.data?.name ?? ''} ',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (user.data?.avatarUrl != null)
                    SizedBox(
                      height: 150,
                      width: 1540,
                      child: Image.network(user.data?.avatarUrl ?? ''),
                    )
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<CurrentUser> _getUser(String token) async {
    var gitHub = GitHub(auth: Authentication.withToken(token));
    return gitHub.users.getCurrentUser();
  }
}
