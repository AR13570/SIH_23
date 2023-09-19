import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/scheme_model.dart';
import '../../services/scheme_service.dart';
import '../../services/schemrscrapper_service.dart';

class feedScreen extends StatefulWidget {
  @override
  _feedScreen createState() => _feedScreen();
}

class _feedScreen extends State<feedScreen> {
  bool loading = false;
  List<PackageModel> list = [];
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
        title: Text(
          'Government Schemes',
          style: TextStyle(color: Colors.green),
        ),
      ),
      body: ListView.separated(
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
          //subtitle: Text(list[index].desc), // Display the href
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: loading ? null : () => getPackages(),
          child: loading
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.black,
                ))
              : const Icon(Icons.get_app_outlined)),
    );
  }
}
