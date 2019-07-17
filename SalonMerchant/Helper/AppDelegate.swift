//
//  AppDelegate.swift
//  SalonMerchant
//
//  Created by 刘恒宇 on 2018/9/7.
//  Copyright © 2018年 刘恒宇. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        IQKeyboardManager.shared.enable = true
        db.settings = settings
        return true
    }
    
    func registerRemoteNotification(_ application: UIApplication) {
        // Configure Firebase Cloud Message
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        let notificationOptions: UNAuthorizationOptions = [.badge, .sound, .alert]
        UNUserNotificationCenter.current().requestAuthorization(options: notificationOptions) { _, err in
            debugPrint(err ?? "")
        }
        application.registerForRemoteNotifications()
    }
    
    func messaging(_: Messaging, didReceiveRegistrationToken _: String) {
        postToken()
    }
    
    func postToken() {
        if let userID = Auth.auth().currentUser?.uid, let token = Messaging.messaging().fcmToken {
            Firestore.firestore().collection("user").document(userID).updateData(["token": token as Any])
        } else {
            debugPrint("[FCM] Cannot post token")
        }
    }
}

