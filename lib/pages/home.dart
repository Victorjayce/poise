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
    _load();
  }

  Future<void> _load() async {
    await appModel.load();

    setState(() {
      loaded = true;
    });
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
          CustomNavBar(
            currentPage: currentPage,
            controller: controller,
            streak: app.statModel.streak,
          ),
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
