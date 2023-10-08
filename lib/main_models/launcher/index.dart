/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-10-08 10:35:59
 * @LastEditors: 高江华
 * @LastEditTime: 2023-10-08 11:01:08
 * @Description: file content
 */
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
class UrlLauncher {
  // 拨打电话
  static Future<void> launchPhoneCall(String phone) async {
    final Uri uri = Uri.parse('tel: $phone');
    await canLaunchUrl(uri) ? await launchUrl(uri) : Fluttertoast.showToast(msg: '拨号：$phone 失败！');
  }
  // 打开链接
  static Future<void> launchWebURL(String url) async {
    final Uri uri = Uri.parse(url);
    await canLaunchUrl(uri) ? await launchUrl(uri) : Fluttertoast.showToast(msg: '打开链接失败！');
  }
  // 发送短信
  static Future<void> launchSmsURL(String phone) async {
    final Uri uri = Uri.parse('sms: $phone');
    await canLaunchUrl(uri) ? await launchUrl(uri) : Fluttertoast.showToast(msg: '打开失败！');
  }
  // 发送邮件
  static Future<void> launchEmailURL(String email, String subject, String body) async {
    final Uri uri = Uri.parse('mailto:$email.com?subject=$subject&body=$body');
    await canLaunchUrl(uri) ? await launchUrl(uri) : Fluttertoast.showToast(msg: '打开失败！');
  }
}