import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:login/screens/preferences.dart';
import '../providers/black_list_provider.dart';
import '../providers/ingredient_picker_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class BlackList extends ConsumerStatefulWidget {
  const BlackList({super.key, required this.title});

  final String title;

  @override
  ConsumerState<BlackList> createState() => _BlackList();
}

class _BlackList extends ConsumerState<BlackList> {
  bool _loading = false;
  final Map<String, List<String>> _selected = {};

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
        fixedSize: const Size(80, 60),
        alignment: Alignment.center);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(232, 133, 22, 0.6),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    offset: Offset(1.0, 1.0))
              ],
              gradient:
                  LinearGradient(colors: [Colors.lightBlue, Colors.blueAccent]),
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            child: Text(
              "Select ingredients you hate to see on your plate, we'll make sure you never get recipes that contains them",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20)),
            ),
          ),
          for (final entry in categories.entries) ...[
            Container(
              margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              alignment: Alignment.centerLeft,
              child: Text(entry.key,
                  style: GoogleFonts.montserrat(textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 28))),
            ),
            MultiSelectDialogField(
              items: entry.value.map((e) => MultiSelectItem(e, e)).toList(),
              listType: MultiSelectListType.CHIP,
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.red, width: 1)),
              ),
              onConfirm: (values) {
                _selected[entry.key] = values.cast<String>();
              },
            ),
          ],
          const SizedBox(height: 16),
          ElevatedButton(
            style: style,
            onPressed: _loading ? null : () async {
              setState(() => _loading = true);
              try {
                final allSelected = _selected.values.expand((x) => x).toList();
                await ref.read(blacklistProvider.notifier).save(allSelected);
                if (!context.mounted) return;
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const MyPreferencesPage(title: "Preferences")));
              } finally {
                if (mounted) setState(() => _loading = false);
              }
            },
            child: _loading ? const SizedBox(height: 8,) : const Text("Next"),
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
