part of 'chat.dart';

class DetailChatPage extends StatefulWidget {
  const DetailChatPage({super.key});

  @override
  State<DetailChatPage> createState() => _DetailChatPageState();
}

class _DetailChatPageState extends State<DetailChatPage> {
  TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  PreferredSize header() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(87),
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
              'Amina Mark',
              style: blackTextFont.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
            Text(
              'Last seen 2hrs ago',
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

  Widget chatInput() {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/add_image_upload_icon.png',
                  width: 25,
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
                GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    'assets/send_icon.png',
                    width: 25,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(),
      bottomNavigationBar: chatInput(),
      body: ListView(
        padding:
            EdgeInsets.symmetric(horizontal: defaultMarginApps, vertical: 10),
        children: const [
          ChatBubble(
              text: 'Hallo, perkenalkan nama saya hilman khitam',
              isSender: true),
          ChatBubble(text: 'Hallo juga, perkenalkan nama saya Akari Kito'),
          ChatBubble(text: 'Hallo'),
          ChatBubble(text: 'Hallo, Halo Halo', isSender: true),
          ChatBubble(text: 'Hallo', isSender: true),
          ChatBubble(text: 'Hallo, Halo Halo'),
          ChatBubble(text: 'Hallo, icikiwir', isSender: true),
          ChatBubble(text: 'Hallo, CMIIW', isSender: true),
          ChatBubble(text: 'Hallo, CMIIW'),
          ChatBubble(text: 'Hallo, icikiwir'),
        ],
      ),
    );
  }
}
