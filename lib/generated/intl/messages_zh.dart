// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh';

  static String m0(one, two) => "这里有两个选择:${one}?或是 ${two}";

  static String m1(date) => "当前日期: ${date}";

  static String m2(name) => "你好, ${name}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("关于"),
        "askChoice": m0,
        "cart": MessageLookupByLibrary.simpleMessage("购物车"),
        "category": MessageLookupByLibrary.simpleMessage("分类"),
        "customDateFormat": m1,
        "greet": m2,
        "home": MessageLookupByLibrary.simpleMessage("首页"),
        "hotProduct": MessageLookupByLibrary.simpleMessage("热门商品"),
        "hotTitle": MessageLookupByLibrary.simpleMessage("火爆专区"),
        "message": MessageLookupByLibrary.simpleMessage("消息"),
        "my": MessageLookupByLibrary.simpleMessage("我的"),
        "title": MessageLookupByLibrary.simpleMessage("宫悦商城")
      };
}
