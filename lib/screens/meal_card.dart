import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login/screens/show_recipe.dart';
import '../Modals/recipe.dart';
import '../utilities/fetch_recipe.dart';
import '../utilities/get_likes.dart';
import '../utilities/swap_meal.dart';

class MealCard extends StatefulWidget {
  final List<String> menu;
  final int index;
  final String userType;
  final String collectionPath;
  final int cap;
  final AsyncCallback onSwapped;

  const MealCard({
    super.key,
    required this.menu,
    required this.index,
    required this.userType,
    required this.collectionPath,
    required this.cap,
    required this.onSwapped,
  });

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> with AutomaticKeepAliveClientMixin{
  Future<Recipe>? futureRecipe;

  (String, String) _queueAndField() {
    switch (widget.userType) {
      case 'breakfast': return ('queue_breakfast', 'breakfastMenu');
      case 'lunch':     return ('queue_lunch', 'lunchMenu');
      default:          return ('queue_dinner', 'dinnerMenu');
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    futureRecipe = fetchRecipe(widget.menu, widget.index);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    const TextStyle styleTitle =
    TextStyle(fontSize: 28);

    const TextStyle styleType =
    TextStyle(fontSize: 16);

    return FutureBuilder<Recipe>(
      future: futureRecipe,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
        // Uncompleted State
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
          // Completed with error
            if (snapshot.hasError) {
              return Container(
                  child: Text(snapshot.error.toString()));
            }
            return Column(
                children: <Widget>[
                  const SizedBox(height: 4),
                  GestureDetector(
                      onTap: () async {
                        recipeMenu = widget.menu;
                        recipeIndex = widget.index;
                        collection_path = widget.collectionPath;
                        doc_path = widget.menu[widget.index];
                        Type = 'suggestion_br_r';
                        userType = widget.userType;
                        await getLikes();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                          const MyRecipePage(
                              title: "Recipe")),
                        );
                      },
                      child: Container(
                          margin: const EdgeInsets.fromLTRB(
                              4.0, 10.0, 4.0, 10.0),
                          padding: const EdgeInsets.fromLTRB(
                              0.0, 22.0, 0.0, 22.0),
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 3.0,
                                  offset: Offset(1.0, 1.0)
                              )
                            ],
                            gradient: LinearGradient(
                                colors: [
                                  Colors.red,
                                  Colors.deepOrangeAccent
                                ]
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                          ),
                          child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(
                                      10.0, 10.0, 10.0, 10.0),
                                  child: Text(
                                    snapshot.data!.title.toString(),
                                    style: styleTitle,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center,
                                  children: [
                                    Column(
                                        children: [
                                          const Text("Servings",
                                              style: styleType
                                          ),
                                          Container(
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                    width: 4.0,
                                                    color: Colors
                                                        .white),
                                              ),
                                            ),
                                            child: Text(
                                                snapshot.data!
                                                    .servings
                                                    .toString()),
                                          ),
                                        ]
                                    ),
                                    const SizedBox(width: 24),
                                    Column(
                                      children: [
                                        const Text("Rating",
                                            style: styleType
                                        ),
                                        Container(
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  width: 4.0,
                                                  color: Colors
                                                      .white),
                                            ),
                                          ),
                                          child: Text(
                                              snapshot.data!.score.round()
                                                  .toString()),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 24),
                                    Column(
                                      children: [
                                        const Text("HScore",
                                            style: styleType
                                        ),
                                        Container(
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  width: 4.0,
                                                  color: Colors
                                                      .white),
                                            ),
                                          ),
                                          child: Text(
                                              snapshot.data!
                                                  .healthScore.round()
                                                  .toString()),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20),
                                IconButton(
                                  icon: const Icon(Icons.swap_horiz, color: Colors.white, size: 38),
                                  onPressed: () async {
                                    final confirmed = await showDialog<bool>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Swap this meal?'),
                                        content: const Text('This will replace it with a different recipe.'),
                                        actions: [
                                          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                                          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Swap')),
                                        ],
                                      ),
                                    );
                                    if (confirmed != true) return;

                                    final (queueCol, menuField) = _queueAndField();
                                    final newTitle = await swapMeal(queueCol, menuField, widget.index, widget.cap);

                                    if (!mounted) return;
                                    if (newTitle != null) {
                                      widget.menu[widget.index] = newTitle;
                                      setState(() {
                                        futureRecipe = fetchRecipe([newTitle], 0); // re-fetch card with new recipe
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('No more recipes to swap to')),
                                      );
                                    }
                                  },
                                ),
                              ]
                          )
                      )
                  )
                ]
            );
        }
      },
    );
  }
}
