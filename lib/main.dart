import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_meditation_memo/data/meditation_record.dart';
import 'package:simple_meditation_memo/service/timer_service.dart';
import 'package:simple_meditation_memo/ui/countdown_timer.dart';
import 'package:simple_meditation_memo/ui/meditation_record_list.dart';

late Isar isar;

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> initialize() async {
    final dir = await getApplicationSupportDirectory();

    isar = await Isar.open([MeditationRecordSchema],
        directory: dir.path, inspector: true);
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initialize(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('title'),
      ),
      body: const HomeContents(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(timerProvider.notifier).start(10);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.man), label: 'list'),
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'timer'),
        ],
        currentIndex: ref.watch(_bottomNavPosProvider),
        onTap: (value) =>
            ref.read(_bottomNavPosProvider.notifier).state = value,
      ),
    );
  }
}

class HomeContents extends ConsumerWidget {
  const HomeContents({super.key});

  static const list = [
    MeditationRecordList(),
    CountdownTimer()
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return list[ref.watch(_bottomNavPosProvider)];
  }

}

final _bottomNavPosProvider = StateProvider((ref) => 0);
