//
//  JournalCell.swift
//  UIKitEveryThing
//
//  Created by 최범수 on 2025-03-25.
//

import UIKit

class JournalCell: UITableViewCell {
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    var subtitle: String? {
        didSet {
            subtitleLabel.text = subtitle
        }
    }
    var image: UIImage? {
        didSet {
            imgView.image = image
        }
    }
    
    private lazy var imgView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .preferredFont(forTextStyle: .headline)

        return label
    }()
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .preferredFont(forTextStyle: .subheadline)
        
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(imgView)
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            imgView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            imgView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            imgView.widthAnchor.constraint(equalTo: self.heightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 8),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ])
    }
}
