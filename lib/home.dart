import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:saifu/shortcut_model.dart';
import 'package:saifu/enter_data.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  final PageController controller = PageController(initialPage: 0);

  List<ShortcutItemModel> _shortcutList = [
    ShortcutItemModel(name: '弁当', price: '￥550'),
    ShortcutItemModel(name: '美容院', price: '￥2,800'),
    ShortcutItemModel(name: '課金', price: '￥10,000'),
    ShortcutItemModel(name: 'うまい棒', price: '￥10'),
    ShortcutItemModel(price: '￥500'),
    ShortcutItemModel(name: '弁当', price: '￥550'),
    ShortcutItemModel(name: '美容院', price: '￥2,800'),
    ShortcutItemModel(name: '課金', price: '￥10,000'),
    ShortcutItemModel(name: 'うまい棒', price: '￥10'),
    ShortcutItemModel(price: '￥500'),
  ];

  Widget _textLabel({
    double contentWidth,
    String text,
    double fontSize = 25.0,
    Color color = Colors.black,
    TextAlign textAlign = TextAlign.center,
  }) {
    return SizedBox(
      width: contentWidth,
      child: Text(
        '$text',
        style: TextStyle(
          height: 1,
          fontSize: fontSize,
          color: color,
        ),
        textAlign: textAlign,
      ),
    );
  }

  Widget _shortcutButton({
    double contentWidth,
    double contentHeight,
    int index,
  }) {
    return SizedBox(
      width: contentWidth,
      height: contentHeight,

      child: _shortcutList.length > index ? OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _textLabel(contentWidth: contentWidth, text: _shortcutList[index].name != null ? _shortcutList[index].name : '', fontSize: 20.0, color: Colors.grey.shade700),
            _textLabel(contentWidth: contentWidth, text: _shortcutList[index].price, fontSize: 20.0, color: Colors.grey.shade700),
          ],
        ),
        onPressed: () {

        },
      ) : Container(),
    );
  }

  Widget _shortcutItems({double contentWidth, double contentHeight, int pageIndex}) {
    int index = pageIndex * 4;

    return SizedBox(
      height: contentHeight * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: contentWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _shortcutButton(
                    contentWidth: contentWidth * 0.48,
                    contentHeight: contentHeight * 0.46,
                    index: index
                ),
                _shortcutButton(
                    contentWidth: contentWidth * 0.48,
                    contentHeight: contentHeight * 0.46,
                    index: index + 1
                ),
              ],
            ),
          ),
          SizedBox(
            width: contentWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _shortcutButton(
                    contentWidth: contentWidth * 0.48,
                    contentHeight: contentHeight * 0.46,
                    index: index + 2
                ),
                _shortcutButton(
                    contentWidth: contentWidth * 0.48,
                    contentHeight: contentHeight * 0.46,
                    index: index + 3
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: <Widget>[
        SizedBox(
          height: screenHeight * 0.15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _textLabel(contentWidth: screenWidth * 0.8, text: '2021年6月11日の予算', color: Colors.grey.shade600),
              _textLabel(contentWidth: screenWidth * 0.8, text: '￥1,660', fontSize: 45.0, color: Colors.cyan),
              _textLabel(contentWidth: screenWidth * 0.8, text: '/￥1,980', color: Colors.cyan, textAlign: TextAlign.right),
            ],
          ),
        ),

        SizedBox(
          width: screenWidth * 0.8,
          child: LinearPercentIndicator(
            animation: true,
            animationDuration: 500,
            lineHeight: screenHeight * 0.03,
            percent: 0.6,
            // center: Text("60.0%"),
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: Colors.cyan,
          ),
        ),

        SizedBox(
          width: screenWidth * 0.8,
          height: screenHeight * 0.2,

          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.cyan,
              onPrimary: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
            ),

            child: const Icon(Icons.edit, size: 130.0,),

            onPressed: () async {
              final result = await Navigator.of(context).pushNamed('/enter');
              if (result != null) {
                setState(() {
                  _shortcutList.add(result);
                });
              }
            },
          ),
        ),

        SizedBox(
          height: screenHeight * 0.25,
          child: PageView.builder(
            controller: controller,
            itemCount: (_shortcutList.length / 4).ceil(),
            itemBuilder: (BuildContext context, int index) {
              return _shortcutItems(contentWidth: screenWidth * 0.8, contentHeight: screenHeight * 0.25, pageIndex: index);
            },
          ),
        ),

        SmoothPageIndicator(
          controller: controller,
          count: (_shortcutList.length / 4).ceil(),
          effect: SlideEffect(
            activeDotColor: Colors.cyan,
            dotWidth:  screenHeight * 0.02,
            dotHeight:  screenHeight * 0.02,
          ),
        ),
      ],
    );
  }
}
