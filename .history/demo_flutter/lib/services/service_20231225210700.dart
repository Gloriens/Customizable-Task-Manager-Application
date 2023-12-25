import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:demo_client/demo_client.dart';
import 'package:demo_flutter/LoginScreen.dart';
import 'package:demo_flutter/providers/template_notifier.dart';
import 'package:demo_flutter/providers/user_notifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final serviceProvider = Provider((ref) => Service());

class Service {
  Future<void> createNewUser(AppUser user, BuildContext context) async {
    final userProvider = ProviderScope.containerOf(context)
        .read(userStateNotifierProvider.notifier);
    try {
      final newUser = await client.userEndPoint.createUser(user);
      if (!context.mounted) {
        return;
      }
      userProvider.user = newUser;
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> logIn(AppUser appUser, BuildContext context) async {
    final userProvider = ProviderScope.containerOf(context)
        .read(userStateNotifierProvider.notifier);
    try {
      AppUser? logInUser = await client.userEndPoint.checkIfUserExists(appUser);
      print(logInUser?.id);
      if (!context.mounted) {
        return;
      }
      if (logInUser != null) {
        userProvider.user = logInUser;
      }
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> createTemplate(
    BuildContext context, {
    required String name,
  }) async {
    final templateProvider = ProviderScope.containerOf(context)
        .read(templateStateNotifierProvider.notifier);
    final userProvider = ProviderScope.containerOf(context)
        .read(userStateNotifierProvider.notifier);
    final template = Template(userId: userProvider.user.id ?? 0, name: name);
    try {
      final addedTemplate = await client.template.createTemplate(template);
      templateProvider.template = addedTemplate;
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> createField(
    BuildContext context, {
    required String type,
    required String name,
  }) async {
    final templateProvider = ProviderScope.containerOf(context)
        .read(templateStateNotifierProvider.notifier);
    final field = Field(
      templateId: templateProvider.template.id ?? 0,
      type: type,
      name: name,
    );
    try {
      return await client.field.createField(field);
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> createRole(BuildContext context,
      {required String name, required bool display, required bool edit}) async {
    final templateProvider = ProviderScope.containerOf(context)
        .read(templateStateNotifierProvider.notifier);
    final role = Role(
      templateId: templateProvider.template.id ?? 0,
      name: name,
      display: display,
      edit: edit,
    );
  }

  String encryptPassword(String password) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  Future<List<Field>> getListOfFieldsByTemplate(BuildContext context) async {
    final templateProvider = ProviderScope.containerOf(context)
        .read(templateStateNotifierProvider.notifier);
    final List<Field> listOfFields = await client.field
        .getFieldsByTemplate(templateId: templateProvider.template.id ?? 0);
    return listOfFields;
  }

  Future<List<Role>> getListOfRolesByTemplate(BuildContext context) async {
    final templateProvider = ProviderScope.containerOf(context)
        .read(templateStateNotifierProvider.notifier);
    final List<Role> listOfRoles = await client.role
        .getRolesByTemplate(templateId: templateProvider.template.id ?? 0);
    return listOfRoles;
  }
}
