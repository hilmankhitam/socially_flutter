import 'package:flutter/material.dart';
import 'package:socially/common/styles.dart';
import 'package:socially/presentation/widgets/widgets.dart';

class SocialPage extends StatefulWidget {
  const SocialPage({super.key});

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  TextEditingController searchController = TextEditingController();

  Widget searchView() {
    return Container(
      margin: const EdgeInsets.only(top: 23),
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
    );
  }

  List<String> listStories = [
    'Hai',
    'Nama',
    'Saya',
    'Hilman',
    'Khitam',
  ];

  Widget socialFriends() {
    return Container(
      margin: const EdgeInsets.only(
        top: 21,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Feeling bored?Join a Social',
            style: blackTextFont.copyWith(
              fontWeight: semiBold,
              fontSize: 14,
            ),
          ),
          Text(
            'Selected based on your friends interest',
            style: blackTextFont.copyWith(
              fontWeight: bold,
              fontSize: 10,
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: listStories.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(
                  top: (index == 0) ? 16 : 0,
                  bottom: (index == listStories.length - 1) ? 14 : 24,
                ),
                child: SocialCard(
                  onTap: getIntoSocial,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget socialRecomendations() {
    return Container(
      margin: const EdgeInsets.only(
        top: 21,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Happening Now',
            style: blackTextFont.copyWith(
              fontWeight: semiBold,
              fontSize: 14,
            ),
          ),
          Text(
            'Social going on at the moment',
            style: blackTextFont.copyWith(
              fontWeight: bold,
              fontSize: 10,
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: listStories.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(
                  top: (index == 0) ? 16 : 0,
                  bottom: (index == listStories.length - 1) ? 14 : 24,
                ),
                child: SocialCard(
                  onTap: getIntoSocial,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  List<String> listGroupMembers = [
    'Hai',
    'Nama',
    'Saya',
    'Hilman',
    'Khitam',
    'Akari',
    'Akari',
    'Akari',
    'Akari',
    'Akari',
    'Akari',
    'Akari',
    'Akari',
    'Akari',
    'Akari',
    'Akari',
    'Akari',
    'Akari',
    'Akari',
    'Akari',
    'Akari',
    'Akari',
    'Akari',
  ];

  getIntoSocial() async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (_) {
        return Container(
          margin: const EdgeInsets.fromLTRB(
            18,
            4,
            18,
            34,
          ),
          height: 476,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          width: double.infinity,
          child: Column(
            children: [
              Image.asset(
                'assets/pull_bottom_sheet_icon.png',
                width: 73,
              ),
              const SizedBox(
                height: 12,
              ),
              const SizedBox(
                width: 52,
                height: 52,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1551929175-f82f676827b8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=686&q=80'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Text(
                  'Amina Mark',
                  style: blackTextFont.copyWith(
                    fontSize: 13,
                    fontWeight: semiBold,
                  ),
                ),
              ),
              Text(
                'Host',
                style: blackTextFont.copyWith(
                  fontSize: 8,
                  fontWeight: bold,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisExtent: 50,
                ),
                itemCount: (listGroupMembers.length >= 20)
                    ? 20
                    : listGroupMembers.length,
                itemBuilder: (context, index) {
                  return (index == 19)
                      ? Center(
                          child: Text(
                            '+${listGroupMembers.length - 20} listeners',
                            style: blackTextFont.copyWith(
                              fontSize: 10,
                              fontWeight: medium,
                            ),
                          ),
                        )
                      : SizedBox(
                          width: 71,
                          height: 42,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 33,
                                height: 33,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      'https://images.unsplash.com/photo-1551929175-f82f676827b8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=686&q=80'),
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    width: 31,
                                    child: Text(
                                      'Markyyyy',
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                      style: blackTextFont.copyWith(
                                        fontSize: 12,
                                        fontWeight: semiBold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Listener',
                                    style: blackTextFont.copyWith(
                                      fontSize: 8,
                                      fontWeight: bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                },
              ),
              const SizedBox(
                height: 28,
              ),
              SignInSignUpButton(
                title: 'Stop',
                onPressed: () {},
              ),
            ],
          ),
        );
      },
    );
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Widget buttonAddSocial() {
    return Positioned(
      bottom: 156,
      right: 17,
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  margin: EdgeInsets.only(
                    left: defaultMargin,
                    top: 4,
                    right: defaultMargin,
                  ),
                  height: 354,
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/pull_bottom_sheet_icon.png',
                          width: 73,
                        ),
                      ),
                      const SizedBox(
                        height: 41,
                      ),
                      Text(
                        'Create a lounge',
                        style: blackTextFont.copyWith(
                          fontSize: 18,
                          fontWeight: semiBold,
                        ),
                      ),
                      CustomTextField(
                        title: 'Name',
                        controller: nameController,
                      ),
                      CustomTextField(
                        title: 'Description',
                        controller: descriptionController,
                      ),
                      SignInSignUpButton(
                        title: 'Create',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Container(
          width: 49,
          height: 49,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF006175).withOpacity(0.9),
            boxShadow: [
              BoxShadow(
                color: blackColor.withOpacity(0.5),
                offset: const Offset(0, 4),
                blurRadius: 4,
              ),
            ],
          ),
          child: Center(
            child: SizedBox(
              width: 23,
              height: 24,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      'assets/plus_white_icon.png',
                      width: 9,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Image.asset(
                      'assets/social_white_icon.png',
                      width: 17,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: EdgeInsets.fromLTRB(defaultMargin, 28, defaultMargin, 70),
          children: [
            HeaderPageWidget(
              title: 'Social',
              pop: () {},
            ),
            searchView(),
            socialFriends(),
            socialRecomendations(),
          ],
        ),
        buttonAddSocial(),
      ],
    );
  }
}
