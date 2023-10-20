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
  List? filteredItems;
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

  Map<String, String> options = {
    'now_playing': 'Now Playing',
    'popular': 'Popular',
    'top_rated': 'Top Rated',
    'upcoming': 'Upcoming',
    'latest': 'Latest',
  };
  String selectedOption = 'now_playing';
  String appBarTitle = 'Now Playing';

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

  final TextEditingController _searchController = TextEditingController();

  void filterSearchResults(String query) {
    List searchResults = movies!
        .where((item) => item.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      filteredItems = searchResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image;

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: SingleChildScrollView(
        controller: _controller,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
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
                  value: entry.key,
                  child: Text(entry.value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  appBarTitle = options[newValue]!;
                  selectedOption = newValue!;
                  _searchController.text = '';
                  loadData();
                });
              },
            ),
            // Text(movies.toString()),
            ListView.builder(
                shrinkWrap: true,
                itemCount:
                    filteredItems?.length == null ? 0 : filteredItems?.length,
                itemBuilder: (context, int position) {
                  if (filteredItems![position].posterPath != null &&
                      filteredItems![position].posterPath != '') {
                    image = NetworkImage(
                        iconBase + filteredItems![position].posterPath);
                  } else {
                    image = NetworkImage(defaultImage);
                  }
                  print(filteredItems![position].posterPath);
                  print(image);

                  return Card(
                    color: Colors.white,
                    child: ListTile(
                      onTap: () {
                        MaterialPageRoute route = MaterialPageRoute(
                            builder: (_) =>
                                DetailScreen(movie: filteredItems![position]));
                        Navigator.push(context, route);
                      },
                      leading: CircleAvatar(
                        backgroundImage: image,
                      ),
                      title: Text(filteredItems![position].title),
                      subtitle: Text('Released: ' +
                          filteredItems![position].releaseDate +
                          ' - Vote: ' +
                          filteredItems![position].voteAverage.toString()),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
