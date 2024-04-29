import 'package:flutter/material.dart';
import '../core/app_export.dart';
import 'custom_icon_button.dart';

class CustomDialogBox {


   showDialogBox(
       {required BuildContext context,
         String? title,
         VoidCallback? onTapYes,
         VoidCallback? onTapNo
       }) {
     showDialog(
         context: context,
         builder: (context) {
           return Center(
             child: SizedBox(
               height: 150.v,
               width: 320.h,
               child: Container(
                 padding: EdgeInsets.all(16.adaptSize),
                 decoration: AppDecoration.fillGray.copyWith(
                     borderRadius: BorderRadius.circular(12.adaptSize)
                 ),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Text(title ?? '', style: CustomTextStyles.titleLargeBlack900,),
                     SizedBox(height: 24.v,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         CustomIconButton(
                           width: 100.h,
                           height: 44.v,
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(12.adaptSize),
                               color: appTheme.blueGray100,
                               border: Border.all(width: 2.adaptSize, color: appTheme.gray200)),
                           child: Center(child: Text('No', style: CustomTextStyles.bodyLargeBlack90001,)),
                           onTap: (){
                             onTapNo?.call();
                           },
                         ),
                         CustomIconButton(
                           width: 100.h,
                           height: 40.v,
                           child: Center(child: Text('Yes', style: CustomTextStyles.bodyLargePrimary,)),
                           onTap: () {
                             onTapYes?.call();
                           },
                         ),
                       ],
                     )
                   ],
                 ),
               ),
             ),
           );
         });
   }


}
