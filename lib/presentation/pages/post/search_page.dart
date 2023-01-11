part of 'post.dart';

class SearchPage extends StatefulWidget {
  final List<PostPageEvent> pop;
  const SearchPage({required this.pop, super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchBloc searchBloc;

  @override
  void initState() {
    super.initState();
    searchBloc = context.read<SearchBloc>();
  }

  void onClearTapped() {
    searchController.text = '';
    searchBloc.add(const SearchQueryEvent(text: ''));
  }

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
            context.read<PostPageBloc>().add(widget.pop.last);
            widget.pop.remove(widget.pop.last);
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
              onChanged: (value) =>
                  searchBloc.add(SearchQueryEvent(text: value)),
              controller: searchController,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () => onClearTapped(),
                  child: const Icon(
                    Icons.clear,
                    color: mainColor,
                  ),
                ),
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

  BlocBuilder<SearchBloc, SearchState> searchList(String idUser) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, searchState) {
        if (searchState is SearchLoadingState) {
          return SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (searchState is SearchErrorState) {
          return Center(
            child: Text(searchState.message),
          );
        }
        if (searchState is SearchSuccessState) {
          return searchState.items.isEmpty
              ? SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 2,
                  child: Center(
                    child: Text(
                      'No Results',
                      style: blackTextFont.copyWith(
                        fontSize: 14,
                        fontWeight: medium,
                      ),
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: searchState.items.length,
                  itemBuilder: ((context, index) {
                    final UserEntity user = searchState.items[index];
                    return BlocBuilder<UserBloc, UserState>(
                      builder: (context, userState) {
                        return GestureDetector(
                          onTap: () {
                            widget.pop.add(GoToSearchPage(widget.pop));
                            if (user.id == (userState as UserLoaded).user.id) {
                              context
                                  .read<PostPageBloc>()
                                  .add(GoToProfilePostPage(
                                    widget.pop,
                                  ));
                            } else {
                              context
                                  .read<PostPageBloc>()
                                  .add(GoToDetailProfilePage(
                                    user.id!,
                                    widget.pop,
                                  ));
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              top: (index == 0) ? 16 : 0,
                              bottom: (index == searchState.items.length - 1)
                                  ? 70
                                  : 12,
                            ),
                            child: UserCard(user: user),
                          ),
                        );
                      },
                    );
                  }),
                );
        }
        return SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 2,
          child: Center(
            child: Text(
              'Enter username to search for users',
              style: blackTextFont.copyWith(
                fontSize: 14,
                fontWeight: medium,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return ListView(
          padding:
              EdgeInsets.fromLTRB(defaultMarginApps, 29, defaultMarginApps, 70),
          children: [
            searchBar(),
            searchList((state as UserLoaded).user.id!),
          ],
        );
      },
    );
  }
}
