part of 'auth.dart';

final List<String> genders = ['Male', 'Female'];

class SignUpPersonalPage extends StatefulWidget {
  final RegistrationData registrationData;
  const SignUpPersonalPage(this.registrationData, {super.key});

  @override
  State<SignUpPersonalPage> createState() => _SignUpPersonalPageState();
}

class _SignUpPersonalPageState extends State<SignUpPersonalPage> {
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    aboutController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    nameController.text = widget.registrationData.name;
    emailController.text = widget.registrationData.email;
    aboutController.text = widget.registrationData.about;
    selectedGender = widget.registrationData.gender;
    dateOfBirth = widget.registrationData.dateOfBirth;
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController aboutController = TextEditingController();

  String selectedGender = genders.first;
  DateTime? dateOfBirth;

  Widget header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => context.read<PageBloc>().add(GoToSignInPage()),
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
          height: 44,
        ),
        const SignInSignUpHeader(
          title: 'Personal Information',
          subtitle: 'Please fill the following',
        ),
      ],
    );
  }

  Widget birthAndGender() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date of birth',
                    style: blackTextFont.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(10)),
                    height: 49,
                    child: GestureDetector(
                      onTap: () {
                        showDatePicker(
                                context: context,
                                initialDate: dateOfBirth == null
                                    ? DateTime.now()
                                    : dateOfBirth!,
                                firstDate: DateTime(1970),
                                lastDate: DateTime(2023))
                            .then((date) {
                          setState((() {
                            dateOfBirth = date;
                          }));
                        });
                      },
                      child: Center(
                          child: Text(dateOfBirth == null
                              ? '00/00/0000'
                              : DateFormat('dd/MM/yyyy').format(dateOfBirth!))),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gender',
                    style: blackTextFont.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(10)),
                    height: 49,
                    child: Center(
                      child: DropdownButton(
                        underline: const SizedBox(),
                        onChanged: (String? value) {
                          setState(() {
                            selectedGender = value!;
                          });
                        },
                        value: selectedGender,
                        items: genders
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem(
                              value: value, child: Text(value));
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget about() {
    return Container(
      margin: const EdgeInsets.only(top: 21),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: blackTextFont.copyWith(
              fontSize: 14,
              fontWeight: medium,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 114,
            child: TextField(
              controller: aboutController,
              maxLines: 8,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToSignInPage());
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: defaultMargin,
                vertical: 32,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  header(),
                  CustomTextField(
                    title: 'Full name',
                    isPassword: false,
                    controller: nameController,
                  ),
                  CustomTextField(
                    title: 'Email Address',
                    isPassword: false,
                    controller: emailController,
                  ),
                  birthAndGender(),
                  about(),
                  SignInSignUpButton(
                    title: 'Next',
                    onPressed: () {
                      if (!(nameController.text.trim() != '' &&
                          emailController.text.trim() != '' &&
                          dateOfBirth != null)) {
                        Flushbar(
                          duration: const Duration(milliseconds: 1500),
                          flushbarPosition: FlushbarPosition.TOP,
                          backgroundColor: blackColor,
                          messageColor: whiteColor,
                          message: 'Please fill all the fields',
                        ).show(context);
                      } else if (!EmailValidator.validate(
                          emailController.text)) {
                        Flushbar(
                          duration: const Duration(milliseconds: 1500),
                          flushbarPosition: FlushbarPosition.TOP,
                          backgroundColor: blackColor,
                          messageColor: whiteColor,
                          message: 'Wrong formatted email address',
                        ).show(context);
                      } else {
                        widget.registrationData.name = nameController.text;
                        widget.registrationData.email = emailController.text;
                        widget.registrationData.dateOfBirth = dateOfBirth!;
                        widget.registrationData.gender = selectedGender;
                        widget.registrationData.about = aboutController.text;

                        context.read<PageBloc>().add(
                            GoToSignUpUsernamePage(widget.registrationData));
                      }
                    },
                  ),
                  const SizedBox(
                    height: 37,
                  ),
                  SignInSignUpFooter(
                    title: 'Already have an account?',
                    subtitle: 'Sign in',
                    onTap: () {
                      context.read<PageBloc>().add(GoToSignInPage());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
