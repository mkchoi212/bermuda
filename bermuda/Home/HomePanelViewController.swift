//  HomePanelViewController.swift
//  bermuda
//
//  Created by Mike Choi on 12/2/18.
//  Copyright © 2018 Mike JS. Choi. All rights reserved.
//

import UIKit

class HomePanelViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var bottomSeperatorView: UIView!
    
    @IBOutlet weak var whereToLabel: UILabel!
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet var headerSectionHeightConstraint: NSLayoutConstraint!
    
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

extension HomePanelViewController {
    func drawerPositionDidChange(drawer: PulleyViewController, bottomSafeArea: CGFloat) {
        // We want to know about the safe area to customize our UI. Our UI customization logic is in the didSet for this variable.
        drawerBottomSafeArea = bottomSafeArea


        tableView.isScrollEnabled = drawer.drawerPosition == .open || drawer.currentDisplayMode == .panel
        
        if drawer.drawerPosition != .open {
            searchBar.resignFirstResponder()
        } else {
            let storyboard = UIStoryboard(name: "Full", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "SearchViewController")
            pulleyViewController?.setDrawerContentViewController(controller: UINavigationController(rootViewController: controller), animated: true)
        }
        
        if drawer.currentDisplayMode == .panel {
            bottomSeperatorView.isHidden = drawer.drawerPosition == .collapsed
        } else {
            bottomSeperatorView.isHidden = true
        }
        
        if drawer.drawerPosition == .collapsed || drawer.drawerPosition == .partiallyRevealed {
            
            helloLabel.isHidden = false
            whereToLabel.isHidden = false
        }
    }
    
    func drawerDisplayModeDidChange(drawer: PulleyViewController) {
        print("Drawer: \(drawer.currentDisplayMode)")
    }
}

extension HomePanelViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        pulleyViewController?.setDrawerPosition(position: .open, animated: true)
    }
}

extension HomePanelViewController: UINavigationBarDelegate {
    
    public func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

extension HomePanelViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
}

