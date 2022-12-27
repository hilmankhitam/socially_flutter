part of 'widgets.dart';

class StoryCard extends StatelessWidget {
  final bool isAnyContent;
  const StoryCard({this.isAnyContent = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 70,
          height: 112.5,
          child: Stack(
            children: [
              Container(
                width: 70,
                height: 100,
                decoration: isAnyContent
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://images.unsplash.com/photo-1671638990674-d75dda1d1342?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                          ),
                          fit: BoxFit.cover,
                        ),
                      )
                    : BoxDecoration(
                        color: greyColor,
                        border: Border.all(
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: isAnyContent
                    ? Container(
                        width: 25,
                        height: 25,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          color: greyColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 0.5,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            '+',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
        Text(
          'Hilman',
          style: blackTextFont.copyWith(
            fontSize: 12,
            fontWeight: bold,
          ),
        )
      ],
    );
  }
}
