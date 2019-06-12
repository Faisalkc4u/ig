
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'Api_model.dart';

class SingleImageView extends StatefulWidget {
  Post _data;
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
          height: size.height*.10,
          child: Text('Download'),),
          onTap: ()async{
            try {
  // Saved with this method.
  var imageId = await  ImageDownloader.downloadImage(widget._data.thumbnail_src);
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
          
          child: Image.network(widget._data.thumbnail_src,fit: BoxFit.contain,),
        ),
    width: double.infinity,
    height: MediaQuery.of(context).size.height,
    ),
    );
  }
}