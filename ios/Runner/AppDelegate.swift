import UIKit
import Flutter

@UIApplicationMain
class AppDelegate: FlutterAppDelegate {
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GeneratedPluginRegistrant.register(with: self.flutterEngine!)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        // 其他初始化配置...
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}