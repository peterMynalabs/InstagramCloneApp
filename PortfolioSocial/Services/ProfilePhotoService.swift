import UIKit
import FirebaseStorage
import FirebaseDatabase

class ProfilePhotoService {
     func updateProfilePhoto(for image: UIImage) {
        let imageRef = StorageReference.updateProfilePhoto()
        StorageService().uploadImage(image, at: imageRef) { (downloadURL) in
            guard let downloadURL = downloadURL else {
                return
            }

            let urlString = downloadURL.absoluteString
            let aspectHeight = image.aspectHeight
            ProfileService().updateProfilePhoto(forURLString: urlString, aspectHeight: aspectHeight)
        }
    }
}
