//
//  AppDelegate.swift
//  Call_Application
//
//  Created by talha polat on 7.07.2023.
//

import UIKit
import UserNotifications
import TwilioVoice

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        // Override point for customization after application launch.
        registerForRemoteNotifications()
        
        return true
    }
    
    func registerForRemoteNotifications() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else {
                // Bildirimlere erişim izni reddedildi
            }
        }
        UIApplication.shared.registerForRemoteNotifications()
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
         let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print(deviceTokenString)
        print("girdi baba")
         let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImN0eSI6InR3aWxpby1mcGE7dj0xIn0.eyJqdGkiOiJTS2Q2OWU4NDY3MWE2YWFiMmNkMmIyODYxN2UwNmIwOWE4LTE2ODg3OTg0ODgiLCJncmFudHMiOnsiaWRlbnRpdHkiOiJhbGljZSIsInZvaWNlIjp7ImluY29taW5nIjp7ImFsbG93Ijp0cnVlfSwib3V0Z29pbmciOnsiYXBwbGljYXRpb25fc2lkIjoiQVBkNmEyODZjMGQyYTc0ZDNkZmFhN2RjNjM5OGQ1MzRiMSJ9fX0sImlhdCI6MTY4ODc5ODQ4OCwiZXhwIjoxNjg4ODAyMDg4LCJpc3MiOiJTS2Q2OWU4NDY3MWE2YWFiMmNkMmIyODYxN2UwNmIwOWE4Iiwic3ViIjoiQUMzYzAyNTlmYzdhOWFjYzYwNjYzY2I3NGY5ZTVhNWFlZSJ9.PwQi9_DWZfsH3RQ1ib2G2UTLdoVy66Y9BpeCjZrt_k0"
         
         let twilioManager = TwilioManager.shared
         twilioManager.configureTwilio(accessToken: accessToken, deviceToken: deviceToken)
     }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
           // Bildirimlere kaydolma hatası
        print(error.localizedDescription)
       }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

