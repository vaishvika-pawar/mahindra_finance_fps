import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

final fdt = DateFormat('dd MMM');

class DayCard extends StatelessWidget {
  final DateTime date;
  final int hrd;
  final int tech;
  final int followup;
  const DayCard(
      {Key? key,
      required this.date,
      required this.hrd,
      required this.tech,
      required this.followup})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ClipPath(
          clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(color: Colors.red, width: 5),
              ),
            ),
            child: Row(
              children: [
                roundIcon(fdt.format(date), Colors.white),
                roundIcon(hrd.toString(), Colors.white),
                roundIcon(tech.toString(), Colors.white),
                roundIcon(followup.toString(), Colors.white),
                roundIcon((hrd + tech + followup).toString(), Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

roundIcon(String text, Color kcolor) {
  return Container(
    decoration: BoxDecoration(shape: BoxShape.circle, color: kcolor),
    child: Text(text),
  );
}

class DetailsCard extends StatelessWidget {
  const DetailsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Balram Naidu'),
      trailing: IconButton(
        icon: const Icon(Icons.call),
        onPressed: () {
          makePhoneCall('9934758312');
        },
      ),
      subtitle: Column(
        children: [
          const Text('ID: fddnjjj3j3454545'),
          const Text('Offered: x,xx,xxx'),
          const Text('Current: x,xx,xxx'),
          const Text(
            'Medium Priority',
            style: TextStyle(color: Colors.orange),
          ),
          const Divider(),
          Row(
            children: [
              Column(
                children: [
                  Text('Due Date:'),
                  const Text('05 Jun 23'),
                ],
              ),
              Column(
                children: [
                  const Text('Level:'),
                  const Text('10'),
                ],
              ),
              Column(
                children: [
                  const Text('Days left:'),
                  const Text('23'),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}
