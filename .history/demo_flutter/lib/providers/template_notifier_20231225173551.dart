import 'package:demo_client/demo_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TemplateStateNotifier extends StateNotifier<Template> {
  TemplateStateNotifier() : super(Template(userId: 0, name: ""));

  set template(Template template) {
    state = template;
  }

  Template get template => state;
}
