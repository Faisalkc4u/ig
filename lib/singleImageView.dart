
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';

class SingleImageView extends StatefulWidget {
  String _data;
  int index;
  SingleImageView(this._data,this.index);
  @override
  
  _SingleImageViewState createState() => _SingleImageViewState();
}


class _SingleImageViewState extends State<SingleImageView> {
  @override
  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.hardEdge,
        color: Colors.redAccent,
        child:GestureDetector(
          child:  Container(
            padding: EdgeInsets.all(5),
          height: size.height*.07,
          child: Align(child: Text('Download',style: TextStyle(color: Colors.white,fontSize: 25,),textAlign: TextAlign.center,),alignment: Alignment.center,),),
          onTap: ()async{
            try {
  // Saved with this method.
  var imageId = await  ImageDownloader.downloadImage(widget._data);
  if (imageId == null) {
    return;
  }

  // Below is a method of obtaining saved image information.
  var fileName = await ImageDownloader.findName(imageId);
  var path = await ImageDownloader.findPath(imageId);
  var size = await ImageDownloader.findByteSize(imageId);
  var mimeType = await ImageDownloader.findMimeType(imageId);
}  catch (error) {
  print(error);
}
           
          },
        ),
      ),
      body: Container(
      child: Hero(
          tag: widget.index,
          
          child: Image.network(widget._data,fit: BoxFit.contain,),
        ),
    width: double.infinity,
    height: MediaQuery.of(context).size.height,
    ),
    );
  }
}