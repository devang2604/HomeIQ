// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/widgets.dart';
// import 'package:home/wrapper.dart';
// import 'package:home/firebase_options.dart';
// import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';

// @pragma('vm:entry-point')
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       debugShowCheckedModeBanner: false,
//       // theme: ThemeData(
//       //   brightness: Brightness.dark,
//       //   useMaterial3: true,
//       //   fontFamily: 'Poppins',
//       // ),
//       // home: const Wrapper(),
//       home: new MyHomePage(
//         channel: new IOWebSocketChannel.connect(
//           "ws://192.168.213.153:81",
//         ),
//       ),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   final WebSocketChannel channel;
//   const MyHomePage({
//     super.key,
//     required this.channel,
//   });

//   @override
//   _MyHomePageState createState() {
//     return _MyHomePageState();
//   }
// }

// class _MyHomePageState extends State<MyHomePage> {
//   // String json = '';
//   // final channel = IOWebSocketChannel.connect("ws://192.168.213.153:81");

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   streamListener();
//   // }

//   // void streamListener() {
//   //   channel.stream.listen(
//   //     (message) {
//   //       print('Received message: $message');
//   //       setState(() {
//   //         // Handle the message, update UI or store data
//   //       });
//   //     },
//   //     onError: (error) {
//   //       print('WebSocket error: $error');
//   //     },
//   //     onDone: () {
//   //       print('WebSocket closed');
//   //     },
//   //   );
//   // }

//   TextEditingController editingController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("WebSocket Test"),
//         centerTitle: true,
//       ),
//       body: new Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: new Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Form(
//               child: TextFormField(
//                 decoration: InputDecoration(
//                   labelText: "Send any message",
//                 ),
//                 controller: editingController,
//               ),
//             ),
//             Text(""),
//             StreamBuilder(
//               stream: widget.channel.stream,
//               builder: (context, snapshot) {
//                 return Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _sendMyMessage,
//         child: Icon(Icons.send),
//       ),
//     );
//   }

//   void _sendMyMessage() {
//     if (editingController.text.isNotEmpty) {
//       widget.channel.sink.add(editingController.text);
//     }
//   }

//   @override
//   void dispose() {
//     widget.channel.sink.close();
//     super.dispose();
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _webSocket = WebSocketChannel.connect(
    Uri.parse('ws://192.168.213.153:81'),
  );
  final _textStream = StreamController<String>();

  @override
  void initState() {
    super.initState();
    _webSocket.stream.listen((message) {
      _textStream.add(message);
    });
  }

  @override
  void dispose() {
    _webSocket.sink.close();
    _textStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('WebSocket Text'),
        ),
        body: StreamBuilder<String>(
          stream: _textStream.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
