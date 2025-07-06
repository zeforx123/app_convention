import 'package:app_convention/bloc/post/post_bloc.dart';
import 'package:app_convention/screens/create_post_screen.dart';
import 'package:app_convention/screens/exchange_rate.dart';
import 'package:app_convention/screens/feed_screen.dart';
import 'package:app_convention/screens/profile_screen.dart';
import 'package:app_convention/services/post_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Text(
              'Feed de publicaciones',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.person_outline),
              tooltip: 'Mi perfil',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              },
            )
          ],
        ),
      ),
      body: const Column(
        children: [
          ExchangeRateWidget(),
          Expanded(child: FeedScreen()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => PostBloc(PostService()),
                child: const CreatePostScreen(),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
