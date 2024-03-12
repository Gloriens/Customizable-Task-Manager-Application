import 'package:demo_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class TemplateEndpoint extends Endpoint {
  Future<Template> createTemplate(Session session, Template template) async {
    await Template.insert(session, template);
    return template;
  }

  Future<List<Template>> getTemplate(Session session) async {
    return await Template.find(session);
  }
}
