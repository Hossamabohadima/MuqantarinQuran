import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScrollingImageCubit extends Cubit<ScrollingImageState> {
  ScrollingImageCubit() : super(ScrollingImageState());

  List<int> images = [
    1,
    12,
    23,
    32,
    41,
    50,
    60,
    70,
    77,
    87,
    97,
    106,
    117,
    128,
    140,
    151,
    164,
    177,
    187,
    198,
    208,
    215,
    222,
    235,
    249,
    255,
    267,
    274,
    282,
    293,
    305,
    312,
    322,
    332,
    342,
    350,
    360,
    367,
    377,
    385,
    396,
    404,
    415,
    421,
    428,
    434,
    440,
    446,
    453,
    458,
    467,
    477,
    483,
    489,
    496,
    507,
    515,
    523,
    534,
    545,
    553,
    562,
    570,
    578,
    590,
    597,
    602
  ];

  Map<String, int> muqantarinStart = {
    "A1": 293,
    "A2": 305,
    "A3": 312,
    "A4": 322,
    "A5": 332,
    "A6": 342,
    "A7":562,
    "A8":570,

    "B1": 350,
    "B2": 360,
    "B3": 367,
    "B4": 377,
    "B5": 385,
    "B6": 396,
    "B7": 404,
    "B8":578,

    "C1": 415,
    "C2": 421,
    "C3": 428,
    "C4": 434,
    "C5": 440,
    "C6": 446,
    "C7": 453,
    "C8": 458,
    "C9": 467,
    "C10": 477,
    "C11":590,
    "C12":597,

    "D1": 483,
    "D2": 489,
    "D3": 496,
    "D4": 507,
    "D5": 515,
    "D6": 523,
    "D7": 534,
    "D8": 545,
    "D9": 553,
    "D10":602,

    "E1": 560,
    "E2": 562,
    "E3": 570,
    "E4": 578,
    "E5": 590,
    "E6": 597,
    "E7": 602,


  };

  Map<String, int> suraMap = {
    "الفاتحه": 1,
    "البقره": 2,
    "العمران": 50,
    "النساء": 77,
    "المائده": 106,
    "الانعام": 128,
    "الاعراف": 151,
    "الانفال": 177,
    "التوبه": 187,
    "يونس": 208,
    "هود": 221,
    "يوسف": 235,
    "الرعد": 249,
    "ابراهيم": 255,
    "الحجر": 262,
    "النحل": 267,
    "الاسراء": 282,
    "الكهف": 293,
    "مريم": 305,
    "طه": 312,
    "الانبياء": 322,
    "الحج": 332,
    "المؤمنون": 342,
    "النور": 350,
    "الفرقان": 359,
    "الشعراء": 367,
    "النمل": 377,
    "القصص": 385,
    "العنكبوت": 396,
    "الروم": 404,
    "لقمان": 411,
    "السجده": 415,
    "الاحزاب": 418,
    "سبا": 428,
    "فاطر": 434,
    "يس": 440,
    "الصافات": 446,
    "ص": 453,
    "الزمر": 458,
    "غافر": 467,
    "فصلت": 477,
    "الشوري": 483,
    "الزخرف": 489,
    "الدخان": 496,
    "الجاثيه": 499,
    "الاحقاف": 502,
    "محمد": 507,
    "الفتح": 511,
    "الحجرات": 515,
    "ق": 518,
    "الذاريات": 520,
    "الطور": 523,
    "النجم": 526,
    "القمر": 528,
    "الرحمن": 531,
    "الواقعه": 534,
    "الحديد": 537,
    "المجادله": 542,
    "الحشر": 545,
    "الممتحنه": 549,
    "الصف": 551,
    "الجمعه": 553,
    "المنافقون": 554,
    "التغابن": 556,
    "الطلاق": 558,
    "التحريم": 560,
    "الملك": 562,
    "القلم": 564,
    "الحاقه": 566,
    "المعارج": 568,
    "نوح": 570,
    "الجن": 572,
    "المزمل": 574,
    "المدثر": 575,
    "القيامه": 577,
    "الانسان": 578,
    "المرسلات": 580,
    "النبا": 582,
    "النازعات": 583,
    "عبس": 585,
    "التكوير": 586,
    "الانفطار": 587,
    "المطففين": 587,
    "الانشقاق": 589,
    "البروج": 590,
    "الطارق": 591,
    "الاعلي": 591,
    "الغاشيه": 592,
    "الفجر": 593,
    "البلد": 594,
    "الشمس": 595,
    "الليل": 595,
    "الضحي": 596,
    "الشرح": 596,
    "التين": 597,
    "العلق": 597,
    "القدر": 598,
    "البينه": 598,
    "الزلزله": 599,
    "العاديات": 599,
    "القارعه": 600,
    "التكاثر": 600,
    "العصر": 601,
    "الهمزه": 601,
    "الفيل": 601,
    "قريش": 602,
    "الماعون": 602,
    "الكوثر": 602,
    "الكافرون": 603,
    "النصر": 603,
    "المسد": 603,
    "الاخلاص": 604,
    "الفلق": 604,
    "الناس": 604,
  };

  String get image => 'assets/P${images[currentImageIndex]}.png';
  final textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  Timer? _scrollTimer;
  bool isScrolling = false;
  double scrollSpeed = 0;
  int currentImageIndex = 0;
  static const speedFactor = 0.28; //.35;
  int offset = 0;
  double currentScroll = 0;
  double speedratio = 1.0;
  bool readOffset = false;
  int pageH = 660;

  void restoreScrollPosition() {
//    Future.delayed(Duration(milliseconds: 50), () async {  // using from computer
    Future.delayed(Duration(milliseconds: 150), () async {
      // using from Mobile
      final ImagePixels =
          await getImageDimensions('assets/P${images[currentImageIndex]}.png');

      if (scrollController.hasClients) {
        // currentScroll= (readOffset==false)?currentScroll:scrollController.position.maxScrollExtent*pageH*offset/ImagePixels.height/scrollController.position.maxScrollExtent;/*+75*(offset*1.19)*/

        currentScroll = (readOffset == false)
            ? currentScroll
            : pageH * offset / ImagePixels.height;

        scrollController
            .jumpTo(currentScroll * scrollController.position.maxScrollExtent);
        readOffset = false;
        offset = 0;
      }
    });
  }
  void pauseScrolling() {
    updateScroll();
    if (isScrolling)  {
      isScrolling = !isScrolling;
      _scrollTimer?.cancel();
    }

    emit(ScrollingImageState());
  }


  void toggleScrolling() {
    isScrolling = !isScrolling;
    updateScroll();
    if (isScrolling) {
      startScrolling();
    } else {
      _scrollTimer?.cancel();
    }

    emit(ScrollingImageState());
  }

  Future<ui.Image> getImageDimensions(String assetPath) async {
    final data = await rootBundle.load(assetPath);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  Future<void> startScrolling() async {
    _scrollTimer?.cancel();

    restoreScrollPosition();

    if (scrollSpeed >= 0) {
      _scrollTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
        if (scrollController.hasClients) {
          if (isScrolling) {
            //print("always here");
            scrollController.animateTo(
              scrollController.offset + (scrollSpeed * speedFactor),
//              scrollController.offset + (scrollSpeed *speedFactor*speedratio),
              duration: const Duration(milliseconds: 50),
              curve: Curves.linear,
            );
            updateScroll();
          }
        }
      });
    }
  }

  String pageData() {
    updateScroll();
    if (scrollController.hasClients) {
      return "P" +
          images[currentImageIndex].toString() +
          ",ص ${((scrollController.position.maxScrollExtent - scrollController.offset) / 963).toStringAsFixed(0)} ,${((scrollController.position.maxScrollExtent - scrollController.offset) / (scrollSpeed * speedFactor * speedratio * 865.3)).toStringAsFixed(1)} د ";
    }
    return "P" + images[currentImageIndex].toString();
  }

  void updateScroll() {
    if (scrollController.hasClients) {
      currentScroll =
          scrollController.offset / scrollController.position.maxScrollExtent;
      readOffset = false;
      //print("updateScroll__________SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
    }
  }

  void updateScrollSpeed(double speed) {
    scrollSpeed = speed;
    updateScroll();
    emit(ScrollingImageState());
  }

  Map<String, int> pageBlock(int a) {
    Map<String, int> myMap = {"pageIndex": -1, "offset": -1};
    if (a > 604 || a < 1) return myMap;
    int i;
    for (i = 0; i < images.length; i++) {
      if (a < images[i]) {
        break;
      }
    }

    myMap["pageIndex"] = i - 1;
    myMap["offset"] = a - images[i - 1];
    return myMap;
  }

  String getPureArabicWord(String str1) {
    String xx = str1;

    xx = xx.replaceAll(" ", "");
    xx = xx.replaceAll(String.fromCharCode(160), "");

    // توحيد الحروف
    xx = xx.replaceAll("أ", "ا");
    xx = xx.replaceAll("إ", "ا");
    xx = xx.replaceAll("آ", "ا");
    xx = xx.replaceAll("ة", "ه");
    xx = xx.replaceAll("ى", "ي");
    xx = xx.replaceAll(
        String.fromCharCode(170), "ه"); // U+00AA: feminine ordinal indicator

    return xx;
  }

  //-----------------  search function
  void setImageIndex(String searchString) {
    int? inputPage = -1;
    int? index = -1;
    if (!searchString.isEmpty) {
      if (muqantarinStart.containsKey(searchString.toUpperCase())) {
        inputPage = muqantarinStart[searchString.toUpperCase()];
      } else if (suraMap.containsKey(getPureArabicWord(searchString))) {
        inputPage = suraMap[getPureArabicWord(searchString)];
      } else {
        try {
          inputPage = int.parse(searchString);
        } catch (e) {
          inputPage = null;
        }
      }
    }
    if (inputPage != -1 && inputPage != null) {
      Map<String, int> myMap = pageBlock(inputPage);
      index = myMap["pageIndex"];
      offset = myMap["offset"]!;
      readOffset = true;
    }

    if (index != -1 && index != null) {
      isScrolling = false;
      currentImageIndex = index;
      textController.clear();
      emit(ScrollingImageState());
    }
  }

  void nextImage() {
    currentScroll = 0;
    readOffset = false;
    offset = 0;
    isScrolling = false;
    currentImageIndex = (currentImageIndex + 1) % images.length;
    textController.clear();
    emit(ScrollingImageState());
  }

  void lastImage() {
    currentScroll = 0;
    readOffset = false;
    offset = 0;
    isScrolling = false;
    int newIndex = currentImageIndex - 1;
    if (newIndex < 0) newIndex = images.length - 1;
    currentImageIndex = newIndex;
    textController.clear();
    emit(ScrollingImageState());
  }

  @override
  Future<void> close() {
    _scrollTimer?.cancel();
    textController.dispose();
    scrollController.dispose();
    return super.close();
  }

}
class ScrollingImageState {}
