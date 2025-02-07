import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  List<String> videoList = [];

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  Future<void> _loadVideos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      videoList = prefs.getStringList('saved_videos') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("마이페이지"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "보관함"),
              Tab(text: "친구관리"),
              Tab(text: "설정"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildStorageTab(),
            _buildFriendsTab(),
            _buildSettingsTab(),
          ],
        ),
      ),
    );
  }

  /// 보관함 - 저장된 영상 표시
  Widget _buildStorageTab() {
    return Column(
      children: [
        const SizedBox(height: 10),
        const Text("주완님의 Feedback 영상", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Expanded(
          child: ListView.builder(
            itemCount: videoList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.video_library, color: Colors.blue),
                title: Text(videoList[index].split('/').last),
                onTap: () {
                  // TODO: 영상 재생 화면으로 이동
                },
              );
            },
          ),
        ),
      ],
    );
  }

  /// 친구관리 - 친구 목록 및 추가
  Widget _buildFriendsTab() {
    return Column(
      children: [
        const SizedBox(height: 10),
        const Text("아이디로 친구를 추가하세요!", style: TextStyle(fontSize: 16)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: "Value",
              suffixIcon: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  // TODO: 친구 추가 기능 구현
                },
              ),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView(
            children: const [
              ListTile(
                leading: CircleAvatar(backgroundImage: AssetImage("assets/user1.png")),
                title: Text("Youngsun"),
                subtitle: Text("@youngsun"),
                trailing: Icon(Icons.check_circle, color: Colors.blue),
              ),
              ListTile(
                leading: CircleAvatar(backgroundImage: AssetImage("assets/user2.png")),
                title: Text("Noah P"),
                subtitle: Text("@noah"),
                trailing: Icon(Icons.check_circle, color: Colors.blue),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 설정 - 사용자 정보 수정
  Widget _buildSettingsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildTextField("Name"),
          _buildTextField("Surname"),
          _buildTextField("Email"),
        ],
      ),
    );
  }

  Widget _buildTextField(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
