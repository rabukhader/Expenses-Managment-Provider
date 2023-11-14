import 'package:flutter/material.dart';

class CamerVewPhoto extends StatelessWidget {
  final String url;
  const CamerVewPhoto({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            var result = false;
            Navigator.pop(context, result);
          },
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          Image.network(url),
          Positioned(
              bottom: 5.0,
              right: 15,
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    var nav = Navigator.of(context);
                    nav.pop();
                    nav.pop();
                  },
                ),
              ))
        ]),
      ),
    );
  }
}
