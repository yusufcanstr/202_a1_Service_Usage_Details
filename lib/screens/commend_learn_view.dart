import 'package:a1_servis_kullanimi_detaylar/model/commend_model.dart';
import 'package:a1_servis_kullanimi_detaylar/service/post_service.dart';
import 'package:flutter/material.dart';

import '../components/commend_card.dart';

class CommendLearnView extends StatefulWidget {
  const CommendLearnView({super.key, required this.postId});
  final int? postId;

  @override
  State<CommendLearnView> createState() => _CommendLearnViewState();
}

class _CommendLearnViewState extends State<CommendLearnView> {
  late final IPostService _postService;
  bool _isLoading = false;
  List<CommendModel>? commendItems;

  @override
  initState() {
    super.initState();
    _postService = PostService();
    fetchItemsWithId(widget.postId ?? 0);
  }

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> fetchItemsWithId(int postID) async {
    _changeLoading();
    commendItems = await _postService.fetchRelatedCommentsWithPostId(postID);
    _changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Commend Learn View"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : (commendItems == null || commendItems!.isEmpty)
              ? const Center(child: Text("Henüz yorum yok"))
              : ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: commendItems!.length,
                  itemBuilder: (context, index) {
                    final item = commendItems![index];
                    return CommendCard(item: item);
                  },
                ),
    );
  }
}

