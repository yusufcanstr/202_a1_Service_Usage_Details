import 'dart:io';
import 'package:a1_servis_kullanimi_detaylar/model/post_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../service/post_service.dart';

class ServiceLearnView extends StatefulWidget {
  const ServiceLearnView({super.key});

  @override
  State<ServiceLearnView> createState() => _ServiceLearnViewState();
}

class _ServiceLearnViewState extends State<ServiceLearnView> {
  List<PostModel>? _items;
  String? name;
  bool _isLoading = false;
  //TEST EDİLEBİLİR KOD BAŞLANGICI
  late final IPostService _postService;

  @override
  void initState() {
    super.initState();
    _postService = PostService();
    name = "Service Learn View";
    fetchPostItemsAdvance();
  }

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> fetchPostItemsAdvance() async {
    _changeLoading();
    _items = await _postService.fetchPostItemsAdvance();
    _changeLoading();
  }

  Future<void> fetchPostItems() async {
    _changeLoading();
    final response = await Dio().get("https://jsonplaceholder.typicode.com/posts");

    if (response.statusCode == HttpStatus.ok) {
      final datas = response.data;

      if (datas is List) {
        setState(() {
          _items = datas.map((e) => PostModel.fromJson(e)).toList();
        });
      }
    }

    _changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent.shade100,
      appBar: AppBar(
        title: Text(name ?? ""),
        backgroundColor: Colors.lightBlueAccent,
        actions: [_isLoading ? const CircularProgressIndicator() : const SizedBox()],
      ),
      body: _items == null
          ? const Placeholder()
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: _items?.length ?? 0,
              itemBuilder: (context, index) {
                return _PostCard(
                  model: _items?[index],
                );
              }),
    );
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({
    required PostModel? model,
  }) : _model = model;

  final PostModel? _model;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        title: Text(_model?.title ?? ""),
        subtitle: Text(_model?.body ?? ""),
      ),
    );
  }
}
