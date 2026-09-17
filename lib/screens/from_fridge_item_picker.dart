import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login/screens/preferences_logged.dart';
import 'package:login/screens/show_from_fridge_recipes.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../providers/ingredient_picker_provider.dart';
import '../providers/user_providers.dart';
import '../utilities/log_out.dart';
import 'home.dart';
import 'login.dart';

List<String> FromFridgeList = [];

class FromFridgeItemPicker extends ConsumerStatefulWidget {
  final String title;

  const FromFridgeItemPicker({
    super.key,
    required this.title,
  });

  @override
  ConsumerState<FromFridgeItemPicker> createState() => _FromFridgeItemPicker();
}

class _FromFridgeItemPicker extends ConsumerState<FromFridgeItemPicker> {
  @override
  void initState() {
    super.initState();
  }

  customBoxDecoration(isActive) {
    return BoxDecoration(
      color: isActive ? const Color(0xff1763DD) : Colors.white,
      border: const Border(
          left: BorderSide(color: Colors.black12, width: 1.0),
          bottom: BorderSide(color: Colors.black12, width: 1.0),
          top: BorderSide(color: Colors.black12, width: 1.0),
          right: BorderSide(color: Colors.black12, width: 1.0)),
      borderRadius: const BorderRadius.all(
        Radius.circular(5.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(ingredientPickerProvider).value ?? {};
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
        fixedSize: const Size(50, 20),
        alignment: Alignment.center);

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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const MyPreferencesLoggedPage(title: 'Preferences')),
                );
              },
              leading: const Icon(Icons.pending),
              title: const Text('Preferences'),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FromFridgeItemPicker(
                            title: 'Home',
                          )),
                );
              },
              leading: const Icon(Icons.room_service),
              title: const Text('From fridge'),
            ),
            ListTile(
              onTap: () {
                {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => ScanAndLearn(camera: firstCamera,)),
                  // );
                }
              },
              leading: const Icon(Icons.camera_alt_rounded),
              title: const Text('Scan and learn'),
            ),
            ListTile(
              onTap: () {
                signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyLoginPage(title: 'Login')),
                );
              },
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          // loop over each category
          for (final entry in categories.entries) ...[
            Container(
              margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              padding: const EdgeInsets.all(20.0),
              alignment: Alignment.center,
              child: Text(
                entry.key,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
            ),
            MultiSelectDialogField(
              items: entry.value.map((e) => MultiSelectItem(e, e)).toList(),
              // category's ingredients
              listType: MultiSelectListType.CHIP,
              onConfirm: (values) {
                FromFridgeList = FromFridgeList + values.cast<String>();
              },
            ),
          ],

          ElevatedButton(
            style: style,
            onPressed: () {
              final ingredients = FromFridgeList.join(',');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => showFromFridgeRecipes(
                      title: "From Fridge",
                      ingredients: ingredients,
                    ),
                  ));
            },
            child: const Text('Find recipes'),
          ),
        ],
      ),
    );
  }

  changeState(item) {
    setState(() {
      item['isActive'] = !item['isActive'];
      print(item['isActive']);
    });
  }
}
