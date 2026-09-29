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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                // --- KHỐI 1 ---
                _buildBlock(number: "1", color: Colors.blue, height: 70),
                const SizedBox(height: 8),

                // --- KHỐI 2 ---
                _buildBlock(number: "2", color: Colors.red, height: 70),
                const SizedBox(height: 8),

                // --- KHỐI 3, 4, 5 (Nằm ngang, 3 khối bằng nhau, không tràn màn hình) ---
                SizedBox(
                  height: 150,
                  child: Row(
                    children: [
                      // Khối 3 (Vàng) - Số màu đen, in đậm
                      Expanded(
                        flex: 1, // Chia đều 1 phần
                        child: _buildBlock(
                          number: "3",
                          color: Colors.amber,
                          textColor: Colors.black, // Chữ màu đen
                          isBold: true, // In đậm
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Khối 4 (Xanh lá) - Số màu trắng
                      Expanded(
                        flex: 1, // Chia đều 1 phần
                        child: _buildBlock(number: "4", color: Colors.green),
                      ),
                      const SizedBox(width: 8),

                      // Khối 5 (Tím) - Số màu trắng
                      Expanded(
                        flex: 1, // Chia đều 1 phần
                        child: _buildBlock(number: "5", color: Colors.purple),
                      ),

                      // BÍ QUYẾT: Thêm một khoảng trống (SizedBox) ở cuối
                      // để đẩy 3 khối sang trái và không cho chúng tràn hết màn hình
                      const Expanded(
                        flex: 1, // Chiếm 1 phần không gian (khoảng trắng)
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                // --- KHỐI 6 ---
                _buildBlock(number: "6", color: Colors.orange, height: 150),

                // --- Dòng chữ Họ và tên - MSSV ---
                const SizedBox(height: 50),
                const Text(
                  "Đào Xuân Thành-BIT240215",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Hàm tiện ích để tạo khối màu (đã thêm tham số textColor và isBold)
  Widget _buildBlock({
    required String number,
    required Color color,
    double? height,
    Color textColor = Colors.white, // Mặc định chữ màu trắng
    bool isBold = true, // Mặc định in đậm
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
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}