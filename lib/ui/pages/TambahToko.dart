import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';

class Tambahtoko extends StatelessWidget {
  const Tambahtoko({super.key});

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator Tambahtoko - FRAME
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: 850, // disesuaikan agar tombol tidak keluar layar
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
            color: Color.fromRGBO(247, 247, 247, 1),
          ),
          child: Stack(
            children: <Widget>[
              // HEADER MERAH
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: 430,
                  height: 273,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    color: Color.fromRGBO(245, 101, 69, 1),
                  ),
                ),
              ),

              // JUDUL
              const Positioned(
                top: 38,
                left: 139,
                child: Text(
                  'Tambah Toko',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromRGBO(251, 234, 234, 1),
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    height: 1,
                  ),
                ),
              ),

              // ICON KEMBALI
              Positioned(
                top: 36,
                left: 30,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 33,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: SvgPicture.asset(
                      'assets/images/vector.svg',
                      semanticsLabel: 'back_icon',
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),

              // KOTAK UTAMA
              Positioned(
                top: 120,
                left: 32,
                child: Container(
                  width: 366,
                  height: 555,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color.fromRGBO(254, 243, 226, 1),
                  ),
                  child: Stack(
                    children: <Widget>[
                      const Positioned(
                        top: 42,
                        left: 94,
                        child: Text(
                          'TOKO MILIK ANDA',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromRGBO(245, 101, 69, 1),
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 118,
                        left: 65,
                        child: Container(
                          width: 261,
                          height: 298,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.white,
                            border: Border.all(
                              color: const Color.fromRGBO(245, 101, 69, 1),
                              width: 1,
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Toko A',
                                  style: TextStyle(
                                    color: Color.fromRGBO(245, 101, 69, 1),
                                    fontFamily: 'Poppins',
                                    fontSize: 16.8,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Jln. Ahmad Yani nomor. 13',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 11.5,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Aisyah',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 11.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 213,
                        left: 65,
                        child: Transform.rotate(
                          angle: 0.2195 * (math.pi / 180),
                          child: const Divider(
                            color: Colors.black,
                            thickness: 1,
                            endIndent: 45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 🔽 TOMBOL DIPINDAHKAN KE ATAS (dari 716 → 680)
              Positioned(
                top: 680,
                left: 135,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(245, 101, 69, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(178, 40),
                  ),
                  onPressed: () {
                    // aksi ketika tombol ditekan
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tambah Toko ditekan'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: const Text(
                    'Tambah Toko',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
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
}
