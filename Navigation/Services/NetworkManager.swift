import Foundation

struct NetworkManager {
    
    static let session = URLSession.shared
    
    static func dataTask(with url: URL, completion: @escaping (String?) -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            
            if let _ = response as? HTTPURLResponse {
                //print(httpResponse.allHeaderFields)
                //print(httpResponse.statusCode)
            }
            
            if let data = data {
                completion(String(data: data, encoding: .utf8))
            }
        }
        task.resume()
    }
    
    static func getJson(with url: URL, completion: @escaping (Data?) -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            
            if let data = data {
                completion(data)
            }
            
        }
        task.resume()
    }
    
    static func toOject(json: Data) throws -> Dictionary<String, Any>? {
        return try JSONSerialization.jsonObject(with: json, options: .mutableContainers) as? [String: Any]
    }
}
