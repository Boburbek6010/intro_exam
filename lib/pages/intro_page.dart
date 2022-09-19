import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../services/utils/Strings.dart';
import 'home_page.dart';

class IntroPage extends StatefulWidget {
  static const String id = "intro_page";

  const IntroPage({Key? key}) : super(key: key);

  @override
  IntroPageState createState() => IntroPageState();
}

class IntroPageState extends State<IntroPage> {
  late PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  void skip() {
    Navigator.push(
        context, MaterialPageRoute(builder: (content) => const HomePage()));
  }

  void nextPage() {
    _pageController.nextPage(
        duration: const Duration(milliseconds: 1500),
        curve: Curves.easeInOutCubicEmphasized);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              scrollDirection: Axis.vertical,
              onPageChanged: (int page) {
                setState(() {
                  currentIndex = page;
                });
              },
              controller: _pageController,
              children: [
                makePage(
                  title: Strings.stepOneTitle,
                  content: Strings.stepOneContent,
                  image: 'assets/images/img1.png',
                ),
                makePage(
                  title: Strings.stepTwoTitle,
                  content: Strings.stepTwoContent,
                  image: 'assets/images/img2.png',
                ),
                makePage(
                  title: Strings.stepThreeTitle,
                  content: Strings.stepThreeContent,
                  image: 'assets/images/img3.png',
                ),
                makePage(
                  title: Strings.stepFourTitle,
                  content: Strings.stepFourContent,
                  image: 'assets/images/img4.png',
                ),
              ],
            ),
            Row(
              //for position of last blue button
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //in which position that indicator is placed on the screen
                Container(
                  margin: const EdgeInsets.only(bottom: 20, left: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: _buildIndicator(),
                  ),
                ),
                //finding location of indicator in other pages
                currentIndex == 0 ?const Spacer() :const SizedBox.shrink(),
                // currentIndex != 3 ?const Spacer() :const SizedBox.shrink(),
                currentIndex == 0
                //next arrow down button
                    ? Container(
                        height: 60,
                        width: 60,
                        margin: const EdgeInsets.only(bottom: 20, right: 30),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffBAD0FF),
                        ),
                        child: IconButton(
                          splashColor: const Color(0xffBAD0FF),
                          onPressed: () => nextPage(),
                          icon: const Icon(Icons.arrow_downward),
                        ),
                      )
                    : const SizedBox.shrink(),
                currentIndex == 3
                //last blue final button
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 40, right: 30),
                        child: MaterialButton(
                          color: const Color(0xff1D44CB),
                          height: 50,
                          minWidth: MediaQuery.of(context).size.width * 0.7,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () => skip(),
                          child: const Text("Пройти регистрацию", style: TextStyle(
                            color: Colors.white
                          ),),
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ],
        ),
      ),
    );
  }

  //full page of one screen
  Widget makePage({title, content, image}) {
    //for creating formatted sized box
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //skip textButton
          currentIndex == 0
              ? Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () => skip(),
                    child: const Text(
                      "Пропустить",
                      style: TextStyle(
                        fontSize: 17,
                        decoration: TextDecoration.underline,
                        color: Color(0xff3554D1),
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),

          //gradient color and text mix
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              //every image
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(image)),
                ),
                //gradient white color
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [
                          0.35,
                          0.40,
                          0.42,
                          0.47,
                        ],
                        colors: [
                          Colors.white,
                          Colors.white70,
                          Colors.white38,
                          Colors.white10,
                        ]),
                  ),
                ),
              ),
              //both content and title text
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //title text
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  //content text
                  Text(
                    content,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }


  //location of main blue part of indicator
  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 30 : 6,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: isActive ? const Color(0xff3554D1) : const Color(0xffc0c0c0),
          borderRadius: BorderRadius.circular(5)),
    );
  }

  //finding the location of indicator on the current page
  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    if (currentIndex != 3) {
      for (int i = 0; i < 3; i++) {
        if (currentIndex == i) {
          indicators.add(_indicator(true));
        } else {
          indicators.add(_indicator(false));
        }
      }
    }

    return indicators;
  }
}
