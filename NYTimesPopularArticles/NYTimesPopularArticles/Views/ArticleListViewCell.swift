//
//  ArticleListViewCell.swift
//  NYTimesPopularArticles
//
//  Created by Venugopalan, Vimal on 11/03/20.
//  Copyright © 2020 Venugopalan, Vimal. All rights reserved.
//

import UIKit

class ArticleListViewCell: UITableViewCell {

    private let imageDownloadManager = ImageDownloadManager()
    
    lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 25.0
        imageView.layer.masksToBounds = true
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    /// Date Label
    lazy var dateLabel: UILabel = {
        let dl = UILabel()
        dl.numberOfLines = 0
        dl.textAlignment = .right
        dl.font = UIFont.systemFont(ofSize: 12.0)
        dl.textColor = .gray
        addSubview(dl)
        dl.translatesAutoresizingMaskIntoConstraints = false
        return dl
    }()
    
    /// Title Label
    lazy var titleLabel: UILabel = {
        let tl = UILabel()
        tl.numberOfLines = 0
        tl.font = UIFont.boldSystemFont(ofSize: 14.0)
        addSubview(tl)
        tl.translatesAutoresizingMaskIntoConstraints = false
        return tl
    }()
    
    /// Author Label
    lazy var authorLabel: UILabel = {
        let hl = UILabel()
        hl.numberOfLines = 0
        hl.font = UIFont.systemFont(ofSize: 12.0)
        hl.textColor = .gray
        addSubview(hl)
        hl.translatesAutoresizingMaskIntoConstraints = false
        return hl
    }()
    
    
    /// UITableViewCell init method
    ///
    /// - Parameters:
    ///   - style: Tableview cell style
    ///   - reuseIdentifier: Identifier for cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
        self.accessoryType = .disclosureIndicator
        NSLayoutConstraint.activate([
            thumbnailImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            thumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15.0),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 50.0),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 50.0),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10.0),
            titleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10.0),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32.0),
            
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10.0),
            authorLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10.0),
            authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32.0),
            
            dateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 10.0),
            dateLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10.0),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32.0),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0),

            
        ])
        dateLabel.isAccessibilityElement = true
        dateLabel.accessibilityIdentifier = "dateLabel"
        
        titleLabel.isAccessibilityElement = true
        titleLabel.accessibilityIdentifier = "titleLabel"
        
        authorLabel.isAccessibilityElement = true
        authorLabel.accessibilityIdentifier = "authorLabel"
        
        thumbnailImageView.isAccessibilityElement = true
        thumbnailImageView.accessibilityIdentifier = "thumbnailImageView"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Data to be shown in cell represented by Article
    var article: ArticleDataModel! {
        didSet {
            dateLabel.text = "📅 \(article.published_date ?? "")"
            titleLabel.text = article.title
            authorLabel.text = "\(article.byline ?? "")"
            thumbnailImageView.image = UIImage.init(named: "NoImageIcon")

            
            if let mediaArray = article.media, mediaArray.count > 0,  let metaDataArray = mediaArray[0].media_metadata, metaDataArray.count > 0, let imageUrl = metaDataArray[0].url {
                let imageDownloadRequest = ImageDownloadRequest(imageUrlString: imageUrl)
                imageDownloadManager.getImageFile(from: imageDownloadRequest, completion: ({ [weak self] result in
                    switch result {
                    case .success(let image):
                        DispatchQueue.main.async() {
                            self?.thumbnailImageView.image = image
                        }
                    case .failure( _):
                        break
                    }

                })
            )}
            
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
