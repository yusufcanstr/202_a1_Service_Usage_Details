import 'dart:io';
import 'package:a1_servis_kullanimi_detaylar/utils/service_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../model/post_model.dart';

class ServicePostLearnView extends StatefulWidget {
  const ServicePostLearnView({super.key});

  @override
  State<ServicePostLearnView> createState() => ServicePostLearnViewState();
}

class ServicePostLearnViewState extends State<ServicePostLearnView> {
  bool _isLoading = false;
  late final Dio _networkManager;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _networkManager = Dio(BaseOptions(
      baseUrl: BASE_URL,
    ));
  }

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> addItemToService(PostModel postModel) async {
    _changeLoading();
    final response = await _networkManager.post("posts", data: postModel);
    if (response.statusCode == HttpStatus.created) {
      print("Post işlemi başarılı");
    }
    _changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent.shade100,
      appBar: AppBar(
        title: Text("Service Post Learn View"),
        backgroundColor: Colors.lightBlueAccent,
        actions: [_isLoading ? const CircularProgressIndicator() : const SizedBox()],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          TextField(
            controller: _titleController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: "Enter Title"),
          ),
          TextField(
            controller: _bodyController,
            decoration: InputDecoration(labelText: "Enter Body"),
          ),
          TextField(
            controller: _idController,
            keyboardType: TextInputType.number,
            autofillHints: const [AutofillHints.creditCardNumber],
            decoration: InputDecoration(labelText: "Enter Id"),
          ),
          TextButton(
              onPressed: _isLoading
                  ? null
                  : () {
                      if (_titleController.text.isNotEmpty &&
                          _bodyController.text.isNotEmpty &&
                          _idController.text.isNotEmpty) {
                        final postModel = PostModel(
                          id: int.parse(_idController.text),
                          title: _titleController.text,
                          body: _bodyController.text,
                        );
                        addItemToService(postModel);
                      }
                    },
              child: const Text("Send Post")),
        ],
      ),
    );
  }
}
