import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Screen1(),
    );
  }
}

// ==================== SCREEN 1 ====================
class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  // Khai báo 2 TextEditingController để lấy dữ liệu từ ô nhập
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _mssvController = TextEditingController();

  // Key dùng cho Form validation
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Giải phóng bộ nhớ khi không dùng nữa
    _userNameController.dispose();
    _mssvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // === PHẦN NỘI DUNG CHÍNH (CÁC KHỐI MÀU) ===
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // --- KHỐI 1 ---
                      _buildBlock(number: "1", color: Colors.blue, height: 70),
                      const SizedBox(height: 8),

                      // --- KHỐI 2 ---
                      _buildBlock(number: "2", color: Colors.red, height: 70),
                      const SizedBox(height: 8),

                      // --- KHỐI 3, 4, 5 ---
                      SizedBox(
                        height: 150,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: _buildBlock(
                                number: "3",
                                color: Colors.amber,
                                textColor: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 1,
                              child: _buildBlock(
                                number: "4",
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 1,
                              child: _buildBlock(
                                number: "5",
                                color: Colors.purple,
                              ),
                            ),
                            const Expanded(flex: 1, child: SizedBox()),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),

                      // --- KHỐI 6 ---
                      _buildBlock(
                        number: "6",
                        color: Colors.orange,
                        height: 150,
                      ),

                      const SizedBox(height: 30),

                      // === FORM NHẬP LIỆU ===
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Ô nhập UserName
                            TextFormField(
                              controller: _userNameController,
                              decoration: const InputDecoration(
                                labelText: "UserName",
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Vui lòng không để trống UserName";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),

                            // Ô nhập MSSV
                            TextFormField(
                              controller: _mssvController,
                              decoration: const InputDecoration(
                                labelText: "MSSV",
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.badge),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Vui lòng không để trống MSSV";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              // === NÚT BẤM Ở BOTTOM-CENTER ===
              // Nút này nằm ngoài Expanded nên sẽ luôn ở dưới cùng màn hình
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  onPressed: () {
                    // Kiểm tra validation
                    if (_formKey.currentState!.validate()) {
                      // Nếu hợp lệ, chuyển sang Screen2 và truyền dữ liệu
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Screen2(
                            userName: _userNameController.text.trim(),
                            mssv: _mssvController.text.trim(),
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Click me",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlock({
    required String number,
    required Color color,
    double? height,
    Color textColor = Colors.white,
  }) {
    return Container(
      height: height,
      width: double.infinity,
      color: color,
      child: Center(
        child: Text(
          number,
          style: TextStyle(
            color: textColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// ==================== SCREEN 2 ====================
class Screen2 extends StatelessWidget {
  // Khai báo 2 biến để nhận dữ liệu truyền từ Screen1
  final String userName;
  final String mssv;

  // Constructor yêu cầu phải truyền userName và mssv vào
  const Screen2({
    super.key,
    required this.userName,
    required this.mssv,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        // === THAY ĐỔI Ở ĐÂY: Dùng Image.asset thay vì Icon ===
        leading: IconButton(
          icon: Image.asset(
            'assets/back_arrow.png', // Đường dẫn đến file ảnh
            width: 30, // Chỉnh kích thước ảnh cho vừa vặn
            height: 30,
          ),
          onPressed: () {
            Navigator.pop(context); // Quay về Screen 1
          },
        ),
        // ====================================================
        title: const Text(
          "Screen 2",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 20),
            const Text(
              "Dữ liệu nhận được:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            // Hiển thị dữ liệu đã nhận
            Text(
              "UserName: $userName",
              style: const TextStyle(fontSize: 20, color: Colors.blue),
            ),
            const SizedBox(height: 10),
            Text(
              "MSSV: $mssv",
              style: const TextStyle(fontSize: 20, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}