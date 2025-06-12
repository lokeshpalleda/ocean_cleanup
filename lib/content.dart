import 'package:flutter/material.dart';

class Success {
  final String url;
  final String des;

  Success({required this.url, required this.des});
}

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  List<Success> success = [
    Success(url: 'assets/collected.jpeg', des: 'collected 100kg waste'),
    Success(url: 'assets/clean_award.jpeg', des: 'Cleanest Beach award'),
    Success(url: 'assets/best_beach.jpeg', des: 'Best Beach awards 2024'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade100,
        title: Text('Success Stories'),
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
      ),
      body: Stack(
        children:[
           SizedBox.expand(
            child: Image.asset('assets/background.jpg'
            ,fit: BoxFit.fill,),
           ),
           Center(
          child: Column(
            children: [
              Text(
                'Things we achived',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 26),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: success.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: SizedBox(
                          height: 250,
                          width: 350,
                          child: Card(
                            elevation: 2,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    success[index].url,
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.fill,
                                    cacheHeight: 200,
                                    cacheWidth: 200,
                                  ),
                                ),
                                Text(success[index].des,style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16
                                ),)
                              ],
                            )
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
           ]
      ),
    );
  }
}
