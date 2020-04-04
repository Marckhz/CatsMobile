// import 'package:flutter/material.dart';

// Column buttonColumn(Color color, IconData icon, String label){
//   return Column(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children:[
//         Icon(icon, color: color),
//         Container(
//           margin: const EdgeInsets.only(top: 8),
//           child: Text(
//               label,
//               style:TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//                 color:color,
//               ),
//             ),
//           ),
//       ],
//   );
// }

// Widget bottomNavigationBar(BuildContext context) {
//     return Container(
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         buttonColumn(Colors.purpleAccent, Icons.favorite, 'Favorite'),
//         buttonColumn(Colors.blueAccent, Icons.camera, 'Camera'),
//         buttonColumn(Colors.tealAccent, Icons.home, 'Home'),
//       ],
//     ),
//     );
//   }

import 'package:flutter/material.dart';
import 'package:hello_world_from_dart/components/menu/menu_requests/cat_requests.dart';



int index = 0;


BottomNavigationBar createBottomNavigation() {
  return BottomNavigationBar(
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.camera),
        title: Text("Camera")
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.pets),
        title: Text("Cats"),
      ),
    ],
  );
}
