import 'package:flutter/material.dart';
import 'package:latihan_mobile_backend/m04/http_helper.dart';

class Home4 extends StatefulWidget {
  const Home4({super.key});

  @override
  State<Home4> createState() => _Home4State();
}

class _Home4State extends State<Home4> {
  late String result;
  late HttpHelper helper;

  Map<String, String> options = {
    'Now Playing': 'now_playing',
    'Popular': 'popular',
    'Top Rated': 'top_rated',
    'Upcoming': 'upcoming',
    'Latest': 'latest',
  };
  String selectedOption = 'now_playing';

  @override
  void initState() {
    helper = HttpHelper();
    result = 'Loading...';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    helper.getMovie(selectedOption).then((value) {
      setState(() {
        result = value;
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Movie'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: options.entries
                  .map((entry) => RadioListTile(
                        title: Text(entry.key),
                        value: entry.value,
                        groupValue: selectedOption,
                        onChanged: (String? value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ))
                  .toList(),
            ),
            Text(result)
          ],
        ),
      ),
    );
  }
}
