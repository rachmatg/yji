import 'package:flutter/material.dart';
import 'package:yji5/style/theme.dart' as Theme;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yji5/ui/login_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class InfogiatPage extends StatefulWidget  {
  @override
  State<StatefulWidget> createState() => InfogiatPageState();
}

class InfogiatPageState extends State<InfogiatPage> {
  final String apiUrl = "http://www.inaheart.or.id/wp-json/wp/v2/";
  bool _loaded = false;
  List posts;
  getPosts() async {
    var res = await http.get(Uri.encodeFull(apiUrl + "posts?_embed&author=1"), headers: {"Accept": "application/json"});
    // fill our posts list with results and update state
    setState(() {
      var resBody = json.decode(res.body);
      posts = resBody;
      _loaded = true;
    });
  }
  @override
  void initState() {
    super.initState();
    this.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
            title: Text("Info Berita"),
            backgroundColor: Colors.blueAccent
        ),
        body: new ListView.builder(
          itemCount: posts == null ? 0 : posts.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                Card(
                  child: Column(
                    children: <Widget>[
                      !_loaded?
                        new Container(
                          color: Colors.green.withOpacity(0.3),
                          width: MediaQuery.of(context).size.width,//70.0,
                          height: MediaQuery.of(context).size.height, //70.0,
                          child: new Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: new Center(child: new CircularProgressIndicator())),
                        )
                        : new Container(),
                      new Image.network(posts[index]["featured_media"]==0?'':posts[index]["_embedded"]["wp:featuredmedia"][0]["source_url"]),
                      new Padding(
                        padding: EdgeInsets.all(10.0),
                        child: new ListTile(
                          title: new Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: new Text(posts[index]["title"]["rendered"])
                          ),
                          subtitle: new Html(
                              data: posts[index]["excerpt"]["rendered"],
                              onLinkTap: (url) {

                                print(url);
                                _launchURL(url);
                              }
                          )
//                          subtitle: new Text(
//                              posts[index]["excerpt"]["rendered"].replaceAll(new RegExp(r'<[^>]*>'), '')
                          //)
                        )
                      )
                    ],
                  ),
                )
              ],
            );
          }
        )
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => WebviewScaffold(
          url: url,
          initialChild: Center(child: CircularProgressIndicator()),
          appBar: AppBar(title: Text(url))
          ),
        )
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
