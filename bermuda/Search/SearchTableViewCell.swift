//
//  SearchTableViewCell.swift
//  bermuda
//
//  Created by Mike Choi on 12/2/18.
//  Copyright © 2018 Mike JS. Choi. All rights reserved.
//

import UIKit

struct Location {
    enum Category: String {
        case start
        case stop
        case end
        
        func placeholder() -> String {
            switch self {
            case .start:
                return "Search starting point"
            case .stop:
                return "Add a stop"
            case .end:
                return "Search destination"
            }
        }
    }
    
    let category: Category
    let name: String?
}

final class SearchTableViewCell: UITableViewCell {
    static let identifier = "SearchTableViewCell"
    
    static let plus = UIImage(named: "+")!
    static let minus = UIImage(named: "x")!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    
    func configure(with location: Location) {
        categoryLabel.text = location.category.rawValue.uppercased()
        
        if let name = location.name {
            actionButton.imageView?.image = SearchTableViewCell.plus
            textField.text = name
        } else {
            actionButton.imageView?.image = SearchTableViewCell.minus
            textField.placeholder = location.category.placeholder()
        }
    }
}
