import Flutter
import GRDB
import UIKit

func getDatabasePath() -> String? {
    let fileManager = FileManager.default
    if let dir = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        .first
    {
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
                if let args = call.arguments as? [String: Any],
                                   let name = args["name"] as? String,
                                   let email = args["email"] as? String {
//                self.nativeMethod(result: result)
                    addUser(name: name, email: email)
                } else {
                                    result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing name or email", details: nil))
                                }
            } else {
                result(FlutterMethodNotImplemented)
            }
        }

        return super.application(
            application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func nativeMethod(result: FlutterResult) {
        print(getDatabasePath())
        //        fetchUsers()
        addUser(name: "Seyi", email: "seyipaye@gmail.com")
        let message = "Hello from Swift!"
        result(message)
    }
}

func fetchUsers() {
    let dbPath = getDatabasePath()!
    let dbQueue = try! DatabaseQueue(path: dbPath)

    try! dbQueue.read { db in
        let rows = try Row.fetchAll(db, sql: "SELECT * FROM users")
        for row in rows {
            print("User ID: \(row["id"]), Name: \(row["name"])")
        }
    }
}

func addUser(name: String, email: String) {
    let dbPath = getDatabasePath()!
    let dbQueue = try! DatabaseQueue(path: dbPath)

    do {
        try dbQueue.write { db in
            let user = User(name: name, email: email)
            try user.insert(db)
        }
        print("User added successfully!")
    } catch {
        print("Failed to add user: \(error)")
    }
}

struct User: Codable, FetchableRecord, PersistableRecord {
    static let databaseTableName = "users" // ✅ Changed to "users"
    var id: Int64?
    var name: String
    var email: String
}
