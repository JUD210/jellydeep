import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(const MyApp()); // 앱 실행 진입점
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: JellyfishClassifierPage(), // 메인 페이지 설정
    );
  }
}

class JellyfishClassifierPage extends StatefulWidget {
  const JellyfishClassifierPage({super.key});

  @override
  JellyfishClassifierPageState createState() =>
      JellyfishClassifierPageState(); // StatefulWidget의 State 생성
}

class JellyfishClassifierPageState extends State<JellyfishClassifierPage> {
  String result = ""; // 예측 결과를 저장하는 변수
  final TextEditingController urlController =
      TextEditingController(); // URL 입력 필드 제어용 컨트롤러
  final String defaultUrl = "http://127.0.0.1:12530"; // 기본 URL, 실제 서버 주소로 변경 필요

  final ImagePicker _picker = ImagePicker();
  File? _image;

  @override
  void initState() {
    super.initState();

    if (urlController.text.isEmpty) {
      urlController.text = defaultUrl;
    }
  }

  // 이미지 선택 함수
  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      // 사용자가 이미지를 선택하지 않음
    }
  }

  // 서버에 이미지를 업로드하고 예측 결과를 받아오는 함수
  Future<void> fetchPrediction() async {
    if (_image == null) {
      setState(() {
        result = "먼저 이미지를 선택해주세요.";
      });
      return;
    }

    try {
      final String enteredUrl = urlController.text;
      final Uri uri = Uri.parse("$enteredUrl/predict");

      final request = http.MultipartRequest('POST', uri);
      request.headers.addAll({
        'ngrok-skip-browser-warning': '69420',
      });

      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          _image!.path,
        ),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data =
            jsonDecode(response.body) as Map<String, dynamic>;
        setState(() {
          final predictions = data['predictions'] as Map<String, dynamic>;
          // 각 클래스와 확률을 표시
          result =
              predictions.entries.map((e) => '${e.key}: ${e.value}').join('\n');
        });
      } else {
        setState(() {
          result = "데이터를 가져오는데 실패했습니다. 상태 코드: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        result = "오류 발생: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("해파리 분류기"), // 앱의 제목을 설정함
        ),
        body: Center(
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _image == null
                  ? const Text("이미지가 선택되지 않았습니다.")
                  : Image.file(
                      _image!,
                      width: 300,
                      height: 300,
                    ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('이미지 선택'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: urlController, // URL 입력 필드
                decoration:
                    const InputDecoration(labelText: "서버 URL 입력"), // 필드의 라벨
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: fetchPrediction,
                child: const Text("예측 실행"),
              ),
              const SizedBox(height: 40),
              Text(
                result,
                style: const TextStyle(fontSize: 18, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          )),
        ));
  }
}
