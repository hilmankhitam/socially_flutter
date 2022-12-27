part of 'post.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  TextEditingController searchController = TextEditingController();
  Widget searchBar() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            context.read<PostPageBloc>().add(GoToPostPage());
          },
          child: Container(
            width: 10,
            height: 18.24,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/arrow_back.png'),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1,
                color: mainColor,
              ),
            ),
            height: 34,
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Type something...........',
                hintStyle: mainTextFont.copyWith(
                  fontSize: 10,
                  fontWeight: medium,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset('assets/search_icon.png'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding:
          EdgeInsets.fromLTRB(defaultMarginApps, 29, defaultMarginApps, 70),
      children: [
        searchBar(),
      ],
    );
  }
}
