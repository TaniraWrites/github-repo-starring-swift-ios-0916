//
//  GithubAPIClient.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class GithubAPIClient {
    
    class func getRepositoriesWithCompletion(_ completion: @escaping ([Any]) -> ()) {
        let urlString = "\(Secrets.githubAPIURL)/user?access_token=69e9c679fa31a0035775bcfce00c50e823d8905e"
        let url = URL(string: urlString)
        let session = URLSession.shared
        
        guard let unwrappedURL = url else { fatalError("Invalid URL") }
        let task = session.dataTask(with: unwrappedURL, completionHandler: { (data, response, error) in
            guard let data = data else { fatalError("Unable to get data \(error?.localizedDescription)") }
            
            if let responseArray = try? JSONSerialization.jsonObject(with: data, options: []) as? [Any] {
                if let responseArray = responseArray {
                    completion(responseArray)
                }
            }
        })
        task.resume()
    }
    
    // class func starRepository -> URL Request and then -> request.method 
    
    
    
    
    class func checkIfRepositoryIsStarred(fullName: String, completion: @escaping (Bool)-> Void) {
        var isStarred = false
        
        var urlString = "\(Secrets.githubAPIURL)/user/starred/\(Secrets.name)?access_token=\(Secrets.personalAccessToken)"
        
        var url = URL(string: urlString)
        guard let unwrappedURL = url else {return}
        
        var session = URLSession.shared
        
        var task = session.dataTask(with: unwrappedURL) { (data, response, error) in
            let httpresponse = response as! HTTPURLResponse
            
            if httpresponse.statusCode == 204 {
                isStarred = true
            } else if httpresponse.statusCode == 404 {
                isStarred = false
            }
             completion(isStarred)
        }
        
        task.resume()
    }
    
    
    class func starRepository(name:String, completion: @escaping (Bool)->Void) {
        var success = false
        var urlString = "\(Secrets.githubAPIURL)/user/starred/\(Secrets.name)?access_token=\(Secrets.personalAccessToken)"
        
        var url = URL(string: urlString)
        guard let unwrappedURL = url else { return }
        
        var request = URLRequest(url: unwrappedURL)
            request.httpMethod = "PUT"
            request.addValue("0", forHTTPHeaderField: "Content-Length")
        var session = URLSession.shared
        
        var task = session.dataTask(with: request) { (data, response, error) in
        let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 204 {
                success = true
            } else if httpresponse.statusCode == 404 {
                success = false
            }
            completion(success)
        }
        
        task.resume()
        }
    
    class func unstarRepository(name:String, completion: @escaping (Bool) -> Void) {
        var success = false
        var urlString = "\(Secrets.githubAPIURL)/user/starred/\(Secrets.name)?access_token=\(Secrets.personalAccessToken)"
        
        var url = URL(string: urlString)
        guard let unwrappedURL = url else { return }
        
        var request = URLRequest(url: unwrappedURL)
            request.httpMethod = "DELETE"
        
        var session = URLSession.shared
        
        var task = session.dataTask(with: request) { (data, response, error) in
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 204 {
                success = true
            } else if httpresponse.statusCode == 404 {
                success = false
            }
            completion(success)
        }
        
        task.resume()
    
    }

        
    }
    
    


