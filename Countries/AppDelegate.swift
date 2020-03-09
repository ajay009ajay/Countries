//
//  AppDelegate.swift
//  Countries
//
//  Created by user on 3/6/20.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit
import Reachability

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?
    let reachability =   try! Reachability()
    var launchArguments = "test"
    
    private func launchCountryListVCForMocking(splitViewController: UISplitViewController) {
        if splitViewController.viewControllers.count > 0 {
            if let navVC = (splitViewController.viewControllers[0] as? UINavigationController), navVC.viewControllers.count > 0,  let countryListVC = (navVC.viewControllers[0] as? CountryListViewController) {
                
                let mockSession = URLSessionMock()
                mockSession.data = JsonFileReader.getJsonFileData(fileName: "India")
                countryListVC.viewModel = CountryViewModel(countryWebService: WebServiceManager(session: mockSession))
            }
            
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        let splitViewController = self.window!.rootViewController as! UISplitViewController
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        splitViewController.delegate = self

        debugPrint("Documents Directory: ", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found!")

        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
      
        if CommandLine.arguments.contains("--CountryListTest--") {
            print("Running UI test")
            launchCountryListVCForMocking(splitViewController: splitViewController)
            return true
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        reachability.stopNotifier()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        startReachability()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        reachability.stopNotifier()
     }

    // MARK: - Split view

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        return true
    }
    private func startReachability() {
        do{
            try reachability.startNotifier()
        }catch{
            debugPrint("could not start reachability notifier")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            debugPrint("Reachable via WiFi")
        case .cellular:
            debugPrint("Reachable via Cellular")
        case .unavailable:
            debugPrint("Network not reachable")
        case .none:
            debugPrint("Network not reachable")
        }
    }
}

