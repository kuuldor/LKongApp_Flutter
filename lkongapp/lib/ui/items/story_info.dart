import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/utils/utils.dart';

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
                        stripHtmlTag(info.subject),
                        style: Theme.of(context).textTheme.title.copyWith(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              // ]),
              // subtitle:
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(info.author),
                          Text("发表于：${info.forumname}"),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(stringFromDate(parseDatetime(info.dateline))),
                      Text("${info.views}查看·${info.replies}回复"),
                    ],
                  ),
                ],
              ),
            ]),
          );
  }
}
