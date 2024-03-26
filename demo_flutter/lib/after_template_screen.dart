import 'package:demo_flutter/HomePage.dart';
import 'package:demo_flutter/fields/field_cards_list.dart';
import 'package:demo_flutter/fields/field_creation_screen.dart';
import 'package:demo_flutter/main_menu.dart';
import 'package:demo_flutter/roles/roleDisplay/role_cards_list.dart';
import 'package:demo_flutter/roles/role_creation_screen.dart';
import 'package:demo_flutter/services/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AfterTemplateScreen extends ConsumerStatefulWidget {
  const AfterTemplateScreen({super.key});

  @override
  ConsumerState<AfterTemplateScreen> createState() =>
      _AfterTemplateScreenState();
}

class _AfterTemplateScreenState extends ConsumerState<AfterTemplateScreen> {
  @override
  Widget build(BuildContext context) {
    final fields = ref.watch(listOfFieldsProvider);
    final roles = ref.watch(listOfRolesProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Geri butonu ikonu
          onPressed: () {
            //Navigator.push(context,
            //MaterialPageRoute(builder: (context) => SecondPage()),
            Navigator.push(context, MaterialPageRoute(builder: (context) => MainMenu()));
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Field",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        ref.refresh(listOfFieldsProvider);
                                        ref.refresh(listOfRolesProvider);
                                      },
                                      child: const Text("Refresh"))),
                            ),
                            //This is the part that the data comes from the server through service.
                            fields.when(
                                data: (data) {
                                  return FieldCardsList(fields: data);
                                },
                                error: ((error, stackTrace) =>
                                    Text(error.toString())),
                                loading: () => const Center(
                                    child: CircularProgressIndicator())),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const FieldCreationScreen();
                                    });
                              },
                              child: const Text("Add"))),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Role",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        roles.when(
                          data: (data) {
                            return RoleCardsList(roles: data);
                          },
                          error: ((error, stackTrace) => Text(error.toString())),
                          loading: () => const Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const RoleCreationScreen();
                                    });
                              },
                              child: const Text("Add"))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MyHomePAge()));
                              },
                              child: const Text("Save All"))),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
