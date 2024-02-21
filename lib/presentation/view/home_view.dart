import 'package:flutter/material.dart';
import 'package:witdog_recodtester/presentation/res/media_res.dart';
import 'package:witdog_recodtester/presentation/view/pet_profile_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(MediaRes.whiteColor),
        toolbarHeight: 65,
        title: Image.asset(MediaRes.appbarLogoImage),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle_outlined),
            onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => PetProfileView(),),);},
          )
        ],
      ),
      body: Container(
        color: Colors.white, // 흰색 배경으로 설정
        child: ListView(
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.topCenter, // 또는 다른 정렬을 선택하세요
                            child: Column(
                              children: [
                                Text(
                                  '윗독에\n오신 것을\n환영해요',
                                  style: TextStyle(
                                    fontSize: MediaRes.fontSize24,
                                    fontWeight: MediaRes.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    '서비스 소개',
                                    style: TextStyle(
                                        color: Color(MediaRes.whiteColor),
                                        fontSize: MediaRes.fontSize12),
                                  ),
                                  style: ButtonStyle(
                                    //fixedSize: MaterialStateProperty.all(Size(98, 30)),
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(MediaRes.mugwort)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Image.asset(
                            MediaRes.mainCardImage,
                            width: 160,
                            height: 155,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 58,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return buildCard(
                        context,
                        '문자하기',
                        MediaRes.logoImage,
                        onTap: () {
                          _popUp(context);
                        },
                      );
                    case 1:
                      return buildCard(
                        context,
                        '전송하기',
                        MediaRes.logoImage,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Container(),
                            ),
                          );
                        },
                      );
                    case 2:
                      return buildCard(
                        context,
                        '펫봇하기',
                        MediaRes.logoImage,
                        onTap: () {
                  _popUp(context);
                        },
                      );
                    case 3:
                      return buildCard(
                        context,
                        '커뮤니티',
                        MediaRes.logoImage,
                        onTap: () {
                          _popUp(context);
                        },
                      );
                    default:
                      return Container(); // Handle additional cases
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _popUp(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('앱 출시 예정'),
            content: Text('현재 이용 불가합니다.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('닫기'),
              ),
            ],
          );
        });
  }

  Widget buildCard(BuildContext context, String title, String imagePath,
      {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap, // 여기에서 onTap을 설정합니다.
      child: Card(
        color: Color(0xFF6A9E85),
        elevation: 1.5,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagePath, width: 100, height: 100),
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
