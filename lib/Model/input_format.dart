import 'package:flutter/services.dart';

class InputFormat{
  static List<TextInputFormatter> FullNameInputFormatters=[
    FilteringTextInputFormatter.deny(' ', replacementString: ''),
    FilteringTextInputFormatter.deny('*', replacementString: ''),
    FilteringTextInputFormatter.deny('1', replacementString: ''),
    FilteringTextInputFormatter.deny('2', replacementString: ''),
    FilteringTextInputFormatter.deny('3', replacementString: ''),
    FilteringTextInputFormatter.deny('4', replacementString: ''),
    FilteringTextInputFormatter.deny('6', replacementString: ''),
    FilteringTextInputFormatter.deny('5', replacementString: ''),
    FilteringTextInputFormatter.deny('7', replacementString: ''),
    FilteringTextInputFormatter.deny('8', replacementString: ''),
    FilteringTextInputFormatter.deny('9', replacementString: ''),
    FilteringTextInputFormatter.deny('0', replacementString: ''),
  ];


  static List<TextInputFormatter> KeyVerivyInputFormatters=[
    FilteringTextInputFormatter.allow('1', replacementString: ''),
    FilteringTextInputFormatter.allow('2', replacementString: ''),
    FilteringTextInputFormatter.allow('3', replacementString: ''),
    FilteringTextInputFormatter.allow('4', replacementString: ''),
    FilteringTextInputFormatter.allow('6', replacementString: ''),
    FilteringTextInputFormatter.allow('5', replacementString: ''),
    FilteringTextInputFormatter.allow('7', replacementString: ''),
    FilteringTextInputFormatter.allow('8', replacementString: ''),
    FilteringTextInputFormatter.allow('9', replacementString: ''),
    FilteringTextInputFormatter.allow('0', replacementString: ''),
  ];
  static List<TextInputFormatter> UserNameInputFormatters=[
    FilteringTextInputFormatter.deny(' ', replacementString: ''),
    FilteringTextInputFormatter.deny('ا', replacementString: ''),
    FilteringTextInputFormatter.deny('أ', replacementString: ''),
    FilteringTextInputFormatter.deny('ب', replacementString: ''),
    FilteringTextInputFormatter.deny('ت', replacementString: ''),
    FilteringTextInputFormatter.deny('ث', replacementString: ''),
    FilteringTextInputFormatter.deny('ج', replacementString: ''),
    FilteringTextInputFormatter.deny('ح', replacementString: ''),
    FilteringTextInputFormatter.deny('خ', replacementString: ''),
    FilteringTextInputFormatter.deny('د', replacementString: ''),
    FilteringTextInputFormatter.deny('ذ', replacementString: ''),
    FilteringTextInputFormatter.deny('ر', replacementString: ''),
    FilteringTextInputFormatter.deny('ز', replacementString: ''),
    FilteringTextInputFormatter.deny('س', replacementString: ''),


    FilteringTextInputFormatter.deny('ش', replacementString: ''),
    FilteringTextInputFormatter.deny('ص', replacementString: ''),
    FilteringTextInputFormatter.deny('ض', replacementString: ''),
    FilteringTextInputFormatter.deny('ط', replacementString: ''),


    FilteringTextInputFormatter.deny('ض', replacementString: ''),
    FilteringTextInputFormatter.deny('ع', replacementString: ''),
    FilteringTextInputFormatter.deny('غ', replacementString: ''),
    FilteringTextInputFormatter.deny('ف', replacementString: ''),


    FilteringTextInputFormatter.deny('ق', replacementString: ''),
    FilteringTextInputFormatter.deny('ك', replacementString: ''),
    FilteringTextInputFormatter.deny('ل', replacementString: ''),
    FilteringTextInputFormatter.deny('م', replacementString: ''),

    FilteringTextInputFormatter.deny('ن', replacementString: ''),
    FilteringTextInputFormatter.deny('ه', replacementString: ''),
    FilteringTextInputFormatter.deny('و', replacementString: ''),
    FilteringTextInputFormatter.deny('ي', replacementString: ''),




  ];






  static List<TextInputFormatter> PhoneInputFormatters=[
    FilteringTextInputFormatter.deny(' ', replacementString: ''),
    FilteringTextInputFormatter.deny('ا', replacementString: ''),
    FilteringTextInputFormatter.deny('أ', replacementString: ''),
    FilteringTextInputFormatter.deny('ب', replacementString: ''),
    FilteringTextInputFormatter.deny('ت', replacementString: ''),
    FilteringTextInputFormatter.deny('ث', replacementString: ''),
    FilteringTextInputFormatter.deny('ج', replacementString: ''),
    FilteringTextInputFormatter.deny('ح', replacementString: ''),
    FilteringTextInputFormatter.deny('خ', replacementString: ''),
    FilteringTextInputFormatter.deny('د', replacementString: ''),
    FilteringTextInputFormatter.deny('ذ', replacementString: ''),
    FilteringTextInputFormatter.deny('ر', replacementString: ''),
    FilteringTextInputFormatter.deny('ز', replacementString: ''),
    FilteringTextInputFormatter.deny('س', replacementString: ''),


    FilteringTextInputFormatter.deny('ش', replacementString: ''),
    FilteringTextInputFormatter.deny('ص', replacementString: ''),
    FilteringTextInputFormatter.deny('ض', replacementString: ''),
    FilteringTextInputFormatter.deny('ط', replacementString: ''),


    FilteringTextInputFormatter.deny('ض', replacementString: ''),
    FilteringTextInputFormatter.deny('ع', replacementString: ''),
    FilteringTextInputFormatter.deny('غ', replacementString: ''),
    FilteringTextInputFormatter.deny('ف', replacementString: ''),


    FilteringTextInputFormatter.deny('ق', replacementString: ''),
    FilteringTextInputFormatter.deny('ك', replacementString: ''),
    FilteringTextInputFormatter.deny('ل', replacementString: ''),
    FilteringTextInputFormatter.deny('م', replacementString: ''),

    FilteringTextInputFormatter.deny('ن', replacementString: ''),
    FilteringTextInputFormatter.deny('ه', replacementString: ''),
    FilteringTextInputFormatter.deny('و', replacementString: ''),
    FilteringTextInputFormatter.deny('ي', replacementString: ''),




  ];




  static List<TextInputFormatter> EmileinputFormatters=[
    FilteringTextInputFormatter.deny(' ', replacementString: ''),
    FilteringTextInputFormatter.deny('ا', replacementString: ''),
    FilteringTextInputFormatter.deny('أ', replacementString: ''),
    FilteringTextInputFormatter.deny('ب', replacementString: ''),
    FilteringTextInputFormatter.deny('ت', replacementString: ''),
    FilteringTextInputFormatter.deny('ث', replacementString: ''),
    FilteringTextInputFormatter.deny('ج', replacementString: ''),
    FilteringTextInputFormatter.deny('ح', replacementString: ''),
    FilteringTextInputFormatter.deny('خ', replacementString: ''),
    FilteringTextInputFormatter.deny('د', replacementString: ''),
    FilteringTextInputFormatter.deny('ذ', replacementString: ''),
    FilteringTextInputFormatter.deny('ر', replacementString: ''),
    FilteringTextInputFormatter.deny('ز', replacementString: ''),
    FilteringTextInputFormatter.deny('س', replacementString: ''),
    FilteringTextInputFormatter.deny('ش', replacementString: ''),
    FilteringTextInputFormatter.deny('ص', replacementString: ''),
    FilteringTextInputFormatter.deny('ض', replacementString: ''),
    FilteringTextInputFormatter.deny('ط', replacementString: ''),
    FilteringTextInputFormatter.deny('ض', replacementString: ''),
    FilteringTextInputFormatter.deny('ع', replacementString: ''),
    FilteringTextInputFormatter.deny('غ', replacementString: ''),
    FilteringTextInputFormatter.deny('ف', replacementString: ''),
    FilteringTextInputFormatter.deny('ق', replacementString: ''),
    FilteringTextInputFormatter.deny('ك', replacementString: ''),
    FilteringTextInputFormatter.deny('ل', replacementString: ''),
    FilteringTextInputFormatter.deny('م', replacementString: ''),
    FilteringTextInputFormatter.deny('ن', replacementString: ''),
    FilteringTextInputFormatter.deny('ه', replacementString: ''),
    FilteringTextInputFormatter.deny('و', replacementString: ''),
    FilteringTextInputFormatter.deny('ي', replacementString: ''),
  ];



}