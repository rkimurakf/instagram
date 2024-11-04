//
//  PostData.swift
//  Instagram
//
//  Created by mba2408.silver kyoei.engine on 2024/10/31.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class PostData: NSObject { //NSObjectとはObjective-Cのルートクラスのことです。
    var id = ""
    var name = ""
    var caption = ""
    var date = ""
    var likes: [String] = []
    var isLiked: Bool = false
    var comments: [String] = []//課題で追加

    init(document: QueryDocumentSnapshot) {//initメソッドは主にクラスのプロバティの初期値を設定するときに使用します
        self.id = document.documentID

        let postDic = document.data()

        if let name = postDic["name"] as? String {
            self.name = name
        }

        if let caption = postDic["caption"] as? String {
            self.caption = caption
        }

        if let timestamp = postDic["date"] as? Timestamp {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            self.date = formatter.string(from: timestamp.dateValue())
        }

        if let likes = postDic["likes"] as? [String] {
            self.likes = likes
        }
        
        if let comments = postDic["comments"] as? [String] { //課題で追加
                    self.comments = comments
                }

        if let myid = Auth.auth().currentUser?.uid {
            // likesの配列の中にmyidが含まれているかチェックすることで、自分がいいねを押しているかを判断
            if self.likes.firstIndex(of: myid) != nil {
                // myidがあれば、いいねを押していると認識する。
                self.isLiked = true
            }
        }
        
    }
    //課題で追加
    static func createPostDictionary(name: String, caption: String) -> [String: Any] {
        return [
            "name": name,
            "caption": caption,
            "date": FieldValue.serverTimestamp(),
            "comments": [] // 追記課題
        ]
    }

    override var description: String {
        return "PostData: name=\(name); caption=\(caption); date=\(date); likes=\(likes.count); id=\(id);"
    }
}
