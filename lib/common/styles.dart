import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

double defaultMargin = 27;
double defaultMarginApps = 20;

const Color mainColor = Color(0xFF1C6758);
const Color greyColor = Color(0xFFF2F2F2);
const Color blackColor = Color(0xFF000000);
const Color whiteColor = Color(0xFFFFFFFF);

FontWeight light = FontWeight.w300;
FontWeight reguler = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;

TextStyle blackTextFont = GoogleFonts.poppins()
    .copyWith(color: const Color(0xFF000000), fontWeight: semiBold);
TextStyle whiteTextFont = GoogleFonts.poppins()
    .copyWith(color: const Color(0xFFFFFFFF), fontWeight: semiBold);
TextStyle mainTextFont =
    GoogleFonts.poppins().copyWith(color: mainColor, fontWeight: semiBold);
