import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RateUpdate extends StatefulWidget {
  const RateUpdate({super.key});

  @override
  State<RateUpdate> createState() => _RateUpdateState();
}

enum RadioButtonOptions { KDV, KarOrani }

const List<String> _list = <String>['One', 'Two', 'Three', 'Four'];

class _RateUpdateState extends State<RateUpdate> {
  RadioButtonOptions? _character = RadioButtonOptions.KDV;
  TextEditingController selectedValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Card(
          elevation: 4,
          margin: EdgeInsets.all(8.0),
          child:Container(
             alignment: Alignment.center,
            child: rateUpdatePage(context),
            padding:const EdgeInsets.only(bottom: 10),
          ),
        ),
      ]),
    );
  }

  Column rateUpdatePage(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, top: 10),
              child: Text("Oran Güncelle",
                  style:
                      TextStyle(color: Colors.purple.shade100, fontSize: 20)),
            )),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: CustomDropdown<String>.search(
            items: _list,
            onChanged: (value) {
              print('changing value to: $value');
            },
            hintText: 'Kategori Seçiniz',
            excludeSelected: false, // seçilen öğe tekrar görüntülenmesin mi??
            hideSelectedFieldWhenExpanded:
                true, //true ise seçilen özellik gizlensin
            decoration: CustomDropdownDecoration(
                expandedFillColor: Theme.of(context).colorScheme.background,
                closedFillColor: Theme.of(context).colorScheme.scrim),
            closedHeaderPadding: const EdgeInsets.all(15),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        ListTile(
          title: const Text("KDV"),
          leading: Radio<RadioButtonOptions>(
              value: RadioButtonOptions.KDV,
              groupValue: _character,
              onChanged: (RadioButtonOptions? value) {
                setState(() {
                  _character = value;
                });
              }),
        ),
        ListTile(
          title: const Text("Kar"),
          leading: Radio<RadioButtonOptions>(
              value: RadioButtonOptions.KarOrani,
              groupValue: _character,
              onChanged: (RadioButtonOptions? value) {
                setState(() {
                  _character = value;
                });
              }),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextField(
            controller: selectedValue,
            //enabled: !disableUrunStokMiktari,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: const InputDecoration(
              labelText: "Oran (%) ",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(30.0), left: Radius.circular(30.0)),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(209, 168, 42, 218)),
                  ),
                  onPressed: () {},
                  child: const Text("GÜNCELLE"),
                ),
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.grey.shade800),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("KAPAT"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
