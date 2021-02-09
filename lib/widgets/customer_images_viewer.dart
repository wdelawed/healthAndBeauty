import 'package:HealthAndBeauty/helpers/uitilities.dart';
import 'package:HealthAndBeauty/model/customer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomerImagesViewer extends StatefulWidget {
  final Customer customer;
  CustomerImagesViewer(this.customer);

  @override
  _CustomerImagesViewerState createState() => _CustomerImagesViewerState();
}

class _CustomerImagesViewerState extends State<CustomerImagesViewer> {
  int selectedPage;
  PageController controller = PageController(initialPage: 0);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _CustomerImagesViewerState() {
    if (!controller.hasListeners) {
      controller.addListener(() {
        if (controller.page == 0.0)
          setState(() {
            selectedPage = 0;
          });
        if (controller.page == 1.0)
          setState(() {
            selectedPage = 1;
          });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(selectedPage == 1 ? "after" : "before"),
      ),
      backgroundColor: Colors.black,
      body: PageView(
        controller: controller,
        children: <Widget>[
          ImagePage(widget.customer.before_img),
          
          ImagePage(widget.customer.after_img) ,
        ],
      ),
    );
  }
}

class ImagePage extends StatelessWidget {
  final String image;
  ImagePage(this.image);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: CachedNetworkImage(
        errorWidget: (_, error, o) {
          return Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.warning,
                      color: Colors.white,
                    ),
                    Container(
                      margin: EdgeInsets.only(top:4),
                      child: Text(
                
                        "Error Loading \nthe Image",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    )
                  ],
                ),
              );
        },
        alignment: Alignment.center,
        fit: BoxFit.fitWidth,
        placeholder: (_, __) {
          return Center(
            child: Container(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 1,
              ),
            ),
          );
        },
        imageUrl: "${Utils.imagesUrl}customers/$image",
      ),
    );
  }
}
