import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:rahat_sat_proje/screens/login_page.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _Products();
}

class _Products extends State<Products> {
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

  Widget _buildListTile(IconData icon, String title) {
    return ListTile(
      onTap: null,
      leading: SizedBox(
        height: 34,
        width: 34,
        child: Icon(icon),
      ),
      title: Text(title),
    );
  }
  Widget _drawerWidget(){
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
                          style: TextStyle(
                              fontStyle: FontStyle.normal, fontSize: 16),
                        ),
                      ),
                    ),
                    _buildListTile(Icons.home, "Ana Sayfa"),
                    _buildListTile(Icons.shopping_bag, "Satılan Ürünler"),
                    _buildListTile(Icons.person, "Personeller"),
                    _buildListTile(Icons.person_off, "Personel İzinleri"),
                    _buildListTile(Icons.share_location_rounded, "Satışlar"),
                    _buildListTile(Icons.bar_chart_outlined, "Satış İstatikleri"),
                    _buildListTile(Icons.pending_actions, "Satış Ekranı"),
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Admin",
                          style: TextStyle(
                              fontStyle: FontStyle.normal, fontSize: 16),
                        ),
                      ),
                    ),
                    _buildListTile(Icons.people, "Kullanıcılar"),
                    _buildListTile(Icons.category, "Kategoriler"),
                    _buildListTile(Icons.shopping_basket, "Ürünler"),
                    _buildListTile(Icons.shopping_basket, "Ürün Talepleri"),
                    _buildListTile(Icons.money, "Ürün Tedarikçi Fiyatları"),
                    _buildListTile(Icons.add_home_work, "Marketler"),
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
                  color:const Color.fromARGB(255, 0, 0, 0),
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
                  onPressed:  () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage())),
                  color: Colors.black87,
                )
              ],
            ),
          ],
        ),
        drawer: _drawerWidget(),
        body: ListView.builder(
          itemCount: 10, //TODO
          shrinkWrap: true, 
          itemBuilder: (BuildContext context, int index) => Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.0)
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                         Container(
                      width: 40.0,
                      height: 40.0,
                      color: Colors.deepPurple,
                      child:const CircleAvatar(backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.deepPurple
                      //TODO backgroundImage
                      ) ,
                    ),
                    const SizedBox(width: 5.0),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("Ürün Adı",style: TextStyle(color: Colors.black,fontSize:18.0,fontWeight: FontWeight.bold ),),
                         Text("Kategori",style: TextStyle(color: Colors.grey),),
                      ],
                    ),
                      ],
                    ),
                    Row(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Düzenle"),
                  ),
                  const SizedBox(width: 5.0),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Sil"),
                  ),],),
                  ],
                ),
                
              ),
            ),
          ),
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          spaceBetweenChildren: 10,
          children: [
            SpeedDialChild(
              child: Container(
              child:const Text("Düzenle",style: TextStyle(color: Colors.deepPurple),),
              ),
              onTap: (){}),
            SpeedDialChild(
              child: Container(
              child:const Text("Sil",style: TextStyle(color: Colors.deepPurple),),
              ),
              onTap: (){})
          ],
        ),
      ),
    );
  }
}