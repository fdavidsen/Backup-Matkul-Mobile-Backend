import 'package:flutter/material.dart';
import 'package:flutter_application_1/m05/http_helper.dart';

class Home5 extends StatefulWidget {
  const Home5({super.key});

  @override
  State<Home5> createState() => _Home5State();
}

class _Home5State extends State<Home5> {
  HttpHelper? helper;
  List? movies;
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

  Map<String, String> options = {
    'Now Playing': 'now_playing',
    'Popular': 'popular',
    'Top Rated': 'top_rated',
    'Upcoming': 'upcoming',
    'Latest': 'latest',
  };
  String selectedOption = 'now_playing';

  Future<void> initialize() async {
    movies = await helper?.getMovie(selectedOption);
    setState(() {
      movies = movies;
    });
  }

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image;

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
            Text(movies.toString()),
            ListView.builder(itemBuilder: (context, position) {
              return Card();
            })
          ],
        ),
      ),
    );
  }
}
