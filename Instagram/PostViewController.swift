//
//  PostViewController.swift
//  Instagram
//
//  Created by mba2408.silver kyoei.engine on 2024/10/30.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import SVProgressHUD



class PostViewController: UIViewController{
    
    var image: UIImage!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
       super.viewDidLoad()
        imageView.image = image
    }
    
    @IBAction func handlePostButton(_ sender: Any) {
        // 画像をJPEG形式に変換する
                let imageData = image.jpegData(compressionQuality: 0.75)
                // 画像と投稿データの保存場所を定義する
                let postRef = Firestore.firestore().collection(Const.PostPath).document()
                let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postRef.documentID + ".jpg")
                // HUDで投稿処理中の表示を開始
                SVProgressHUD.show()
                // Storageに画像をアップロードする
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpeg"
                imageRef.putData(imageData!, metadata: metadata) { (metadata, error) in
                    if error != nil {
                        // 画像のアップロード失敗
                        print(error!)
                        SVProgressHUD.showError(withStatus: "画像のアップロードが失敗しました")
                        // 投稿処理をキャンセルし、先頭画面に戻る
                        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                        return
                    }
                    // FireStoreに投稿データを保存する
                    let name = Auth.auth().currentUser?.displayName
                    let postDic = [
                        "name": name!,
                        "caption": self.textField.text!,
                        "date": FieldValue.serverTimestamp(),
                        ] as [String : Any]
                    postRef.setData(postDic)
                    // HUDで投稿完了を表示する
                    SVProgressHUD.showSuccess(withStatus: "投稿しました")
                    // 投稿処理が完了したので先頭画面に戻る
                    self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                }
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            }
    }
    
    

