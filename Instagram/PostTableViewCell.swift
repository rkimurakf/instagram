//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by mba2408.silver kyoei.engine on 2024/10/31.
//

import UIKit
import FirebaseStorageUI

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var comment: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setPostData(_ postData: PostData) {
            // 画像の表示
            postImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postData.id + ".jpg")
            postImageView.sd_setImage(with: imageRef)

            // キャプションの表示
            self.captionLabel.text = "\(postData.name) : \(postData.caption)"

            // 日時の表示
            self.dateLabel.text = postData.date

            // いいね数の表示
            let likeNumber = postData.likes.count
            likeLabel.text = "\(likeNumber)"

            // いいねボタンの表示
            if postData.isLiked {
                let buttonImage = UIImage(named: "like_exist")
                self.likeButton.setImage(buttonImage, for: .normal)
            } else {
                let buttonImage = UIImage(named: "like_none")
                self.likeButton.setImage(buttonImage, for: .normal)
            }
        }

}
