//
//  AppDelegate.swift
//  Emotional Aid
//
//  Created by itay gervash on 13/06/2021.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth
import FirebaseFirestore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
        
        if UserDefaults.standard.value(forKey: K.def.recommendationsHaveBeenShown) == nil {
            UserDefaults.standard.set(false, forKey: K.def.recommendationsHaveBeenShown)
        }
        if UIApplication.isFirstLaunch() || UserDefaults.standard.value(forKey: K.def.isDemoPreffered) == nil {
            UserDefaults.standard.set(true, forKey: K.def.isDemoPreffered)
        }

        if UserDefaults.standard.value(forKey: "premium") == nil {
            UserDefaults.standard.set(false, forKey: "premium")
        }
        
        if UIApplication.isFirstLaunch() || UserDefaults.standard.value(forKey: "isFemale") == nil {
            UserDefaults.standard.set(true, forKey: "isFemale")
        }
        
        if UIApplication.isFirstLaunch() {
            UserDefaults.standard.register(defaults: [String : Any]())
        }
        
        //1.0.2 hotfix where people could get premium without paying. this removes premium access on first run on new versions.
        if UIApplication.appIsOnFirstRunOnCurrentVersion() && UIApplication.appVersion() == "1.0.2" {
            print("hotfix")
            UserDefaults.standard.set(true, forKey: "premium_hotfix")
            UserDefaults.standard.set(false, forKey: "premium")
        }
        
//        
//        if UserDefaults.standard.value(forKey: "premium") == nil || UserDefaults.standard.bool(forKey: "premium") == false {
//            UserDefaults.standard.set(true, forKey: "premium")
//        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        if UIApplication.isFirstLaunch() {
            UserDefaults.standard.set(true, forKey: "hasBeenLaunchedBeforeFlag")
            UserDefaults.standard.synchronize()
            
        }
        
        textLog.clean()
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
      -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
    
    
}

var textLog = TextLog()

extension UIApplication {
    class func isFirstLaunch() -> Bool {
        if !UserDefaults.standard.bool(forKey: "hasBeenLaunchedBeforeFlag") {
            return true
        }
        return false
    }
    
    class func isPremiumAvailable() -> Bool {
        if UserDefaults.standard.bool(forKey: "premium") {
            return true
        }
        return false
    }
    
    class func isDeveloperModeEnabled() -> Bool {
        if UserDefaults.standard.bool(forKey: "dev_mode") {
            return true
        }
        return false
    }
    
    class func appIsOnFirstRunOnCurrentVersion() -> Bool {
        let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        let versionOfLastRun = UserDefaults.standard.object(forKey: "VersionOfLastRun") as? String
        
        var isFirstTime = false

        if versionOfLastRun == nil {
            // First start after installing the app
            isFirstTime = true

        } else if versionOfLastRun != currentVersion {
            // App was updated since last run
            isFirstTime = true

        }

        UserDefaults.standard.set(currentVersion, forKey: "VersionOfLastRun")
        UserDefaults.standard.synchronize()
        
        return isFirstTime
    }
    
    class func appVersion() -> String {
        if let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            return currentVersion
        }
        return "nil"
    }
}

