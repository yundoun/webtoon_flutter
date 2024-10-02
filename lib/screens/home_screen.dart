import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webtoon_flutter/models/webtoon_model.dart';
import 'package:webtoon_flutter/services/api_services.dart';
import 'package:webtoon_flutter/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiServices.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          title: const Text(
            '오늘의 웹툰',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: FutureBuilder(
            future: webtoons,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Expanded(child: makeList(snapshot))
                      ],
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            }));
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return WebToon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
      separatorBuilder: (context, indedx) => const SizedBox(
        width: 40,
      ),
    );
  }
}
