import UIKit
import FirebaseStorage

class StorageService {
     func uploadImage(_ image: UIImage, at reference: StorageReference, completion: @escaping (URL?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            return completion(nil)
        }

        reference.putData(imageData, metadata: nil, completion: { (_, error) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }

            reference.downloadURL(completion: { (url, error) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    return completion(nil)
                }
                completion(url)
            })
        })
    }}

extension StorageReference {
    static let dateFormatter = ISO8601DateFormatter()

    static func newPostImageReference() -> StorageReference {
        let uid = User.current!.uid
        let timestamp = dateFormatter.string(from: Date())
        return Storage.storage().reference().child("images/posts/\(uid)/\(timestamp).jpg")
    }
    static func updateProfilePhoto() -> StorageReference {
        let uid = User.current!.uid
        return Storage.storage().reference().child("images/profilePhotos/\(uid).jpg")
    }
}
