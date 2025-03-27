import Flutter
import UIKit
//import GRDB


func getDatabasePath() -> String? {
    let fileManager = FileManager.default
    if let dir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
        return dir.appendingPathComponent("app.db").path
    }
    return nil
}

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication
            .LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window?.rootViewController as! FlutterViewController
        let methodChannel = FlutterMethodChannel(
            name: "com.example.myapp/methods",
            binaryMessenger: controller.binaryMessenger)
        
        GeneratedPluginRegistrant.register(with: self)
        methodChannel.setMethodCallHandler {
            (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if call.method == "nativeMethod" {
                self.nativeMethod(result: result)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }

        return super.application(
            application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func nativeMethod(result: FlutterResult) {
        print(getDatabasePath())
        fetchUsers()
        let message = "Hello from Swift!"
        result(message)
    }
}

func fetchUsers() {
//    let dbPath = getDatabasePath()!
//    let dbQueue = try! DatabaseQueue(path: dbPath)
//    
//    try! dbQueue.read { db in
//        let rows = try Row.fetchAll(db, sql: "SELECT * FROM users")
//        for row in rows {
//            print("User ID: \(row["id"]), Name: \(row["name"])")
//        }
//    }
}
