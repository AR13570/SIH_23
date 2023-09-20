import 'dart:developer';

import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:flutter/material.dart';

import '../model/scheme_model.dart';

class ScrapeService {
  static List<PackageModel> run(String html) {
    try {
      final soup = BeautifulSoup(html);
      //soup.p.
      final base_url = 'https://vikaspedia.in'; // Define the base URL
      final items = soup.findAll('a', class_: 'folderfile_name');
      final List<PackageModel> packages = [];
      final desc = soup.findAll('p', class_: null);
      /*int i=0;
      for (var item in items ) {
        final title = item.text.trim();
        final href = base_url + (item.attributes['href'] ?? '');
        //final desc = soup.findAll('p', class_: null);
        //print(desc);
        //print(desc.runtimeType);
        PackageModel model =
            PackageModel(title: title, href: href, desc: desc[i].toString());
        packages.add(model);
        i++;
      }*/
      for (int i=0;i<items.length;i++) {
        final title = items[i].text.trim();
        final href = base_url + (items[i].attributes['href'] ?? '');
        //final desc = soup.findAll('p', class_: null);
        final para = desc[i].text.trim();
        //print(desc.runtimeType);
        PackageModel model =
        PackageModel(title: title, href: href, desc: para);
        packages.add(model);

      }

      return packages;
    } catch (e) {
      log('2nd->$e');
    }

    return [];
  }
}
