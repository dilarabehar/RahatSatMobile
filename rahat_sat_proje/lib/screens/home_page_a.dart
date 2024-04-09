import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rahat_sat_project/screens/login_page.dart';
import 'package:rahat_sat_project/screens/products.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  bool _isFullScreen = false;

  void setFullScreen(bool isFullScreen) {
    setState(() {
      _isFullScreen = isFullScreen;

      if (_isFullScreen) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      } else {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      }
    });
  }

  Widget _buildListTile(IconData icon, String title,Widget destinationScreen) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationScreen),
        );
      },
      leading: SizedBox(
        height: 34,
        width: 34,
        child: Icon(icon),
      ),
      title: Text(title),
    );
  }

  Widget _drawerWidget() {
    return Drawer(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
            const ListTile(
              leading: CircleAvatar(
                radius: 25,
                child: Icon(Icons.shopify_outlined, color: Colors.black),
              ),
              title: Text(
                "Hayal Market",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
            ),
            const Divider(
              color: Colors.black12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Market Sahibi",
                      style:
                          TextStyle(fontStyle: FontStyle.normal, fontSize: 16),
                    ),
                  ),
                ),
                _buildListTile(Icons.home, "Ana Sayfa",HomePage()),
                _buildListTile(Icons.shopping_bag, "Satılan Ürünler",Products()),
                _buildListTile(Icons.person, "Personeller",Products()),
                _buildListTile(Icons.person_off, "Personel İzinleri",Products()),
                _buildListTile(Icons.share_location_rounded, "Satışlar",Products()),
                _buildListTile(Icons.bar_chart_outlined, "Satış İstatikleri",Products()),
                _buildListTile(Icons.pending_actions, "Satış Ekranı",Products()),
                const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Admin",
                      style:
                          TextStyle(fontStyle: FontStyle.normal, fontSize: 16),
                    ),
                  ),
                ),
                _buildListTile(Icons.people, "Kullanıcılar",Products()),
                _buildListTile(Icons.category, "Kategoriler",Products()),
                _buildListTile(Icons.shopping_basket, "Ürünler",Products()),
                _buildListTile(Icons.shopping_basket, "Ürün Talepleri",Products()),
                _buildListTile(Icons.money, "Ürün Tedarikçi Fiyatları",Products()),
                _buildListTile(Icons.add_home_work, "Marketler",Products()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    _isFullScreen ? Icons.fit_screen : Icons.fullscreen,
                  ),
                  onPressed: () => setFullScreen(!_isFullScreen),
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
                IconButton(
                  icon: Icon(_isFullScreen == ThemeMode.dark
                      ? Icons.dark_mode
                      : Icons.light_mode),
                  onPressed: null,
                  color: Colors.black87,
                ),
                IconButton(
                  icon: const Icon(Icons.logout_outlined),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  LoginPage())),
                  color: Colors.black87,
                )
              ],
            ),
          ],
        ),
        drawer: _drawerWidget(),
      ),
    );
  }
}
