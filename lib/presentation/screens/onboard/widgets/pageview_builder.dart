import 'package:flutter/material.dart';
import 'package:shop_app/data/models/onboard_model.dart';

class PageViewDesign extends StatelessWidget{

   OnBoardModel page;
   PageViewDesign({required this.page});

  @override
  Widget build(BuildContext context) {
   return  Column(crossAxisAlignment: CrossAxisAlignment.stretch,
     children: [
       SizedBox(height: 20,),
       // Container(height: 500,width: 500,
       //   decoration: BoxDecoration(
       //       image: DecorationImage(image: AssetImage(page.imagepath))
       //   ),
       // ),
       Image.asset(page.imagepath),
       Padding(
         padding: const EdgeInsets.all(20.0),
         child:
         Column(crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
             Text(page.tittle,style: TextStyle(fontSize: 34,fontWeight: FontWeight.bold),),
             SizedBox(height: 15,),
             Text(page.body,style: TextStyle(fontSize: 20),),



           ],
         ),
       ),

     ],
   );
  }

}