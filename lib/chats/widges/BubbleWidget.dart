import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gsg_firebase/Auth/Providers/auth_provider.dart';

class BubbleWidget extends StatelessWidget {
  String type;
  Color color;
  Map message;
  Alignment alignment;
  BubbleNip bubbleNip;

  BubbleWidget(
      this.color, this.type, this.message, this.alignment, this.bubbleNip);
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, p, x) {
      if (type == 'message') {
        return Bubble(
          margin: BubbleEdges.only(
            bottom: 10,
            top: 5,
          ),
          alignment: alignment,
          nip: bubbleNip,
          color: color,
          child: Text(
            message['content'],
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15.0),
          ),
          elevation: 1,
        );
      } else if (type == 'image') {
        return Bubble(
          margin: BubbleEdges.only(
            bottom: 10,
            top: 5,
          ),
          alignment: alignment,
          nip: bubbleNip,
          color: color,
          child: Image.network(message['content']),
          elevation: 1,
        );
      } else {
        return Bubble(
          margin: BubbleEdges.only(
            bottom: 10,
            top: 5,
          ),
          alignment: alignment,
          nip: bubbleNip,
          color: color,
          child: GestureDetector(
            onTap: () {
              p.loadFile(message['content']);
            },
            onSecondaryTap: () {
              p.stopRecord();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(p.isPlayingMsg ? Icons.cancel : Icons.play_arrow),
                    Text(
                      'Audio-msg',
                      maxLines: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
          elevation: 1,
        );
      }
      // return Bubble(
      //   margin: BubbleEdges.only(
      //     bottom: 10,
      //     top: 5,
      //   ),
      //   alignment: alignment,
      //   nip: bubbleNip,
      //   color: color,
      //   child: type == 'message'
      //       ? Text(
      //           message['content'],
      //           textAlign: TextAlign.center,
      //           style: TextStyle(fontSize: 15.0),
      //         )
      //       : type == 'image'
      //           ? Image.network(message['imageUrl'])
      //           : GestureDetector(
      //               onTap: () {
      //                 p.loadFile(message['audioUrl']);
      //               },
      //               onSecondaryTap: () {
      //                 p.stopRecord();
      //               },
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 crossAxisAlignment: CrossAxisAlignment.end,
      //                 children: [
      //                   Row(
      //                     children: [
      //                       Icon(p.isPlayingMsg
      //                           ? Icons.cancel
      //                           : Icons.play_arrow),
      //                       Text(
      //                         'Audio-msg',
      //                         maxLines: 10,
      //                       ),
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //             ),
      //   elevation: 1,
      // );
    });
  }
}
