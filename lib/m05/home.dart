import 'package:flutter/material.dart';
import 'package:flutter_application_1/m05/detail_screen.dart';
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

  final _controller = ScrollController();

  Future<void> loadData() async {
    movies = await helper?.getMovie(selectedOption);
    setState(() {
      movies = movies;
    });
  }

  @override
  void initState() {
    helper = HttpHelper();
    loadData();

    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        bool isTop = _controller.position.pixels == 0;
        if (isTop) {
          print('At the top');
        } else {
          print('At the bottom');
        }
      }
    });

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
        controller: _controller,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            DropdownButton(
              value: selectedOption,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: options.entries.map((entry) {
                return DropdownMenuItem(
                  value: entry.value,
                  child: Text(entry.key),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedOption = newValue!;
                  loadData();
                });
              },
            ),
            // Text(movies.toString()),
            ListView.builder(
                shrinkWrap: true,
                itemCount: movies?.length == null ? 0 : movies?.length,
                itemBuilder: (context, int position) {
                  if (movies![position].posterPath != null) {
                    image =
                        NetworkImage(iconBase + movies![position].posterPath);
                  } else {
                    image = NetworkImage(defaultImage);
                  }

                  return Card(
                    color: Colors.white,
                    child: ListTile(
                      onTap: () {
                        MaterialPageRoute route = MaterialPageRoute(
                            builder: (_) =>
                                DetailScreen(movie: movies![position]));
                        Navigator.push(context, route);
                      },
                      leading: CircleAvatar(
                        backgroundImage: image,
                      ),
                      title: Text(movies![position].title),
                      subtitle: Text('Released: ' +
                          movies![position].releaseDate +
                          ' - Vote: ' +
                          movies![position].voteAverage.toString()),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
