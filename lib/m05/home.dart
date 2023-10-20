import 'package:flutter/material.dart';
import 'package:latihan_mobile_backend/m05/detail_screen.dart';
import 'package:latihan_mobile_backend/m05/http_helper.dart';

class Home5 extends StatefulWidget {
  const Home5({super.key});

  @override
  State<Home5> createState() => _Home5State();
}

class _Home5State extends State<Home5> {
  HttpHelper? helper;
  List? movies;
  List? filteredItems;
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage = 'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

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
      filteredItems = movies;
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

  void filterSearchResults(String query) {
    List searchResults = movies!.where((item) => item.title.toLowerCase().contains(query.toLowerCase())).toList();
    setState(() {
      filteredItems = searchResults;
    });
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
            TextField(
              onChanged: filterSearchResults,
              decoration: const InputDecoration(
                // labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
              ),
            ),
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
                itemCount: filteredItems?.length == null ? 0 : filteredItems?.length,
                itemBuilder: (context, int position) {
                  if (filteredItems![position].posterPath != null) {
                    image = NetworkImage(iconBase + filteredItems![position].posterPath);
                    print(image);
                  } else {
                    image = NetworkImage(defaultImage);
                  }

                  return Card(
                    color: Colors.white,
                    child: ListTile(
                      onTap: () {
                        MaterialPageRoute route = MaterialPageRoute(builder: (_) => DetailScreen(movie: filteredItems![position]));
                        Navigator.push(context, route);
                      },
                      // leading: CircleAvatar(
                      //   backgroundImage: image,
                      // ),
                      title: Text(filteredItems![position].title),
                      subtitle:
                          Text('Released: ' + filteredItems![position].releaseDate + ' - Vote: ' + filteredItems![position].voteAverage.toString()),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
