import UIKit
import FirebaseDatabase.FIRDataSnapshot

class Post {
    var key: String?
    let imageURL: String
    let imageHeight: CGFloat
    let creationDate: Date
    let caption: String
    let poster: String
    var likeCount: Int
    var isLiked = false
    
    init(imageURL: String, imageHeight: CGFloat, caption: String, poster: String, likeCount: Int) {
        self.imageURL = imageURL
        self.imageHeight = imageHeight
        self.creationDate = Date()
        self.caption = caption
        self.poster = poster
        self.likeCount = likeCount
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let imageURL = dict["image_url"] as? String,
            let imageHeight = dict["image_height"] as? CGFloat,
            let createdAgo = dict["created_at"] as? TimeInterval,
            let caption = dict["caption"] as? String,
            let poster  = dict["poster"] as? String,
            let likeCount = dict["like_count"] as? Int
            else { return nil }

        self.key = snapshot.key
        self.imageURL = imageURL
        self.imageHeight = imageHeight
        self.creationDate = Date(timeIntervalSince1970: createdAgo)
        self.caption = caption
        self.poster = poster
        self.likeCount = likeCount
    }
    
    static func create(forURLString urlString: String, aspectHeight: CGFloat, caption: String, poster: String, likedCount: Int, completion:  @escaping (Bool) -> Void) {
        let currentUser = User.current
        let post = Post(imageURL: urlString, imageHeight: aspectHeight, caption: caption, poster: poster, likeCount: likedCount)
        let dict = post.dictValue
        let postRef = Database.database().reference().child("posts").child(currentUser!.uid).childByAutoId()
        let newPostKey = postRef.key
        
        UserService().followers(for: currentUser!) { (followerUIDs) in
              let timelinePostDict = ["poster_uid" : currentUser!.uid]

              var updatedData: [String : Any] = ["timeline/\(currentUser!.uid)/\(newPostKey!)" : timelinePostDict]

              for uid in followerUIDs {
                  updatedData["timeline/\(uid)/\(newPostKey!)"] = timelinePostDict
              }
              let postDict = post.dictValue
              updatedData["posts/\(currentUser!.uid)/\(newPostKey!)"] = postDict

            Database.database().reference().updateChildValues(updatedData) {  (error, ref) in
                if error != nil {
                    completion(false)
                } else {
                    completion(true)
                }
            }
          }
    }
    
    
    var dictValue: [String : Any] {
        let createdAgo = creationDate.timeIntervalSince1970

        return ["image_url" : imageURL,
                "image_height" : imageHeight,
                "created_at" : createdAgo,
                "caption": caption,
                "poster": poster,
                "like_count": likeCount]
    }
}



