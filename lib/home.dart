import 'package:flutter/material.dart';
import 'Api_model.dart';
import 'downloadpage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _userid;
  GlobalKey<ScaffoldState> _scafold = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _userid = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scafold,
      body: Center(
        child: Container(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                child: Text(
                  'Instagram Downloader ',
                ),
                padding: EdgeInsets.only(left: size.width * .05),
              ),
              Container(
                padding: EdgeInsets.all(size.width * .05),
                width: size.width * 50,
                child: TextField(
                  controller: _userid,
                  decoration: InputDecoration(
                      labelText: 'Enter Instagram Username',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4))),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(
                    left: size.width * .25, right: size.width * .05),
                width: double.infinity,
                child: FlatButton(
                  onPressed: _userid.text==null?null: () async {
                    final user = IGAPIModel(username: _userid.text);
                    if (await user.getUserData()) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              DownloadPage(user.ob)));
                    } else {
                      showSnackBarMEssages('Enter a valid username');
                    }
                  },
                  child: Text('Get'),
                  color: Color.fromRGBO(116, 116, 191, 1.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showSnackBarMEssages(String msg) {
    _scafold.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        label: 'close',
        onPressed: () {
          _scafold.currentState.removeCurrentSnackBar();
        },
        textColor: Colors.yellow,
      ),
    ));
  }
}
