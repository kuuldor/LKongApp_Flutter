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
    return info == null
        ? Container()
        : ListTile(
            key: storyItemKey(info.id),
            // onTap: onTap,
            title: Column(children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        info.subject,
                        style: Theme.of(context).textTheme.title.copyWith(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(info.author),
                          info.forumname != null
                              ? GestureDetector(
                                  child: Text("${info.forumname ?? '个人位面'}",
                                      style: TextStyle(color: theme.linkColor)),
                                  onTap: () => onForumTap(
                                      context,
                                      Forum().rebuild((b) => b
                                        ..name = info.forumname
                                        ..fid = info.fid)),
                                )
                              : Text("个人位面"),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(dateStringToLocal(info.dateline)),
                      Text("${info.views}查看·${info.replies}回复"),
                    ],
                  ),
                ],
              ),
            ]),
          );
  }
}
