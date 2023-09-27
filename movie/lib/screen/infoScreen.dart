import 'package:animated_introduction/animated_introduction.dart';
import 'package:flutter/material.dart';
import 'package:movie/screen/homeScreen.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( body: AnimatedIntroduction(
    slides: pages,
    containerBg: Colors.white70,
    indicatorType: IndicatorType.circle,
    nextText: "Devam",
    doneText: "Anladım",
    skipText: "Geç",
    footerBgColor: Colors.black,
    activeDotColor: Colors.white,
      
    onDone: () {
       Navigator.push(
               context,
               MaterialPageRoute(builder: (context) => const HomePage(title: '',)),
              );
      },
    ),);
  }
  final List<SingleIntroScreen> pages = [
   const SingleIntroScreen(
    title: 'Hoşgeldiniz',
    description: 'Artık filmler hakkında bilgi almak çok kolay! ',
    textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
    imageNetwork: 'https://static.vecteezy.com/system/resources/previews/023/258/285/original/old-person-feeling-happy-graphic-clipart-design-free-png.png',
  ),
   const SingleIntroScreen(
    title: 'İstediğiniz filmi aratın',
    description: 'Sizin için içeriğini hemen getirelim!',
    textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
    imageNetwork: 'https://static.vecteezy.com/system/resources/previews/023/258/375/original/old-person-feeling-happy-graphic-clipart-design-free-png.png',
  ),
   const SingleIntroScreen(
    title: 'Tek filmle sınırlı değil',
    description: 'İstediğiniz başlıktaki tüm filmleri size getiriyoruz!',
    textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
    imageNetwork: 'https://static.vecteezy.com/system/resources/previews/023/258/374/original/old-person-feeling-happy-graphic-clipart-design-free-png.png',
  ),
];
}