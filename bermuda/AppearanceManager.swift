//
//  AppearanceManager.swift
//  bermuda
//
//  Created by Mike Choi on 12/2/18.
//  Copyright © 2018 Mike JS. Choi. All rights reserved.
//

import UIKit

class AppearanceManager: NSObject {
    @objc class func setupAppearance(theme: PresentationTheme = PresentationTheme.current) {
        // Change the keyboard for UISearchBar
        UITextField.appearance().keyboardAppearance = theme == PresentationTheme.darkTheme ? .dark : .light
        // For the cursor
        UITextField.appearance().tintColor = theme.colors.orangeUI
        
        // Don't override the 'Cancel' button color in the search bar with the previous UITextField call. Use the default blue color
        let attributes = [NSAttributedString.Key.foregroundColor: theme.colors.orangeUI]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
        
        UINavigationBar.appearance().barTintColor = theme.colors.navigationbarColor
        //UINavigationBar.appearance(whenContainedInInstancesOf: [VLCPlaybackNavigationController.self]).barTintColor = nil
        UINavigationBar.appearance().tintColor = theme.colors.orangeUI
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: theme.colors.navigationbarTextColor,
            NSAttributedString.Key.font: UIFont(name: "futura", size: 21)!
        ]

        // For the edit selection indicators
        UITableView.appearance().tintColor = theme.colors.orangeUI
        UISegmentedControl.appearance().tintColor = theme.colors.orangeUI
        UISwitch.appearance().onTintColor = theme.colors.orangeUI
        UISearchBar.appearance().barTintColor = .white
    }
}

//extensions so that preferredStatusBarStyle is called on all childViewControllers otherwise this is not forwarded
extension UINavigationController {
    override open var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
}
