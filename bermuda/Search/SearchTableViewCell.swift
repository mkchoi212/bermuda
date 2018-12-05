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

protocol SearchTableViewCellDelegate: class {
    func actionPressed(cell: SearchTableViewCell, toggled: Bool)
}

final class SearchTableViewCell: UITableViewCell {
    static let identifier = "SearchTableViewCell"
    static let height: CGFloat = 55
    static let plus = UIImage(named: "+")!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    
    weak var delegate: SearchTableViewCellDelegate?
    var toggled: Bool = true {
        didSet {
            UIView.animate(withDuration: 0.25) {
                if self.toggled {
                    self.actionButton.transform = CGAffineTransform.identity
                } else {
                    self.actionButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4.0)
                }
            }
        }
    }
    
    func configure(with location: Location) {
        categoryLabel.text = location.category.rawValue.uppercased()
        
        if location.category == .start {
            actionButton.setImage(nil, for: .normal)
        } else {
            actionButton.setImage(SearchTableViewCell.plus, for: .normal)
        }
        
        if let name = location.name {
            textField.text = name
        } else {
            textField.placeholder = location.category.placeholder()
        }
    }
    
    @IBAction func actionPressed(_ sender: UIButton) {
        delegate?.actionPressed(cell: self, toggled: toggled)
        toggled = !toggled
    }
}
