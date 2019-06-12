import 'package:flutter/material.dart';
import 'package:ig/singleImageView.dart';
import 'Api_model.dart';
class DownloadPage extends StatefulWidget {
   UserData user;
   DownloadPage(this.user);
  @override
  _DownloadPageState createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: 
      
      GridView.builder(
          itemCount:widget.user.listofPost.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 2,crossAxisSpacing: 2),
          itemBuilder: (BuildContext context,int index)
          {
            return Hero(
             tag: index,
              child: GestureDetector(
                child: Container(
                
              color: Colors.yellow,
              child: Image.network(widget.user.listofPost[index].thumbnail_src),
            ),
            onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>SingleImageView(widget.user.listofPost[index],index))),
              ),
            );
          },
        ) 
    );
  }
}