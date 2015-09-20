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
    
    func notInTable(email: String) -> Bool{
        for userEmail in self.appDelegate.defaults.users{
        if (userEmail == email){
            return false
            }
        }
        return true
    }
    
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
                                        //self.appDelegate.
                                        if (notInTable(result[0])){
                                            let questionsURL = NSURL(string: "<server>/whisk/questions")
                                            let qreq = self.appDelegate.oauth2.request(forURL: questionsURL!)
                                            let qsession = NSURLSession.sharedSession()
                                            let task = qsession.dataTaskWithRequest(qreq){ data, questions, error in
                                            DisplayQuestionsView(questions)
                                            //add result.email to database
                                            NSUserDefaults.append(result[0])
                                            } else {
                                            }
                                
                                        }
                                        
                                    }
                                    catch {
                                    }
                                }
                            }
                        
                            task.resume()
                            //get the details of location to call uber
                            let locationURL = NSURL(string: "<server>/whisk/whisk")
                            let locationReq = self.appDelegate.oauth2.request(forURL: locationURL!)
                            let locationSession = NSURLSession.sharedSession()
                            let location = locationSession.dataTaskWithRequest(locationReq){ data, location, error in
                                if (error != nil){
                                } else {
                                    let uberURL = NSURL(string: "https://sandbox-api.uber.com/<version>")
                                    let uberReq = self.appDelegate.oauth2.request(forURL: uberURL?)
                                    let qsession = NSURLSession.sharedSession()
                                    let task = qsession.dataTaskWithRequest(uberURL){ data, questions, error in
                                        DisplayQuestionsView(questions)
                                    }
                                }
                            }
                        
                    }
                    catch {
                    }
                }
                
            }
            task.resume()
        }
        //print(result)
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