import 'package:flutter/material.dart';
import 'package:poise/pages/alltaskpage.dart';
import 'package:poise/pages/historypage.dart';
import 'homepage.dart';
import 'statpage.dart';
import 'package:poise/widgets/custom_navbar.dart';
import 'package:poise/widgets/sidebar.dart';
import 'package:poise/model/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController controller = PageController();

  int currentPage = 0;
  final app = appModel;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _load(context);
    });
  }

  Future<void> _load(BuildContext context) async {
    bool isNewDay = await appModel.load();

    setState(() {
      loaded = true;
    });

    if (!context.mounted) return;

    if (isNewDay) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Color(0xff00001d),
          title: const Text('New Day', style: TextStyle(color: Colors.white)),
          content: const Text(
            'Your tasks have refreshed.',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'OK',
                style: TextStyle(color: Color(0xff40dcc7)),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!loaded) {
      return const Center(
        child: CircularProgressIndicator(
          backgroundColor: Color(0xff00001d),
          color: Color(0xff40dcc7),
        ),
      );
    }

    return Scaffold(
      key: scaffoldKey,
      endDrawer: SideBar(
        onHistory: () {
          final pageContext = context;
          Navigator.pop(context);
          Navigator.push(
            pageContext,
            MaterialPageRoute(builder: (_) => const HistoryPage()),
          );
        },
        onTasks: () {
          final pageContext = context;
          Navigator.pop(context);
          Navigator.push(
            pageContext,
            MaterialPageRoute(builder: (_) => const AllTaskPage()),
          );
        },
        onExit: () => Navigator.pop(context),
      ),

      body: Column(
        children: [
          CustomNavBar(currentPage: currentPage, controller: controller),
          Expanded(
            child: PageView(
              controller: controller,
              onPageChanged: (i) => setState(() => currentPage = i),
              children: const [HomeScreen(), StatsScreen()],
            ),
          ),
        ],
      ),
    );
  }
}
