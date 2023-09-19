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
      for (var item in items) {
        final title = item.text.trim();
        final href = base_url + (item.attributes['href'] ?? '');
        final desc = soup.find('p', class_: null);
        //print(desc);
        PackageModel model =
            PackageModel(title: title, href: href, desc: desc.toString());
        packages.add(model);
      }

      return packages;
    } catch (e) {
      log('2nd->$e');
    }

    return [];
  }
}
