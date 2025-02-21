import 'package:flutter/material.dart';
import '../model/post_model.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
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
