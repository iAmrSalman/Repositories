//
//  SearchResultCell.swift
//  App_iOS
//
//  Created by Amr Salman on 1/16/21.
//

import UIKit

class SearchResultCell: UITableViewCell {

    @IBOutlet weak var imageAvatar: UIImageView! {
        didSet {
            imageAvatar.layer.cornerRadius = 6
            imageAvatar.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var labelName: UILabel! {
        didSet {
            labelName.font = UIFont.preferredFont(forTextStyle: .title1)
            labelName.textColor = R.color.black()
            labelName.numberOfLines = 3
            labelName.minimumScaleFactor = 0.7
        }

    }
    @IBOutlet weak var labelDescription: UILabel! {
        didSet {
            labelDescription.font = UIFont.preferredFont(forTextStyle: .body)
            labelDescription.textColor = R.color.black()
            labelDescription.numberOfLines = 0
            labelDescription.minimumScaleFactor = 0.8
        }
    }

}
