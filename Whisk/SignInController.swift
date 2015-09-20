//
//  SignInController.swift
//  Whisk
//
//  Created by Mohammed Kumail Jaffer on 9/19/15.
//  Copyright © 2015 Mohammed Kumail Jaffer. All rights reserved.
//

import Foundation
import OAuth2
import UIKit

class SignInController: UIViewController {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.oauth2.onAuthorize = { parameters in
            print("Did authorize with parameters: \(parameters)")
            let requrl = NSURL(string: "https://api.uber.com/v1/me")
            let req = self.appDelegate.oauth2.request(forURL: requrl!)
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(req) { data, response, error in
                if nil != error {
                    // uh oh
                }
                else {
                    do {
                        let result = try NSJSONSerialization.JSONObjectWithData(
                            data!,
                            options: NSJSONReadingOptions.AllowFragments
                            ) as! NSDictionary
                        
                            let requrl = NSURL(string: "https://api.uber.com/v1/me")
                            let req = self.appDelegate.oauth2.request(forURL: requrl!)
                            let session = NSURLSession.sharedSession()
                            let task = session.dataTaskWithRequest(req) { data, response, error in
                                if nil != error {
                                    // uh oh
                                }
                                else {
                                    do {
                                        let result = try NSJSONSerialization.JSONObjectWithData(
                                            data!,
                                            options: NSJSONReadingOptions.AllowFragments
                                            ) as! NSDictionary
                                        
                                        
                                    }
                                    catch {
                                    }
                                }
                            }
                            task.resume()

                    }
                    catch {
                    }
                }
            }
            task.resume()
        }
        appDelegate.oauth2.onFailure = { error in        // `error` is nil on cancel
            if nil != error {
                print("Authorization went wrong: \(error!.localizedDescription)")
            }
        }
        appDelegate.oauth2.authorize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}