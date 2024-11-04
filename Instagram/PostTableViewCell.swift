//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by mba2408.silver kyoei.engine on 2024/10/31.
//

import UIKit
import FirebaseStorageUI

protocol PostTableViewCellDelegate: AnyObject {
    func didTapCommentButton(postData: PostData)
}

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var commentButton: UIButton! //課題のために追加
    @IBOutlet weak var commentsLabel: UILabel! //課題のために追加
    
    //@IBOutlet weak var comment: UIButton! //課題のために追加
    weak var delegate: PostTableViewCellDelegate? //課題のために追加
    var postData: PostData? //課題のために追加
    override func awakeFromNib() {     //プリケーションに nib ファイルをロードするためのサポートを提供します。
        super.awakeFromNib()           //nibファイルとは、簡単にいってしまうとボタンなどのUI要素の描画情報が記述されたファイルのことです。
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {//UITableViewCellでは上記の方法ではうまくいきません。ユーザー操作によってセルが選択されてもdidSetに処理がやって来ません。
        super.setSelected(selected, animated: animated)//その代わり func setSelected(_ selected: Bool, animated: Bool)
        
        // Configure the view for the selected state
    }
    func setPostData(_ postData: PostData) {
        self.postData = postData//課題のために追加
        
        self.commentsLabel.numberOfLines = 0 //課題で追加
        self.commentsLabel.text = postData.comments.joined(separator: "\n")//課題で追加
        let formattedComments = postData.comments.map { comment in//課題で追加
            return comment//課題で追加
        }
        self.commentsLabel.text = formattedComments.joined(separator: "\n")//課題で追加
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
        if postData.isLiked {//いいねボタンが押された時に画像を切り替える処理
            let buttonImage = UIImage(named: "like_exist")//like_existは画像ファイル名
            self.likeButton.setImage(buttonImage, for: .normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
        

                commentButton.addTarget(self, action: #selector(handleCommentButtonTapped), for: .touchUpInside)//課題のために追加
            }

            
            @objc func handleCommentButtonTapped() {
                guard let postData = postData else { return }//課題のために追加
                delegate?.didTapCommentButton(postData: postData)//課題のために追加
            }
    }
    
    //@IBAction func commentView(_ sender: Any) {//課題で追加した
    //let storyboard: UIStoryboard = UIStoryboard(name: "Comment", bundle: nil)//対象となる画面のインスタンス化
    //let nextView = storyboard.instantiateInitialViewController()// Storyboard のインスタンスから ViewController を取得する
    //present(nextView!, animated: true, completion: nil)
    //presentの引数
    //第一引数：　遷移先のUIViewController
    //第二引数：　アニメーションの指定（true: アニメーション有 / false: アニメーション無）
    //第三引数：　コールバック関数
    //コールバック関数：ある関数を呼び出す時に、引数に指定する別の関数


