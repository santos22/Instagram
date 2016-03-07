//
//  PostViewController.swift
//  Instagram
//
//  Created by Santos Solorzano on 3/6/16.
//  Copyright © 2016 santosjs. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    var postPreviewImage: UIImage!
    @IBOutlet weak var postPreviewImageView: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(vc, animated: true, completion: nil)
        
        let postTapAction = UITapGestureRecognizer(target: self, action: "postImage:")
        postPreviewImageView.userInteractionEnabled = true
        postPreviewImageView.addGestureRecognizer(postTapAction)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func postImage(sender: UITapGestureRecognizer){
        if sender.state != .Ended{
            return
        }
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            // Get the image captured by the UIImagePickerController
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            //let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            postPreviewImageView.image = originalImage
            
            // Do something with the images (based on your use case)
            
            // Dismiss UIImagePickerController to go back to your original view controller
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveImageToParse(sender: AnyObject) {
        Post.postUserImage(postPreviewImageView.image, withCaption: captionField.text ?? "") { (flag: Bool, error: NSError?) -> Void in}
        print("CHECK PARSE BRO")
        postPreviewImageView.image = UIImage(named:"1457337270_picture-1")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
