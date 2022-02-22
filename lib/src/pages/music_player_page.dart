import 'package:flutter/material.dart';
import 'package:musicplayer/src/widgets/custom_appbar.dart';

class MusicPlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          CustomAppBar(),
          ImageDiscDuration(),
          TitlePlay(),
        ],
      )),
    );
  }
}

class TitlePlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      margin: EdgeInsets.only(top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                'Far Away ',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white70,
                ),
              ),
              Text(
                '-Breaking benjamin',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
          Spacer(),
          FloatingActionButton(
            elevation: 0,
            highlightElevation: 0,
            onPressed: () {},
            backgroundColor: Color(0xffF8CB51),
            child: Icon(Icons.play_arrow),
          )
        ],
      ),
    );
  }
}

class ImageDiscDuration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      margin: EdgeInsets.only(top: 50),
      child: Row(
        children: [
          DiscoImage(),
          Expanded(child: ProgressBar()),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: Colors.white38,
    );
    return Container(
      child: Column(
        children: [
          Text("0:00", style: style),
          SizedBox(
            height: 10,
          ),
          Stack(
            children: [
              Container(
                width: 3,
                height: 230,
                color: Colors.white10,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: 3,
                  height: 150,
                  color: Colors.white70,
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text("0:00", style: style),
        ],
      ),
    );
  }
}

class DiscoImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: [
              Color(0xff484750),
              Color(0xff1E1C24),
            ],
          ),
          borderRadius: BorderRadius.circular(200)),
      padding: EdgeInsets.all(20),
      width: 250,
      height: 250,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(200),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image(image: AssetImage("assets/aurora.jpg")),
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(100)),
              ),
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                    color: Color(0xff1C1C25),
                    borderRadius: BorderRadius.circular(100)),
              )
            ],
          )),
    );
  }
}
