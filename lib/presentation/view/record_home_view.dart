import 'package:flutter/material.dart';
import 'package:witdog_recodtester/presentation/res/media_res.dart';
import 'package:witdog_recodtester/presentation/view/record_start_view.dart';

class RecordHomeView extends StatefulWidget {
  const RecordHomeView({super.key});

  @override
  State<RecordHomeView> createState() => _RecordHomeViewState();
}

class _RecordHomeViewState extends State<RecordHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(MediaRes.appbarGrayColor)),
        title: Image.asset(
          MediaRes.logoImage,
          width: 119,
          height: 49,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 247,
                child: Image.asset(
                  MediaRes.recordBodyTopImage,
                  width: double.infinity,
                  height: 247,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: 52,
                bottom: 0,
                right: 0,
                left: 0,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '총 0KB',
                        style: TextStyle(
                          color: Color(MediaRes.whiteColor),
                          fontSize: MediaRes.fontSize16,
                          fontWeight: MediaRes.mediumBold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '00:00',
                        style: TextStyle(
                          color: Color(MediaRes.whiteColor),
                          fontSize: MediaRes.fontSize36,
                          fontWeight: MediaRes.extraBold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Image.asset(
              MediaRes.recordHomeImage,
              width: 103,
              height: 103,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Color(MediaRes.mugwort),
                ),
                fixedSize: MaterialStateProperty.all(
                  Size(174, 48),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => RecordStartView(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      const begin = Offset(0.5, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.elasticInOut;

                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: Text(
                '녹음하기',
                style: TextStyle(
                  color: Color(MediaRes.whiteColor),
                  fontSize: MediaRes.fontSize18,
                  fontWeight: MediaRes.semiBold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            child: Text(
              '녹음을 시작하시려면 버튼을\n눌러주세요',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: MediaRes.fontSize16,
                fontWeight: MediaRes.mediumBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
