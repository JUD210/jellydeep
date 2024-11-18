import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  // 고정된 이미지 및 아이콘 경로
  final String imagePath = 'assets/images/jellyfish.jpg'; // 해파리 이미지 경로
  final String iconPath = 'assets/icons/icon.png'; // 해파리 아이콘 경로

  final TextEditingController urlController =
      TextEditingController(); // URL 입력 필드 제어용 컨트롤러
  final String defaultUrl =
      "https://b7a1-59-6-226-10.ngrok-free.app/"; // 기본 URL

  @override
  void initState() {
    super.initState();

    // Note: 앱이 처음 실행될 때 URL 입력 필드가 비어 있는 경우, defaultUrl을 자동으로 설정해 줌.
    // 이는 사용자가 직접 URL을 입력하지 않아도 기본 설정된 API 엔드포인트를 사용할 수 있게 해줌.
    if (urlController.text.isEmpty) {
      urlController.text = defaultUrl;
    }
  }

  // 서버에 API 요청을 보내 예측 결과를 가져오는 비동기 함수
  Future<void> fetchPrediction(String endpoint) async {
    try {
      // Note: 사용자가 입력한 URL을 가져옴. 기본적으로 initState에서 설정한 defaultUrl이 입력되어 있음.
      final String enteredUrl = urlController.text;
      final http.Response response = await http.get(
        Uri.parse("$enteredUrl$endpoint"), // 사용자가 지정한 엔드포인트와 기본 URL 조합
        headers: <String, String>{
          'Content-Type': 'application/json',
          'ngrok-skip-browser-warning': '69420', // ngrok 브라우저 경고 무시 헤더
        },
      );

      // Note: 서버로부터 받은 응답을 디버그용으로 출력하여, 응답 확인 및 오류 검토에 도움을 줌.
      // 크롬 개발자 도구에서 Console 탭을 열어서 디버그 메시지 확인 가능.
      debugPrint(response.body);

      if (response.statusCode == 200) {
        // 서버의 JSON 응답을 Map 형태로 디코딩하여 필요한 데이터를 추출함.
        final Map<String, dynamic> data =
            jsonDecode(response.body) as Map<String, dynamic>;
        setState(() {
          if (endpoint == 'predict_class') {
            result =
                "Predicted Class: ${data['predicted_class']}"; // 예측된 클래스 결과 저장
          } else if (endpoint == 'predict_score') {
            result =
                "Prediction Score: ${data['prediction_score']}"; // 예측 확률 결과 저장
          }
        });
      } else {
        // 상태 코드가 200이 아닐 경우 오류 메시지 출력
        setState(() {
          result = "Failed to fetch data. Status Code: ${response.statusCode}";
        });
      }
    } catch (e) {
      // 예외 발생 시 오류 메시지를 사용자에게 표시하여 문제 원인 파악에 도움을 줌.
      setState(() {
        result = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jellyfish Classifier"), // 앱의 제목을 설정함
        leading: IconButton(
          icon: Image.asset(
            iconPath,
            width: 48,
            height: 48,
          ), // 해파리 아이콘 이미지 표시
          onPressed: () {},
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              imagePath,
              width: 300,
              height: 300,
            ), // 상단에 고정된 해파리 이미지 표시
            const SizedBox(height: 20),
            TextField(
              controller: urlController, // URL 입력 필드
              decoration: const InputDecoration(labelText: "URL 입력"), // 필드의 라벨
              // Note: 엔터 키 입력 시 기본적으로 'predict_class' 엔드포인트로 예측 실행
              onSubmitted: (_) => fetchPrediction('predict_class'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () =>
                      fetchPrediction('predict_class'), // 해파리 클래스 예측 버튼
                  child: const Text("해파리 클래스 예측"),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () =>
                      fetchPrediction('predict_score'), // 예측 확률 출력 버튼
                  child: const Text("예측 확률 출력"),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Text(
              result, // Note: 예측 결과 표시. setState()를 통해 값이 변경될 때마다 화면에 반영됨.
              style: const TextStyle(fontSize: 18, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
