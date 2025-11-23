import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ super.key });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card',
      home: Scaffold(
        body: Center(
          child: Card(
            elevation: 10, //do bong
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/ava.jpg'),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Võ Quỳnh Châu',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                  const Text(
                    '22IT033',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey), 
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.phone,
                      color: Colors.blue,),
                      title: const Text('+84 335 061 506'),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.email,
                      color: Colors.red,),
                      title: const Text('chauvq.22it@vku.udn.vn'),
                  ),
                ],
              ),
              
              ),
            
          ),
        ),
      ),
    ) ;
  }
}

