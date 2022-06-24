import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  /// The title of the app.
  static const String title = 'GoRouter Example: Declarative Routes';

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routeInformationProvider: _router.routeInformationProvider,
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        title: title,
      );
}

final GoRouter _router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: Page1Screen.routeName,
      builder: (BuildContext context, GoRouterState state) =>
          const Page1Screen(),
    ),
    GoRoute(
      path: Page2Screen.routeName,
      builder: (BuildContext context, GoRouterState state) =>
          const Page2Screen(),
    ),
    GoRoute(
      path: Page3Screen.routeName,
      builder: (BuildContext context, GoRouterState state) =>
          const Page3Screen(),
    ),
    GoRoute(
      path: Page4Screen.routeName,
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: const Page4Screen(),
      ),
    ),
    GoRoute(
      path: Page5Screen.routeName,
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: const Page5Screen(),
      ),
    ),
    GoRoute(
        path: ChatRoomScreen.routeName,
        builder: (BuildContext context, GoRouterState state) =>
            const ChatRoomScreen(),
        routes: [
          GoRoute(
            path: ':uid',
            builder: (context, state) {
              return ChatRoomViewScreen(
                uid: state.params['uid']!,
                extra: state.extra,
              );
            },
          ),
        ]),
  ],
);

Widget get linkButton {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: () => _router.go(Page1Screen.routeName),
          child: const Text('Go Home'),
        ),
        ElevatedButton(
          onPressed: () => _router.push(Page2Screen.routeName),
          child: const Text('push to page 2'),
        ),
        ElevatedButton(
          onPressed: () => _router.push(Page3Screen.routeName),
          child: const Text('push to page 3'),
        ),
        ElevatedButton(
          onPressed: () => _router.push(Page4Screen.routeName),
          child: const Text('push to page 4'),
        ),
        ElevatedButton(
          onPressed: () => _router.push(Page5Screen.routeName),
          child: const Text('push to page 5'),
        ),
        ElevatedButton(
          onPressed: () => _router.go(ChatRoomScreen.routeName),
          child: const Text('Go to Chat Room'),
        ),
        ElevatedButton(
          onPressed: () => _router
              .push("${ChatRoomScreen.routeName}/abc", extra: {'name': 'ABC'}),
          child: const Text('Push ChatRoomViewScreen'),
        ),
        ElevatedButton(
          onPressed: () => _router.push("${ChatRoomScreen.routeName}/efg"),
          child: const Text('Push ChatRoomViewScreen'),
        ),
        ElevatedButton(
          onPressed: () => _router
              .go("${ChatRoomScreen.routeName}/abc", extra: {'name': 'ABC'}),
          child: const Text('Go ChatRoomViewScreen'),
        ),
        ElevatedButton(
          onPressed: () => _router.go("${ChatRoomScreen.routeName}/efg"),
          child: const Text('Go ChatRoomViewScreen'),
        ),
        ElevatedButton(
          onPressed: () => _router.pop(),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}

/// The screen of the first page.
class Page1Screen extends StatelessWidget {
  /// Creates a [Page1Screen].
  const Page1Screen({Key? key}) : super(key: key);
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: linkButton,
    );
  }
}

/// The screen of the second page.
class Page2Screen extends StatelessWidget {
  /// Creates a [Page2Screen].
  const Page2Screen({Key? key}) : super(key: key);
  static const String routeName = '/page2';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Page 2')),
        body: linkButton,
      );
}

/// The screen of the second page.
class Page3Screen extends StatelessWidget {
  /// Creates a [Page3Screen].
  const Page3Screen({Key? key}) : super(key: key);
  static const String routeName = '/page3';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Page 3')),
        body: linkButton,
      );
}

/// The screen of the second page.
class Page4Screen extends StatelessWidget {
  /// Creates a [Page3Screen].
  const Page4Screen({Key? key}) : super(key: key);
  static const String routeName = '/page4';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Page 4')),
        body: linkButton,
      );
}

/// The screen of the second page.
class Page5Screen extends StatelessWidget {
  /// Creates a [Page3Screen].
  const Page5Screen({Key? key}) : super(key: key);
  static const String routeName = '/page5';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Page 5')),
        body: linkButton,
      );
}

/// The screen of the second page.
class ChatRoomScreen extends StatelessWidget {
  /// Creates a [Page3Screen].
  const ChatRoomScreen({Key? key}) : super(key: key);
  static const String routeName = '/chatRoom';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('ChatRoomScreen')),
        body: linkButton,
      );
}

/// The screen of the second page.
class ChatRoomViewScreen extends StatelessWidget {
  /// Creates a [Page3Screen].
  const ChatRoomViewScreen({Key? key, required this.uid, this.extra})
      : super(key: key);
  final String uid;
  static const String routeName = '/chatRoomView';
  final Object? extra;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _extra =
        (extra != null ? extra as Map<String, dynamic> : {});
    return Scaffold(
      appBar: AppBar(
          title: Text("ChatRoomViewScreen $uid ${_extra['name'] ?? ''}")),
      body: linkButton,
    );
  }
}
