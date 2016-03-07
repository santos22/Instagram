//
//  HomeViewController.swift
//  Instagram
//
//  Created by Santos Solorzano on 3/6/16.
//  Copyright © 2016 santosjs. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {
    
    var posts: [Post]?
    var postsAsPFObjects: [PFObject]?

    @IBOutlet weak var postsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postsTableView.dataSource = self
        postsTableView.delegate = self
        
        constructQuery()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        postsTableView.insertSubview(refreshControl, atIndex: 0)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        constructQuery(refreshControl.endRefreshing())
    }
    
    func constructQuery(completion: Void) {
        // construct PFQuery
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20

        query.findObjectsInBackgroundWithBlock { (post: [PFObject]?, error: NSError?) -> Void in
            if let post = post {
                // do something with the data fetched
                self.postsAsPFObjects = post
                self.posts = Post.PostsWithArray(post)
                self.postsTableView.reloadData()
            } else {
                print("Error")
            }
            completion
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = posts {
            return posts.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = postsTableView.dequeueReusableCellWithIdentifier("PostCell", forIndexPath: indexPath) as! PostTableViewCell
        
        //cell.post = posts![indexPath.row] // unwraps
        cell.homePostImageView.tag = indexPath.row
        
        let mediaFile = postsAsPFObjects![indexPath.row]["media"] as! PFFile
        mediaFile.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
            if imageData != nil {
                let image = UIImage(data:imageData!)
                cell.homePostImageView.image = image
                //cell.postCaptionText.text = posts.caption
                self.posts![indexPath.row].post = image
            }
        }
        
        // cell animation
        cell.alpha = 0
        cell.selectionStyle = .None
        UIView.animateWithDuration(1, animations: { cell.alpha = 1 })
        return cell
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
