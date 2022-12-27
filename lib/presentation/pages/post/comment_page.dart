part of 'post.dart';

class CommentPage extends StatelessWidget {
  const CommentPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> listStories = [
      'Hai',
      'Nama',
      'Saya',
      'Hilman',
      'Khitam',
    ];

    Widget listComments() {
      return ListView.builder(
        itemCount: listStories.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: ((context, index) {
          return Container(
            margin: EdgeInsets.only(
              top: (index == 0) ? 15 : 0,
              bottom: (index == listStories.length - 1) ? 0 : 21,
            ),
            child: const CommentWidget(),
          );
        }),
      );
    }

    return ListView(
      padding:
          EdgeInsets.fromLTRB(defaultMarginApps, 28, defaultMarginApps, 70),
      children: [
        HeaderPageWidget(
          title: 'Comment',
          pop: () {
            context.read<PostPageBloc>().add(GoToPostPage());
          },
        ),
        const SizedBox(
          height: 16,
        ),
        PostCard(
          isCommentPage: true,
          onTap: () {},
        ),
        listComments(),
      ],
    );
  }
}
