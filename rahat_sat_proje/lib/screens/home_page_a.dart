import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rahat_sat_project/model/categories_model.dart';
import 'package:rahat_sat_project/model/markets_model.dart';
import 'package:rahat_sat_project/model/product_model.dart';
import 'package:rahat_sat_project/model/product_requests_model.dart';
import 'package:rahat_sat_project/model/product_retailer_model.dart';
import 'package:rahat_sat_project/model/staff_model.dart';
import 'package:rahat_sat_project/model/staff_permissions_model.dart';
import 'package:rahat_sat_project/model/users_model.dart';
import 'package:rahat_sat_project/screens/categories.dart';
import 'package:rahat_sat_project/screens/login_page.dart';
import 'package:rahat_sat_project/screens/markets.dart';
import 'package:rahat_sat_project/screens/product_list.dart';
import 'package:rahat_sat_project/screens/product_requests.dart';
import 'package:rahat_sat_project/screens/product_retailer_price_screen.dart';
import 'package:rahat_sat_project/screens/product_sold.dart';
import 'package:rahat_sat_project/screens/sales.dart';
import 'package:rahat_sat_project/screens/staff_list.dart';
import 'package:rahat_sat_project/screens/staff_permissions_list.dart';
import 'package:rahat_sat_project/screens/users_list.dart';
import 'package:rahat_sat_project/services/user_client.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  
  get userClient => UserClient();

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  bool _isFullScreen = false;
  bool _login = false;

  // Satılan Ürünler

    void getSoldProducts() {
    setState(() {
      _login = true;
      widget.userClient
          .getProduct()
          .then((response) => onGetSoldProductSucces(response));
    });
  }

    onGetSoldProductSucces(List<SoldListing>? products) {
    setState(() {
      if (products != null) {
        /*for (var product in products) {
          print(product.id); //burdan geliyor ürün özelliği
        }*/
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductSoldView(inProducts: products)));
      }
    });
  }

  //Satışlar
  void getAllSales() {
    setState(() {
      _login = true;
      widget.userClient
          .getSalesProduct()
          .then((response) => onGetSalesProductSucces(response));
    });
  }

  onGetSalesProductSucces(List<SoldListing>? products) {
    setState(() {
      if (products != null) {
        /*for (var product in products) {
          print(product.id); //burdan geliyor ürün özelliği
        }*/
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SalesListView(allSoldProducts: products)));
      }
    });
  }
 //Personel İzinleri
    void getPermissionStaffs() {
    setState(() {
      _login = true;
      widget.userClient
          .getPermissionsStaff()
          .then((response) => onGetPermissionStaffs(response));
    });
  }
  onGetPermissionStaffs(List<StaffPermissionsListing>? permission) {
    setState(() {
      if (permission != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    StaffPermissionListView(inPermissions: permission)));
      }
    });
  }
 // Kullanıcılar
     void getAllUsers() {
    setState(() {
      _login = true;
      widget.userClient
          .getAllUsers()
          .then((response) => onGetAllUsers(response));
    });
  }
  onGetAllUsers(List<UsersModelsListing>? userListings) {
    setState(() {
      if (userListings != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    UsersListView(allUserList: userListings)));
      }
    });
  }
  // Kategoriler
     void getAllCategoriesList() {
    setState(() {
      _login = true;
      widget.userClient
          .fetchCategoriesForPage(1)
          .then((response) => onGetCategoriesSucces(response.cast<CategoriesModels>()));
    });
  }

  onGetCategoriesSucces(List<CategoriesModels>? categories) {
    setState(() {
      if (categories != null) {
        /*for (var product in products) {
          print(product.id); //burdan geliyor ürün özelliği
        }*/
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CategoriesListView(allCategories: categories)));
      }
    });
  }

  // Ürün Talepleri

    void getProductRequestList() {
  setState(() {
    _login = true;
    widget.userClient
        .getProductsRequests()
        .then((response) => onGetProductRequests(response));
  });
}

void onGetProductRequests(List<ProductRequest>? products) {
  setState(() {
    if (products != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductRequestView(inRequestsList: products),
        ),
      );
    }
  });
}

// Ürün Tedarikçi Fiyatları

  void getProductsRetailsPrices() {
  setState(() {
    _login = true;
    widget.userClient
        .getAllProductRetailerPrices()
        .then((response) => onGetProductRetailsPricesRequests(response));
  });
}

void onGetProductRetailsPricesRequests(List<ProductRetailProductRetailPrices>? retailer) {
  setState(() {
    if (retailer != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductRetailerPriceView(inRetailerPrice: retailer),
        ),
      );
    }
  });
}
// Marketler
  void getAllMarketsList() {
  setState(() {
    _login = true;
    widget.userClient
        .getAllMarkets()
        .then((response) => onGetMarketsListRequests(response));
  });
}

void onGetMarketsListRequests(List<MarketsModelsListing>? markets) {
  setState(() {
    if (markets != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MarketsView(inMarketList: markets),
        ),
      );
    }
  });
}
// Ürünler

  void getProductsList() {
    setState(() {
      _login = true;
      widget.userClient
          .fetchDataForPage(1)
          .then((response) => onGetProductListSucces(response));
    });
  }


  onGetProductListSucces(List<ProductListing>? products) {
    setState(() {
      if (products != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProductListView(inProductsList: products)));
      }
    });
  }

// Tüm Personeller
    void getAllStaff() {
    setState(() {
      _login = true;
      widget.userClient
          .getAllStaff()
          .then((response) => onGetStaffListSucces(response));
    });
  }

  onGetStaffListSucces(List<StaffListing>? staffs) {
    setState(() {
      if (staffs != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StaffListView(inStaffList: staffs)));
      }
    });
  }


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



Widget _buildListTile(IconData icon, String title, void Function() onTap) {
  return ListTile(
    onTap: onTap, // Doğrudan getSoldProducts fonksiyonunu buraya ata
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
               //_buildListTile(Icons.home, "Ana Sayfa",HomePage()),
               //_buildListTile(Icons.shopping_bag, "Satılan Ürünler",Products()),
               _buildListTile(Icons.person, "Personeller",getAllStaff),
               _buildListTile(Icons.person_off, "Personel İzinleri",getPermissionStaffs),
               _buildListTile(Icons.shopping_bag, "Satılan Ürünler",getSoldProducts),
               _buildListTile(Icons.share_location_rounded, "Satışlar",getAllSales),
               //_buildListTile(Icons.bar_chart_outlined, "Satış İstatikleri",Products()),
               //_buildListTile(Icons.pending_actions, "Satış Ekranı",Products()),
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
                
                _buildListTile(Icons.category, "Kategoriler",getAllCategoriesList),
                _buildListTile(Icons.people, "Kullanıcılar",getAllUsers),
                _buildListTile(Icons.add_home_work, "Marketler",getAllMarketsList),
                _buildListTile(Icons.shopping_basket, "Ürünler",getProductsList),
                _buildListTile(Icons.shopping_basket, "Ürün Talepleri",getProductRequestList),
                _buildListTile(Icons.money, "Ürün Tedarikçi Fiyatları",getProductsRetailsPrices),
            
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
