import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rahat_sat_project/model/markets_model.dart';
import 'package:rahat_sat_project/services/user_client.dart';

//Markets Screen

class MarketsView extends StatefulWidget {
  final List<MarketsModelsListing> inMarketList;

  const MarketsView({Key? key, required this.inMarketList}) : super(key: key);

  @override
  State<MarketsView> createState() => _MarketsViewState();
}

class _MarketsViewState extends State<MarketsView> {
  late List<MarketsModelsListing> marketsList;
  int currentPage = 1; // Initial page
  UserClient userClient = new UserClient();

  @override
  void initState() {
    super.initState();
    marketsList = widget.inMarketList;
  }

  Future<void> loadMoreData() async {
    var additionalData = await userClient.getAllMarkets();
    setState(() {
      marketsList.addAll(additionalData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Marketler"),
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              // Reached the bottom of the list, load more data
              //deneme yorum
              loadMoreData();
            }
            return false;
          },
          child: SingleChildScrollView(
            child: Column(
              children: marketsList.map((markets) {
                return Padding(
                    padding: EdgeInsets.all(3),
                    child: Card(
                      elevation: 3,
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        title: Row(
                          children: [
                            
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    markets.name ?? '',
                                    style: GoogleFonts.getFont('Lato'),
                                  ),
                                  Text(
                                    markets.address ?? '',
                                    style: GoogleFonts.getFont('Lato'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
            ),
          ),
          
        ),
      floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          spaceBetweenChildren: 10,
          children: [
            SpeedDialChild(
              child: Container(
              child:const Text("Yeni Market Oluştur",style: TextStyle(color: Colors.deepPurple),),
              ),
              onTap: (){}),
        
          ],
        ),),
    );
  }
}
