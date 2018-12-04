//  HomePanelViewController.swift
//  bermuda
//
//  Created by Mike Choi on 12/2/18.
//  Copyright © 2018 Mike JS. Choi. All rights reserved.
//

import UIKit

class HomePanelViewController: UIViewController {

    @IBOutlet weak var searchView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var bottomSeperatorView: UIView!
    
    @IBOutlet weak var whereToLabel: UILabel!
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet var headerSectionHeightConstraint: NSLayoutConstraint!
    
    @IBAction func searchTapped(_ sender: Any) {
        pulleyViewController?.setDrawerPosition(position: .open, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchView.clipsToBounds = true
        searchView.layer.cornerRadius = 8.0
        searchView.dropShadow()
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

extension HomePanelViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}
