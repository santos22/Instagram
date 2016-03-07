//
//  Post.swift
//  Instagram
//
//  Created by Santos Solorzano on 3/6/16.
//  Copyright © 2016 santosjs. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {
    /**
     * Other methods
     */
    
    var author: PFUser?
    var createdAt: NSDate?
    var post: UIImage?
    var caption: String?
    
    init(object: PFObject) {
        super.init()
        
        // set data
        author = object["author"] as? PFUser
        createdAt = object.createdAt!
        caption = object["caption"] as? String
    }
     
    class func PostsWithArray(array: [PFObject]) -> [Post] {
        var posts = [Post]()
        for object in array {
            posts.append(Post(object: object))
            // when callback complete continue
        }
        return posts
    }
     
     /**
     Method to add a user post to Parse (uploading image file)
     
     - parameter image: Image that the user wants upload to parse
     - parameter caption: Caption text input by the user
     - parameter completion: Block to be executed after save operation is complete
     */
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let post = PFObject(className: "Post")
        
        // Add relevant fields to the object
        post["media"] = getPFFileFromImage(image) // PFFile column type
        post["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        post["caption"] = caption
        post["likesCount"] = 0
        post["commentsCount"] = 0
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackgroundWithBlock(completion)
    }
    
    /**
     Method to convert UIImage to PFFile
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }

}
