part of 'post.dart';

class CommentPage extends StatefulWidget {
  final String idPost;
  final List<PostPageEvent>? postPagePop;
  final List<ProfilePageEvent>? profilePagePop;
  const CommentPage(
      {required this.idPost, this.postPagePop, this.profilePagePop, super.key});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  late CommentBloc commentBloc;
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CommentBloc>().add(CommentInitialEvent());
    context.read<DetailPostBloc>().add(FetchDetailPostEvent(widget.idPost));
    context.read<GetCommentsBloc>().add(GetAllCommentEvent(widget.idPost));
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget addComment(String idPost, String idUser) {
      return Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 12,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              height: 43,
              decoration: BoxDecoration(
                color: greyColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: mainColor,
                ),
              ),
              child: TextField(
                controller: commentController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: 'Add a comment',
                ),
                style: blackTextFont.copyWith(
                  fontSize: 12,
                  fontWeight: bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 14,
          ),
          BlocBuilder<CommentBloc, CommentState>(
            builder: (context, commentState) {
              if (commentState is CommentLoadingState) {
                return const CircularProgressIndicator();
              }
              return GestureDetector(
                onTap: () {
                  if (commentController.text != '') {
                    context.read<CommentBloc>().add(AddNewCommentEvent(
                        idPost, idUser, commentController.text));

                    commentController.clear();
                    FocusScope.of(context).unfocus();
                  }
                },
                child: Image.asset(
                  'assets/send_icon.png',
                  width: 25,
                ),
              );
            },
          ),
        ],
      );
    }

    Widget listComments(List<CommentEntity> comments, List<UserEntity> users) {
      return ListView.builder(
        itemCount: comments.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: ((context, index) {
          final CommentEntity comment = comments[index];
          final UserEntity user = users[index];
          return Container(
            margin: EdgeInsets.only(
              top: (index == 0) ? 15 : 0,
              bottom: (index == comments.length - 1) ? 0 : 21,
            ),
            child: CommentWidget(
              comment: comment,
              user: user,
            ),
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
            if (widget.postPagePop!.isNotEmpty) {
              context.read<PostPageBloc>().add(widget.postPagePop!.last);
              widget.postPagePop!.remove(widget.postPagePop!.last);
            }
            if (widget.profilePagePop!.isNotEmpty) {
              context.read<ProfilePageBloc>().add(widget.profilePagePop!.last);
              widget.profilePagePop!.remove(widget.profilePagePop!.last);
            }
          },
        ),
        BlocBuilder<UserBloc, UserState>(
          builder: (context, userState) {
            UserEntity myPersonalInfo = (userState as UserLoaded).user;
            return BlocBuilder<DetailPostBloc, DetailPostState>(
              builder: (context, detailPoststate) {
                if (detailPoststate is DetailPostSuccessState) {
                  return BlocBuilder<GetCommentsBloc, GetCommentsState>(
                    builder: (context, commentsState) {
                      if (commentsState is GetCommentSuccessState) {
                        return ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            PostCard(
                              myPersonalId: myPersonalInfo.id!,
                              user: detailPoststate.user,
                              post: detailPoststate.post,
                              likes: detailPoststate.likes,
                              comments: commentsState.comments,
                              isCommentPage: true,
                              onTap: () {},
                            ),
                            addComment(
                              detailPoststate.post.idPost!,
                              myPersonalInfo.id!,
                            ),
                            BlocBuilder<CommentBloc, CommentState>(
                              builder: (context, commentState) {
                                if (commentState is CommentSuccessState) {
                                  return CommentWidget(
                                    comment: commentState.comment,
                                    user: commentState.user,
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                            listComments(
                                commentsState.comments, commentsState.users),
                          ],
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}
