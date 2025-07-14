// import Foundation
// import SwiftUI
// import WebKit
// import UserNotifications

// struct WebViewOctasol: UIViewRepresentable {
//     var url: String = ""
    
//     func makeCoordinator() -> Coordinator {
//         Coordinator(self)
//     }
    
//     func makeUIView(context: Context) -> WKWebView {
//         let contentController = WKUserContentController()
//         contentController.add(context.coordinator, name: "notifyNative")
        
//         let config = WKWebViewConfiguration()
//         config.userContentController = contentController
        
//         let webView = WKWebView(frame: .zero, configuration: config)
        
//         context.coordinator.requestNotificationPermission()
        
//         if let validURL = URL(string: url) {
//             webView.load(URLRequest(url: validURL))
//         }
//         return webView
//     }
    
//     func updateUIView(_ uiView: WKWebView, context: Context) {
//         if let validURL = URL(string: url) {
//             uiView.load(URLRequest(url: validURL))
//         }
//     }
    
//     class Coordinator: NSObject, WKScriptMessageHandler, UNUserNotificationCenterDelegate {
//         var parent: WebViewOctasol
        
//         init(_ parent: WebViewOctasol) {
//             self.parent = parent
//             super.init()
//         }
        
//         func requestNotificationPermission() {
//             let center = UNUserNotificationCenter.current()
//             center.delegate = self
            
//             center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
//                 DispatchQueue.main.async {
//                     if granted {
//                         print("✅ Notification permission granted.")
//                     } else if let error = error {
//                         print("❌ Notification permission error: \(error.localizedDescription)")
//                     } else {
//                         print("⚠️ Notification permission denied.")
//                     }
//                 }
//             }
//         }

//         // Called when a notification is received while app is in foreground
//         func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                     willPresent notification: UNNotification,
//                                     withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//             // ✅ Use option set instead of deprecated array format
//             completionHandler([.banner, .sound, .badge]) // iOS 14+; use .banner instead of .alert
//         }

//         // Called when the user taps on a notification
//         func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                     didReceive response: UNNotificationResponse,
//                                     withCompletionHandler completionHandler: @escaping () -> Void) {
//             print("🔔 Notification tapped: \(response.notification.request.content.body)")
//             completionHandler()
//         }

//         // Called when receiving message from React app via WebView
//         func userContentController(_ userContentController: WKUserContentController,
//                                    didReceive message: WKScriptMessage) {
//             if message.name == "notifyNative", let messageBody = message.body as? String {
//                 showNotification(message: messageBody)
//             }
//         }

//         private func showNotification(message: String) {
//             let content = UNMutableNotificationContent()
//             content.title = "Trading App"
//             content.body = message
//             content.sound = .default
//             content.badge = 1
            
//             let request = UNNotificationRequest(
//                 identifier: UUID().uuidString,
//                 content: content,
//                 trigger: nil // Instant notification
//             )
            
//             UNUserNotificationCenter.current().add(request) { error in
//                 if let error = error {
//                     print("❌ Failed to schedule notification: \(error.localizedDescription)")
//                 } else {
//                     print("✅ Notification scheduled.")
//                 }
//             }
//         }
//     }
// }
