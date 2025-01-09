import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/view/screen/login_screen.dart';
import 'package:project1/view/screen/news_feed.dart';

import '../../components/sliderr.dart';
import '../../model/slider_model.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<SliderModel> slides = [];
  int currentIndex = 0;
  PageController _controller = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: 0);
    slides = SliderModel().getSlides();
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: _controller,
                onPageChanged: (value){
                  setState(() {
                    currentIndex = value;
                  });
                },
                itemCount: slides.length,
                itemBuilder: (context, index){
                  // contents of slider
                  return Sliderr(
                    index: index,
                    image: slides[index].getImage(),
                    title: slides[index].getTitle(),
                    description: slides[index].getDescription(),
                  );
                }
            ),
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width / 5.5),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(slides.length, (index) => buildDot(index, context),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  if(currentIndex == slides.length - 1){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()),
                    );
                  }
                  _controller.nextPage(duration: Duration(milliseconds: 1000), curve: Curves.ease);
                },
                child: Container(
                  height: 50,
                  margin: EdgeInsets.all(40),
                  width: MediaQuery.of(context).size.width / 2.4,
                  child: Center(
                      child: Text(currentIndex == slides.length - 1 ? "Get Started": "Next",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),)
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff105866),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  // container created for dots
  Container buildDot(int index, BuildContext context){
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xff105866),
      ),
    );
  }
}