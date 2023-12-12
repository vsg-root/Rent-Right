import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
    width: 375,
    height: 667,
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(color: Color(0xFF213644)),
    child: Stack(
        children: [
            Positioned(
                left: 28,
                top: 116,
                child: Container(
                    width: 319,
                    height: 110,
                    child: Stack(
                        children: [
                            Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                    width: 319,
                                    height: 110,
                                    decoration: ShapeDecoration(
                                        color: Color(0xFFD9D9D9),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 81,
                                top: 27,
                                child: Text(
                                    'Nome do Usuário',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 13.83,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w200,
                                        height: 0,
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 81,
                                top: 44,
                                child: Text(
                                    'e-mail',
                                    style: TextStyle(
                                        color: Color(0xFF31546B),
                                        fontSize: 24,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w300,
                                        height: 0,
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 277,
                                top: 73,
                                child: Container(
                                    width: 29,
                                    height: 29,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage("https://via.placeholder.com/29x29"),
                                            fit: BoxFit.contain,
                                        ),
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 215,
                top: 579,
                child: Container(
                    width: 132,
                    height: 49,
                    child: Stack(
                        children: [
                            Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                    width: 132,
                                    height: 49,
                                    decoration: ShapeDecoration(
                                        color: Color(0xFFD9D9D9),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 34,
                                top: 17,
                                child: SizedBox(
                                    width: 64,
                                    height: 22,
                                    child: Text(
                                        'Voltar',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w200,
                                            height: 0,
                                        ),
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 36,
                top: 580,
                child: Container(
                    width: 132,
                    height: 48,
                    child: Stack(
                        children: [
                            Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                    width: 132,
                                    height: 48,
                                    decoration: ShapeDecoration(
                                        color: Color(0xFFD9D9D9),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 10,
                                top: 16,
                                child: Text(
                                    'Salvar Alterações',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w200,
                                        height: 0,
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 28,
                top: 20,
                child: SizedBox(
                    width: 199,
                    height: 31.16,
                    child: Text(
                        'Rent Right',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0,
                        ),
                    ),
                ),
            ),
            Positioned(
                left: 72.24,
                top: 321,
                child: Container(
                    width: 249.52,
                    height: 49.50,
                    child: Stack(
                        children: [
                            Positioned(
                                left: 54.76,
                                top: 28,
                                child: SizedBox(
                                    width: 81.60,
                                    height: 8,
                                    child: Text(
                                        'Casa - Sacramento',
                                        style: TextStyle(
                                            color: Colors.black.withOpacity(0.5),
                                            fontSize: 6.66,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w200,
                                            height: 0,
                                        ),
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 54.76,
                                top: 11,
                                child: Text(
                                    'Nome da Pesquisa',
                                    style: TextStyle(
                                        color: Color(0xFF31546B),
                                        fontSize: 14.37,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w300,
                                        height: 0,
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 6.76,
                                top: 6,
                                child: Container(width: 37, height: 37),
                            ),
                            Positioned(
                                left: 8.76,
                                top: 8,
                                child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage("https://via.placeholder.com/35x35"),
                                            fit: BoxFit.contain,
                                        ),
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 223.76,
                                top: 27,
                                child: Container(
                                    width: 18,
                                    height: 18,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage("https://via.placeholder.com/18x18"),
                                            fit: BoxFit.contain,
                                        ),
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 72,
                top: 403,
                child: Container(
                    width: 249.52,
                    height: 49.50,
                    child: Stack(
                        children: [
                            Positioned(
                                left: 54.76,
                                top: 28,
                                child: SizedBox(
                                    width: 81.60,
                                    height: 8,
                                    child: Text(
                                        'Casa - Sacramento',
                                        style: TextStyle(
                                            color: Colors.black.withOpacity(0.5),
                                            fontSize: 6.66,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w200,
                                            height: 0,
                                        ),
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 54.76,
                                top: 11,
                                child: Text(
                                    'Nome da Pesquisa',
                                    style: TextStyle(
                                        color: Color(0xFF31546B),
                                        fontSize: 14.37,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w300,
                                        height: 0,
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 6.76,
                                top: 6,
                                child: Container(width: 37, height: 37),
                            ),
                            Positioned(
                                left: 8.76,
                                top: 8,
                                child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage("https://via.placeholder.com/35x35"),
                                            fit: BoxFit.contain,
                                        ),
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 224,
                                top: 27,
                                child: Container(
                                    width: 18,
                                    height: 18,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage("https://via.placeholder.com/18x18"),
                                            fit: BoxFit.contain,
                                        ),
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 72,
                top: 485,
                child: Container(
                    width: 249.52,
                    height: 49.50,
                    child: Stack(
                        children: [
                            Positioned(
                                left: 54.76,
                                top: 28,
                                child: SizedBox(
                                    width: 81.60,
                                    height: 8,
                                    child: Text(
                                        'Casa - Sacramento',
                                        style: TextStyle(
                                            color: Colors.black.withOpacity(0.5),
                                            fontSize: 6.66,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w200,
                                            height: 0,
                                        ),
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 54.76,
                                top: 11,
                                child: Text(
                                    'Nome da Pesquisa',
                                    style: TextStyle(
                                        color: Color(0xFF31546B),
                                        fontSize: 14.37,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w300,
                                        height: 0,
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 6.76,
                                top: 6,
                                child: Container(width: 37, height: 37),
                            ),
                            Positioned(
                                left: 8.76,
                                top: 8,
                                child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage("https://via.placeholder.com/35x35"),
                                            fit: BoxFit.contain,
                                        ),
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 224,
                                top: 27,
                                child: Container(
                                    width: 18,
                                    height: 18,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage("https://via.placeholder.com/18x18"),
                                            fit: BoxFit.contain,
                                        ),
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 45,
                top: 284,
                child: SizedBox(
                    width: 179,
                    height: 16.93,
                    child: Text(
                        'Pesquisas Predefinidas:',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.61,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0,
                        ),
                    ),
                ),
            ),
        ],
    ),
);
  }
}