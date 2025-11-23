import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:typed_data';

class EditUserScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  const EditUserScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  File? _pickedImage; // dùng cho mobile/desktop
  Uint8List? _pickedBytes; // dùng cho web
  String? _imageName;
  String? imageUrl;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController(text: widget.user['username']);
    emailController = TextEditingController(text: widget.user['email']);
    passwordController = TextEditingController(text: widget.user['password']);
    imageUrl = widget.user['image'];
  }

  // --- Chọn ảnh ---
  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      if (kIsWeb) {
        final bytes = await picked.readAsBytes();
        setState(() {
          _pickedBytes = bytes;
          _imageName = picked.name;
        });
      } else {
        setState(() {
          _pickedImage = File(picked.path);
        });
      }
    }
  }

  // --- Cập nhật người dùng ---
  Future<void> updateUser() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final uri =
        Uri.parse('http://192.168.1.28:3000/users/${widget.user['_id']}'); // dùng được cho web

    var request = http.MultipartRequest('PUT', uri);
    request.fields['username'] = usernameController.text;
    request.fields['email'] = emailController.text;
    request.fields['password'] = passwordController.text;

    // Thêm ảnh
    if (kIsWeb && _pickedBytes != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        _pickedBytes!,
        filename: _imageName ?? 'upload.jpg',
        contentType: MediaType('image', 'jpeg'),
      ));
    } else if (!kIsWeb && _pickedImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        _pickedImage!.path,
        contentType: MediaType('image', 'jpeg'),
      ));
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      request.fields['image'] = imageUrl!;
    }

    final response = await request.send();
    setState(() => _isLoading = false);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(' Cập nhật thành công!')),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(' Lỗi khi cập nhật: ${response.statusCode}')),
      );
    }
  }

  // --- Giao diện ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sửa thông tin',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        elevation: 3,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xffffb6c1), Color(0xffffd9e6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Username
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Tên người dùng',
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Vui lòng nhập tên' : null,
              ),
              const SizedBox(height: 16),

              // Email
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Vui lòng nhập email';
                  final emailRegex =
                      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(val)) return 'Email không hợp lệ';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Password
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Mật khẩu',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                obscureText: true,
                validator: (val) =>
                    val == null || val.length < 6 ? 'Ít nhất 6 ký tự' : null,
              ),
              const SizedBox(height: 20),

              // Ảnh đại diện
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    if (kIsWeb && _pickedBytes != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.memory(
                          _pickedBytes!,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      )
                    else if (!kIsWeb && _pickedImage != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          _pickedImage!,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      )
                    else if (imageUrl != null && imageUrl!.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imageUrl!,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      const Text('Chưa có ảnh'),

                    TextButton.icon(
                      onPressed: pickImage,
                      icon: const Icon(Icons.image, color: Colors.black),
                      label: const Text(
                        'Chọn ảnh mới',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Nút lưu thay đổi
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isLoading ? null : updateUser,
                  icon: _isLoading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.save, color: Colors.black),
                  label: Text(
                    _isLoading ? 'Đang lưu...' : 'Lưu thay đổi',
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade100,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
