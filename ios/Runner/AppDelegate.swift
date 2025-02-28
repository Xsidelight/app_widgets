import Flutter
import UIKit
import WidgetKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Set up method channel
    let controller = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(
        name: "com.xside.appWidgets/widget",
        binaryMessenger: controller.binaryMessenger)
    
    channel.setMethodCallHandler({ [weak self] (call, result) in
      if call.method == "updateWidgetData" {
        // Extract the data from the call
        guard let data = call.arguments as? [String: Any],
              let widgetData = data["data"] as? String else {
          result(FlutterError(code: "INVALID_ARGUMENTS", 
                             message: "Invalid arguments", 
                             details: nil))
          return
        }
        
        // Store data in UserDefaults (shared with widget)
        if let sharedDefaults = UserDefaults(suiteName: "group.com.xside.appWidgets") {
          sharedDefaults.set(widgetData, forKey: "widgetData")
          sharedDefaults.synchronize()
          
          // Reload all widgets
          if #available(iOS 14.0, *) {
            WidgetCenter.shared.reloadAllTimelines()
          } else {
            // Fallback for older iOS versions
            print("Widgets not available on this iOS version")
          }
          
          result(nil)
        } else {
          result(FlutterError(code: "UNAVAILABLE", 
                            message: "Could not access shared UserDefaults", 
                            details: nil))
        }
      } else {
        result(FlutterMethodNotImplemented)
      }
    })
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
