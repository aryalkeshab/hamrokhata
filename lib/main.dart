import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hamrokhata/Screens/auth/login.dart';
import 'package:hamrokhata/commons/resources/app_theme.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';
import 'package:hamrokhata/commons/utils/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: kAppName,
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      themeMode: ThemeMode.light,
      theme: AppThemes.lightThemeData,
      darkTheme: AppThemes.darkThemeData,
      initialRoute: Routes.dashboard,
      getPages: AppPages.routes,
    );
  }
}



// void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late Future<List<CategoryModel>> futurePost;

//   @override
//   void initState() {
//     super.initState();
//     // futurePost = fetchPost();
//   }

//   List _loadedPhotos = [];

//   // The function that fetches data from the API
//   Future<void> _fetchData() async {
//     const apiUrl = "http://192.168.1.74:2112/api/categorylist";
//     print(apiUrl);

//     HttpClient client = HttpClient();
//     client.autoUncompress = true;

//     final HttpClientRequest request = await client.getUrl(Uri.parse(apiUrl));
//     // request.headers
//     //     .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
//     final HttpClientResponse response = await request.close();
//     if (response.statusCode == 200) {
//       final String content = await response.transform(utf8.decoder).join();
//       final List data = json.decode(content);
//       print(data);

//       setState(() {
//         _loadedPhotos = data;
//       });
//     } else {
//       print(response.statusCode);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Fetch Data Example',
//       theme: ThemeData(
//         primaryColor: Colors.lightBlueAccent,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Fetch Data Example'),
//         ),
//         body: SafeArea(
//           child: _loadedPhotos.isEmpty
//               ? Center(
//                   child: ElevatedButton(
//                     onPressed: _fetchData,
//                     child: const Text('Load Photos'),
//                   ),
//                 )
//               // The ListView that displays photos
//               : ListView.builder(
//                   itemCount: _loadedPhotos.length,
//                   itemBuilder: (BuildContext ctx, index) {
//                     return ListTile(
//                       leading: Text(_loadedPhotos[index]["description"]),
//                       title: Text(_loadedPhotos[index]['name']),
//                       subtitle: Text('Photo ID: ${_loadedPhotos[index]["id"]}'),
//                     );
//                   },
//                 ),
//         ),
//       ),
//     );
//   }
// }
