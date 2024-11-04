//
//  CommentViewController.swift
//  Instagram
//
//  Created by mba2408.silver kyoei.engine on 2024/11/01.
//
import UIKit
import FirebaseFirestore
import FirebaseAuth

protocol CommentViewControllerDelegate: AnyObject {
    func didAddComment(postData: PostData)
}

class CommentViewController: UIViewController {
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var postButton: UIButton!
    
    var postData: PostData?
    weak var delegate: CommentViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //課題で追加
    
    @IBAction func postComment(_ sender: UIButton) {
        guard let postData = postData, let comment = commentTextField.text, !comment.isEmpty else {
               print("コメントが入力されていません")
               return
           }
           let userName = Auth.auth().currentUser?.displayName ?? "名無し"
           let formattedComment = "\(userName)：\(comment)"
           
           let postRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
           postRef.updateData(["comments": FieldValue.arrayUnion([formattedComment])]) { error in // 修正: formattedComment を使用
               if let error = error {
                   print("コメントの保存に失敗しました: \(error)")
               } else {
                   print("コメントが保存されました")
                   self.delegate?.didAddComment(postData: postData)
                   self.navigationController?.popViewController(animated: true)
               }
           }
    }
}
