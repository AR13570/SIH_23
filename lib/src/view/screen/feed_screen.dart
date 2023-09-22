import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/scheme_model.dart';
import '../../services/scheme_service.dart';
import '../../services/schemrscrapper_service.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreen createState() => _FeedScreen();
}

class _FeedScreen extends State<FeedScreen> {
  bool loading = false;
  List<PackageModel> list = [];

  @override
  initState() {
    super.initState();
    getPackages();
  }

  Future<void> getPackages() async {
    list.clear();
    loading = true;
    setState(() {});
    final html = await HttpService.get();
    if (html != null) list = ScrapeService.run(html);
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Government Schemes',
          style: TextStyle(color: Colors.green),
        ),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: list.length,
              separatorBuilder: (ctx, index) => const Divider(
                indent: 8,
                endIndent: 8,
              ),
              itemBuilder: (ctx, index) => ListTile(
                onTap: () async {
                  final Uri url = Uri.parse(list[index].href);
                  //final url = 'https://vikaspedia.in' + list[index].href;
                  await launchUrl(url);
                },
                title: Text(list[index].title),
                subtitle: Text(list[index].desc),
                //subtitle: Text(list[index].desc), // Display the href
              ),
            ),
    );
  }
}
