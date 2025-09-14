import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

retrieveRequiredFonts(AppFonts appfonts) {
  switch (appfonts) {
    case AppFonts.small:
      return GoogleFonts.montserrat(
        fontWeight: FontWeight.w500,
        fontSize: 12,
      );
    case AppFonts.medium:
      // TODO: Handle this case.
      throw UnimplementedError();
    case AppFonts.large:
      // TODO: Handle this case.
      throw UnimplementedError();
    case AppFonts.xlarge:
      // TODO: Handle this case.
      throw UnimplementedError();
    case AppFonts.xxlarge:
      // TODO: Handle this case.
      throw UnimplementedError();
    case AppFonts.header:
      // TODO: Handle this case.
      throw UnimplementedError();
    case AppFonts.title:
      return GoogleFonts.montserrat(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      );
    case AppFonts.desc:
      // TODO: Handle this case.
      throw UnimplementedError();
    case AppFonts.body:
      // TODO: Handle this case.
      throw UnimplementedError();
  }
}

enum AppFonts {
  small,
  medium,
  large,
  xlarge,
  xxlarge,
  header,
  title,
  desc,
  body,
}
