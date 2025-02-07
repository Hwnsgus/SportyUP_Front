import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'mypage_screens.dart'; // 마이페이지 import

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showExtraButtons = false;

  void _toggleExtraButtons() {
    setState(() {
      _showExtraButtons = !_showExtraButtons;
    });
  }

  /// 📸 영상 촬영 후 저장
  Future<void> _captureVideo() async {
    final picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.camera);
    if (video != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> videoList = prefs.getStringList('saved_videos') ?? [];
      videoList.add(video.path);
      await prefs.setStringList('saved_videos', videoList);

      // 촬영 후 마이페이지로 이동
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyPageScreen()),
        );
      }
    }
  }

  Future<void> _uploadVideoToS3(String filePath) async {
    var dio = Dio();
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath, filename: 'video.mp4'),
    });

    try {
      var response = await dio.post('https://your-s3-upload-endpoint.com', data: formData);
      if (response.statusCode == 200) {
        print('업로드 성공!');
      }
    } catch (e) {
      print('업로드 실패: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sporty UP",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {}, // TODO: 사이드 메뉴 기능 추가
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.black),
            onPressed: () {}, // TODO: 도움말 기능 추가
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: DropdownButton<String>(
                  items: const [
                    DropdownMenuItem(value: "value1", child: Text("Value 1")),
                    DropdownMenuItem(value: "value2", child: Text("Value 2")),
                  ],
                  onChanged: (value) {},
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset("assets/banner.png", fit: BoxFit.cover),
            ),
            const SizedBox(height: 20),
            const Text("최근 시청한 강의", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: Image.asset("assets/lecture1.png", fit: BoxFit.cover)),
                const SizedBox(width: 10),
                Expanded(child: Image.asset("assets/lecture2.png", fit: BoxFit.cover)),
              ],
            ),
            const SizedBox(height: 20),
            const Text("주완님을 위한 제품", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: Image.asset("assets/product1.png", fit: BoxFit.cover)),
                const SizedBox(width: 10),
                Expanded(child: Image.asset("assets/product2.png", fit: BoxFit.cover)),
              ],
            ),
          ],
        ),
      ),

      // ⬇️ 하단 네비게이션 바 및 FloatingActionButton
      floatingActionButton: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          if (_showExtraButtons) ...[
            Positioned(
              bottom: 80,
              child: FloatingActionButton.extended(
                heroTag: "photo",
                icon: const Icon(Icons.camera),
                label: const Text("사진 찍기"),
                onPressed: _captureVideo,
              ),
            ),
            Positioned(
              bottom: 140,
              child: FloatingActionButton.extended(
                heroTag: "map",
                icon: const Icon(Icons.map),
                label: const Text("지도 보기"),
                onPressed: () {
                  // TODO: Google Map API 사용하여 지도 화면으로 이동
                },
              ),
            ),
          ],
          FloatingActionButton(
            heroTag: "toggle",
            child: Icon(_showExtraButtons ? Icons.close : Icons.add),
            onPressed: _toggleExtraButtons,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                // 홈 화면으로 이동
              },
            ),
            const SizedBox(width: 48), // FAB 공간 확보
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyPageScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
