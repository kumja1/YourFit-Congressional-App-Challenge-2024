// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import '../../services/functions/device_service.dart';
import '../../utils/constants.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  late List<Contact>? _contacts = [];
  late bool _permissionDenied = false;

  final _deviceService = getIt<DeviceService>();

  @override
  void initState() {
    super.initState();
    _fetchContacts(); // Fetch contacts when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
         SearchAnchor(
            builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                controller: controller,
                padding: const WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0),
                ),
                onTap: () {
                  controller.openView();
                },
                leading: const Icon(Icons.search),
                elevation: WidgetStatePropertyAll(0.0),
              );
            },
            suggestionsBuilder:
                (BuildContext context, SearchController controller) {
              return List<ListTile>.generate(_contacts!.length, (int index) {
                final String item = _contacts![index].displayName;
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    setState(() {
                      controller.closeView(item);
                    });
                  },
                );
              });
            },
          ),
          SizedBox(height: 16), // Spacing below title
          _buildBody()
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_permissionDenied) {
      return Center(
        child: Text("Permission Denied"),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: _contacts!.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: _contacts![index].photo != null
                  ? MemoryImage(_contacts![index].photo!)
                  : null, // Use contact photo if available
              child: _contacts![index].photo == null
                  ? const Icon(Icons.person)
                  : Image.memory(_contacts![index].photo!), // Display an icon if no photo
            ),
            title: Text(_contacts![index].displayName), // Use contact name
            // You can add subtitle for phone number or other details
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check),
                SizedBox(width: 8), // Spacing between icons
                Icon(Icons.close),
              ],
            ),
          );
        },
      ),
    );
  }

  void _fetchContacts() async {
    var contacts = await _deviceService.getContacts();
    if (contacts == null) {
      setState(() {
        _contacts = null;
        _permissionDenied = true;
      });
      return;
    }

    setState(() {
      
    });

    FlutterContacts.addListener(() async {
      await _refetchContacts();
    });
  }

  Future<void> _refetchContacts() async {
    var contacts = await FlutterContacts.getContacts(
        withProperties: true, withPhoto: true);

    setState(() => _contacts = contacts);
  }
}
