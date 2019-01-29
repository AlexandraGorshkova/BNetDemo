//
//  Services.swift
//  BNetDemo
//
//  Created by Alexandra Gorshkova on 27/01/2019.
//  Copyright © 2019 Alexandra Gorshkova. All rights reserved.
//

import Foundation

typealias SessionCallback = (String?, String?) -> Void
typealias GetEntitesCallback = ([DataEntity]?,String?) -> Void
typealias AddCallback = (Bool?,String?) -> Void

class Services {
    
    func urlConstructor(body: String) ->  URLRequest{
        var urlConstructor = URLComponents()//URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "bnet.i-partner.ru"
        urlConstructor.path = "/testAPI/"
        var request = URLRequest(url: urlConstructor.url!)
        request.httpMethod = "POST"
        request.addValue("B3B5PLX-qa-rymYRlH", forHTTPHeaderField: "token")
        let bodyData = body
        request.httpBody = bodyData.data(using: String.Encoding.utf8)
        return request
    }
    
    
    func request(callback: @escaping SessionCallback) -> Void {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let request = urlConstructor(body: "a=new_session")
        
        let task = session.dataTask(with: request) { (data, response, error) in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            if json == nil {
                callback(nil, self.getError(error: ""))
            } else {
                let status = (json as! Dictionary<String, Any>)["status"] as! Int
                if status == 0 {
                    let error = (json as! Dictionary<String, Any>)["error"] as! String
                    callback(nil, self.getError(error: error))
                } else {
                    let data = (json as! Dictionary<String,Any>)["data"] as! Dictionary<String,Any>
                    let sessionId = data["session"] as! String
                    callback(sessionId, nil)
                }
            }
        }

        task.resume()
    }
    
    
    func requestEntites(sessionId: String,callback: @escaping GetEntitesCallback) -> Void {
        var entries: [DataEntity] = [DataEntity]()
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)//URLSession(configuration: configuration)
        
        let request = urlConstructor(body: "a=get_entries&session=" + sessionId)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            if json == nil {
                callback(nil,"Ошибка")
            } else {
                let status = (json as! Dictionary<String, Any>)["status"] as! Int
                if status == 0 {
                    let error = (json as! Dictionary<String, Any>)["error"] as! String
                    callback(nil,self.getError(error: error))
                } else{
                    let data = (json as! Dictionary<String,Any>)["data"] as! [[Dictionary<String,Any>]]
                    let list = (data[0] as! Array<Dictionary<String,Any>>)
                    for item in list {
                        let id = item["id"] as! String
                        let body = item["body"] as! String
                        let da = item["da"] as! String
                        let dm = item["dm"] as! String
                        let ent = DataEntity(id: id,body: body, da: da, dm: dm)
                        entries.append(ent)
                }
                    callback(entries,nil)
            }
            
        }
    }
        task.resume()
}
    
    func requestAdd(sessionId: String, message:String, callback: @escaping AddCallback) -> Void {
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let body = "a=add_entry&session=" + sessionId + "&body=" + message
        let request = urlConstructor(body: body)
        let task = session.dataTask(with: request) { (data, response, error) in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            if json == nil {
                callback(nil,"Ошибка")
            } else {
                let status = (json as! Dictionary<String, Any>)["status"] as! Int
                if status == 0 {
                    let error = (json as! Dictionary<String, Any>)["error"] as! String
                    callback(nil,self.getError(error: error))
                } else {
                    callback(true,nil)
                }
            }

        }
        task.resume()
    }
    
    func getError(error: String) -> String {
        switch error {
        case "unspecified header 'token'" :
            return "Не передан заголовок token"
        case "unspecified field 'session'":
            return "Не передан параметр session"
        case "invalid token":
            return "Неправильный token (отсутствует в базе данных)"
        case "Entry not found":
            return "Запись с такими параметрами не найдена (выводится при изменении записи либо удалении)"
        default:
            return "Нет соединения"
        }
    }
}


 

