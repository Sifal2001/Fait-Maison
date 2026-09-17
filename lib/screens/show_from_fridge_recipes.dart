import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login/Modals/first_recipe_from_fridge.dart';
import 'package:login/screens/show_recipe.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/user_providers.dart';
import '../utilities/fetch_recipe_from_fridge.dart';
import 'from_fridge_item_picker.dart';
import 'package:login/screens/home.dart';

import 'meal_card.dart';

class showFromFridgeRecipes extends ConsumerStatefulWidget {
  final String title;
  final String ingredients;

  const showFromFridgeRecipes({
    super.key,
    required this.title,
    required this.ingredients,
  });

  @override
  ConsumerState<showFromFridgeRecipes> createState() =>
      _showFromFridgeRecipesState();
}

class _showFromFridgeRecipesState extends ConsumerState<showFromFridgeRecipes> {
  late Future<List<String>> futureRecipes;

  @override
  void initState() {
    super.initState();
    futureRecipes = fetchFridgeRecipes(widget.ingredients);
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle styleTitle = TextStyle(fontSize: 28);
    const TextStyle styleType = TextStyle(fontSize: 16);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.red,
                ),
                child: Text(
                  ref.watch(userProvider).when(
                        data: (user) => user?.name ?? 'User',
                        error: (_, __) => 'User',
                        loading: () => '...',
                      ),
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyHomePage(title: 'Home')),
                  );
                },
                leading: const Icon(Icons.home),
                title: const Text('Home'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.account_circle),
                title: const Text('Profile'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.pending),
                title: const Text('Preferences'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const FromFridgeItemPicker(title: 'Home')),
                  );
                },
                leading: const Icon(Icons.room_service),
                title: const Text('From fridge'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.camera_alt_rounded),
                title: const Text('Scan and learn'),
              ),
            ],
          ),
        ),
        body: FutureBuilder<List<String>>(
          future: futureRecipes,
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text('${snapshot.error}');
            if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

            final titles = snapshot.data!;
            if (titles.isEmpty) return const Center(child: Text('No recipes found for those ingredients'));

            return ListView.builder(
              itemCount: titles.length,
              itemBuilder: (context, index) => MealCard(
                menu: titles,
                index: index,
                mealType: 'lunch',
                collectionPath: 'Lunch_r',
                cap: 60,
                showSwap: false,
              ),
            );
          },
        ),
    );
  }
}
