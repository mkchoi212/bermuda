//  DrawerPreviewContentViewController.swift
//  bermuda
//
//  Created by Mike Choi on 12/2/18.
//  Copyright © 2018 Mike JS. Choi. All rights reserved.
//

import UIKit

class DrawerContentViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var bottomSeperatorView: UIView!
    
    @IBOutlet weak var whereToLabel: UILabel!
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet var headerSectionHeightConstraint: NSLayoutConstraint!
    
    lazy var fullNavigationItem: UINavigationItem = {
        let navigationItem = UINavigationItem()
        let closeButton = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(closeSheet))
        
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.title = "Plan trip"
        
        return navigationItem
    }()
    
    lazy var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.isTranslucent = false
        navigationBar.delegate = self
        navigationBar.backgroundColor = .white
        navigationBar.items = [fullNavigationItem]
        
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        
        return navigationBar
    }()
    
    fileprivate var drawerBottomSafeArea: CGFloat = 0.0 {
        didSet {
            self.loadViewIfNeeded()
            // We'll configure our UI to respect the safe area. In our small demo app, we just want to adjust the contentInset for the tableview.
            tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: drawerBottomSafeArea, right: 0.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if #available(iOS 10.0, *) {
            let feedbackGenerator = UISelectionFeedbackGenerator()
            self.pulleyViewController?.feedbackGenerator = feedbackGenerator
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
}

extension DrawerContentViewController: PulleyDrawerViewControllerDelegate {

    func collapsedDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat {
        let height = UIScreen.main.bounds.height * 0.2
        return height + (pulleyViewController?.currentDisplayMode == .drawer ? bottomSafeArea : 0.0)
    }
    
    func partialRevealDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat {
        let height = UIScreen.main.bounds.height * 0.4
        return height + (pulleyViewController?.currentDisplayMode == .drawer ? bottomSafeArea : 0.0)
    }
    
    func supportedDrawerPositions() -> [PulleyPosition] {
        return PulleyPosition.all
    }
    
    @objc func closeSheet() {
        pulleyViewController?.setDrawerPosition(position: .collapsed, animated: true)
    }
    
    func drawerPositionDidChange(drawer: PulleyViewController, bottomSafeArea: CGFloat) {
        // We want to know about the safe area to customize our UI. Our UI customization logic is in the didSet for this variable.
        drawerBottomSafeArea = bottomSafeArea
        
        if drawer.drawerPosition == .collapsed {
            headerSectionHeightConstraint.constant = 160.0 + drawerBottomSafeArea
        } else {
            headerSectionHeightConstraint.constant = 160.0
        }
        
        tableView.isScrollEnabled = drawer.drawerPosition == .open || drawer.currentDisplayMode == .panel
        
        if drawer.drawerPosition != .open {
            searchBar.resignFirstResponder()
        } else {
            transistionToFull()
        }
        
        if drawer.currentDisplayMode == .panel {
            bottomSeperatorView.isHidden = drawer.drawerPosition == .collapsed
        } else {
            bottomSeperatorView.isHidden = true
        }
        
        if drawer.drawerPosition == .collapsed || drawer.drawerPosition == .partiallyRevealed {
            navigationBar.removeFromSuperview()
            
            helloLabel.isHidden = false
            whereToLabel.isHidden = false
        }
    }
    
    func drawerDisplayModeDidChange(drawer: PulleyViewController) {
        print("Drawer: \(drawer.currentDisplayMode)")
    }
}

extension DrawerContentViewController {
    
    func transistionToFull() {
        helloLabel.isHidden = true
        whereToLabel.isHidden = true
        
        view.addSubview(navigationBar)
        
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        if #available(iOS 11, *) {
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        }
    }
}

extension DrawerContentViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        pulleyViewController?.setDrawerPosition(position: .open, animated: true)
    }
}

extension DrawerContentViewController: UINavigationBarDelegate {
    
    public func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}


