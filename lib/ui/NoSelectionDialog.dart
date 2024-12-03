import 'package:flutter/material.dart';
import 'package:led_app/model/Device.dart';
import 'package:led_app/service/DeviceService.dart';

class NoSelectionDialog extends StatelessWidget {
  const NoSelectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Du hast kein Gerät ausgewählt bzw. überprüfe deine Internetverbindung!"),
            actionsOverflowButtonSpacing: 20,
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor, foregroundColor: Colors.white),
                child: const Text("Ok"),
              ),
            ],
          );
        });
  }
}
