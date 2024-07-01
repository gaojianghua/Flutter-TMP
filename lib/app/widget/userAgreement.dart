import 'package:flutter/material.dart';
import '../services/screenAdapter.dart';

class UserAgreement extends StatelessWidget {
  const UserAgreement({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: ScreenAdapter.height(80)),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        children: [
          Checkbox(
              shape: const CircleBorder(),
              materialTapTargetSize:
                  MaterialTapTargetSize.shrinkWrap, // 去除 Checkbox 的默认内边距
              visualDensity: const VisualDensity(horizontal: -2, vertical: -2),
              activeColor: Colors.red,
              value: true,
              onChanged: (v) {}),
          const Text("已阅读并同意"),
          const Text(
            "《商城用户协议》",
            style: TextStyle(color: Colors.red),
          ),
          const Text("《商城隐私协议》", style: TextStyle(color: Colors.red)),
        ],
      ),
    );
  }
}
