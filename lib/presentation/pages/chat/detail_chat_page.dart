part of 'chat.dart';

class DetailChatPage extends StatefulWidget {
  final UserEntity user;
  const DetailChatPage({required this.user, super.key});

  @override
  State<DetailChatPage> createState() => _DetailChatPageState();
}

class _DetailChatPageState extends State<DetailChatPage>
    with WidgetsBindingObserver {
  File? _imageFile;
  TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {}
  }

  PreferredSize header() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(88),
      child: AppBar(
        backgroundColor: whiteColor,
        elevation: 0.5,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: IconButton(
            onPressed: () {
              context.read<PageBloc>().add(const GoToMainPage(3));
            },
            icon: const Icon(
              Icons.chevron_left,
              color: blackColor,
              size: 40,
            ),
          ),
        ),
        title: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            Text(
              widget.user.name!,
              style: blackTextFont.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
            Text(
              widget.user.isOnline!
                  ? 'Online'
                  : 'Last seen ${widget.user.lastSeen!.readTimeStamp(widget.user.lastSeen!.millisecondsSinceEpoch)}',
              style: blackTextFont.copyWith(
                fontSize: 10,
                fontWeight: medium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget image() {
    return Container(
      margin: const EdgeInsets.all(10),
      constraints: const BoxConstraints(
        maxWidth: 225,
        maxHeight: 225,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: greyColor,
      ),
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: FileImage(
              File(_imageFile!.path),
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            _imageFile = null;
            setState(() {});
          },
          child: Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              'assets/clear_icon.png',
              width: 25,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getAndCropImage(ImageSource source) async {
    var image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      _imageFile = File(image.path);
      setState(() {});
    }
  }

  getPhotoFromGalleryOrCamera() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Gallery'),
              onTap: () async {
                getAndCropImage(ImageSource.gallery);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Camera'),
              onTap: () async {
                getAndCropImage(ImageSource.camera);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget chatInput() {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _imageFile == null ? const SizedBox() : image(),
          Container(
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 5),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 2,
                  color: greyColor,
                ),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    getPhotoFromGalleryOrCamera();
                  },
                  child: Image.asset(
                    'assets/add_image_upload_icon.png',
                    width: 25,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    height: 40,
                    child: Center(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Type a comment',
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        controller: messageController,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, userState) {
                    UserEntity myPersonalInfo = (userState as UserLoaded).user;
                    return GestureDetector(
                      onTap: () {
                        if (messageController.text.isNotEmpty) {
                          MessageEntity message = MessageEntity(
                            senderId: myPersonalInfo.id!,
                            createdAt: DateTime.now(),
                            message: messageController.text,
                          );
                          context.read<ChatBloc>().add(SendMessageEvent(
                                widget.user.id!,
                                message,
                              ));
                          messageController.clear();
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
            ),
          ),
        ],
      ),
    );
  }

  Widget body() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        UserEntity myPersonalInfo = (userState as UserLoaded).user;
        return StreamBuilder<List<MessageEntity>>(
            stream: di
                .locator<GetMessagesByIdUseCase>()
                .execute(myPersonalInfo.id!, widget.user.id!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<MessageEntity> messages = snapshot.data!;
                messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
                return ListView.builder(
                  padding: EdgeInsets.symmetric(
                      horizontal: defaultMarginApps, vertical: 10),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    MessageEntity message = messages[index];
                    return ChatBubble(
                      text: message.message,
                      isSender: (message.senderId == myPersonalInfo.id),
                    );
                  },
                );
              } else {
                return const SizedBox();
              }
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(),
      bottomNavigationBar: chatInput(),
      body: body(),
    );
  }
}
