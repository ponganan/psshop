import 'package:flutter/material.dart';
import 'package:myapp/pages/home/widgets/stock.dart';
import 'package:myapp/services/network_service.dart';
import 'package:myapp/config/route.dart' as custom_route;

import 'models/post.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: custom_route.Route.getAll(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PS SHOP'),
        ),
        body: Center(
          child: FutureBuilder<List<Post>>(
            future: NetworkService().fetchPosts(0),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went Wrong! ${snapshot.error}');
              } else if (snapshot.hasData) {
                List<Post>? product = snapshot.data;
                return product == null
                    ? const Center(child: Text('No User'))
                    : const Stock();

                // : UserProfilePicture();
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
