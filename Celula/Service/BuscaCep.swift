//
//  BuscaCep.swift
//  Celula
//
//  Created by Victor Vieira Veiga on 18/04/20.
//  Copyright © 2020 Victor Vieira Veiga. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class BuscaCep {
    
    
    class func BuscaCep (_ cep : String, onComplete: @escaping (NSDictionary) -> Void, onError: @escaping (ApiErro) -> Void) {
       
        let session = URLSession.shared
        // MARK:- HeaderField
        let HTTPHeaderField_ContentType = "Content-Type"

        // MARK:- ContentType
        let ContentType_ApplicationJson = "application/json"

        //MARK: HTTPMethod
        let HTTPMethod_Get = "GET"

        let urlPath = URL(string: "https://viacep.com.br/ws/"+cep+"/json")
        var request = URLRequest(url: urlPath!)
        request.timeoutInterval = 60
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        request.addValue(ContentType_ApplicationJson, forHTTPHeaderField: HTTPHeaderField_ContentType)
        request.httpMethod = HTTPMethod_Get
        
        session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if((error) != nil) {
                print(error!.localizedDescription)
            } else {
            
                do {
                    _ = NSString(data: data!, encoding:String.Encoding.utf8.rawValue)
                    let _: NSError?
                    
                    let jsonResult = try JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.mutableContainers)

                    DispatchQueue.main.async(execute: {
                        let dic: NSDictionary = (jsonResult as! NSDictionary);
                        
                        if dic.count > 1 {
                           onComplete(dic)
                        }else {
                            print ("Cep não encontrado.")
                            //onError(error as! ApiErro)
                        }
                    })
                } catch {
                    DispatchQueue.main.async(execute: {
                       print (error)
                    })
                }
            }
            
        }).resume()
        
    }
    
}
