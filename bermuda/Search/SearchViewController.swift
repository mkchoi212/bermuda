//
//  SearchViewController.swift
//  bermuda
//
//  Created by Mike Choi on 12/2/18.
//  Copyright © 2018 Mike JS. Choi. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    @IBOutlet weak var topPadding: NSLayoutConstraint!
    @IBOutlet weak var tableViewContainer: UIView!
    @IBOutlet weak var tableViewContainerHeight: NSLayoutConstraint!
    
    @IBOutlet weak var searchTableView: UITableView!
    
    var locations: [Location] = [
        Location(category: .start, name: "Current Location")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableView.dataSource = self
        searchTableView.delegate = self
        setupView()
    }

    @IBAction func cancelPressed(_ sender: Any) {
        pulleyViewController?.setDrawerPosition(position: .partiallyRevealed, animated: true)
    }
    
    func setupView() {
        let navigationBarHeight = navigationController!.navigationBar.frame.size.height
        topPadding.constant += navigationBarHeight
        
        tableViewContainerHeight.constant = SearchTableViewCell.height * 2

        searchTableView.layer.cornerRadius = 8.0
        searchTableView.tableFooterView = UIView()
        
        tableViewContainer.dropShadow()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont(name: "futura-medium", size: 20)!
        ]
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(2, locations.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
            fatalError("No identifer named \(SearchTableViewCell.identifier)")
        }
        
        let row = indexPath.row
        if row >= locations.count {
            let category: Location.Category = row == 0 ? .start : .end
            cell.configure(with: Location(category: category, name: nil))
        } else {
            let location = locations[indexPath.row]
            cell.configure(with: location)
        }
        
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SearchTableViewCell.height
    }
}
