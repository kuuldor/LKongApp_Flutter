import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:lkongapp/ui/tools/item_handler.dart';

class StoryInfoItem extends StatelessWidget {
  // final GestureTapCallback onTap;
  final StoryInfoResult info;

  static final storyItemKey = (id) => Key('__story_info_${id}__');

  StoryInfoItem({
    // @required this.onTap,
    @required this.info,
  });

  @override
  Widget build(BuildContext context) {
    LKongAppTheme theme = LKModeledApp.modelOf(context).theme;
    TextStyle headerStyle = theme.headerStyle;
    TextStyle subheadStyle = theme.subheadStyle;
    double size = theme.captionSize;

    return info == null
        ? Container()
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            key: storyItemKey(info.id),
            child: Column(children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        info.subject,
                        style: headerStyle,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size / 3,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(info.author, style: subheadStyle),
                          info.forumname != null
                              ? GestureDetector(
                                  child: Text("${info.forumname ?? '个人位面'}",
                                      style: subheadStyle.apply(
                                          color: theme.linkColor)),
                                  onTap: () => onForumTap(
                                      context,
                                      Forum().rebuild((b) => b
                                        ..name = info.forumname
                                        ..fid = info.fid)),
                                )
                              : Text("个人位面", style: subheadStyle),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(dateStringToLocal(info.dateline),
                          style: subheadStyle),
                      Text("${info.views}查看·${info.replies}回复",
                          style: subheadStyle),
                    ],
                  ),
                ],
              ),
            ]),
          );
  }
}
