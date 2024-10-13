import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:injectable/injectable.dart';

@singleton
class DeviceService {
  Future<List<Contact>?> getContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) return null;
    return await FlutterContacts.getContacts(
        withProperties: true, withPhoto: true);
  }
}
