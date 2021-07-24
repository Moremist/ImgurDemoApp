import Foundation

class API {
    
    let IMGUR_API_CLIENT_ID = "f35b6a3304a7bf4"
    let albumURL = "https://api.imgur.com/3/gallery"
    
    func getImages(page: Int, complition: @escaping ((Gallery?) -> Void)) {
        guard let url = URL(string: albumURL + "/hot/time/day/\(page)")  else {
            fatalError()
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Client-ID \(IMGUR_API_CLIENT_ID)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: urlRequest){data,response,error in
            if let data = data {
               do {
                var gallery = try JSONDecoder().decode(Gallery.self, from: data)
                gallery.data = gallery.data.filter({ data in
                    return data.images?[0].type == "image/jpeg" || data.images?[0].type == "image/gif"
                })
                complition(gallery)
        
               } catch let error {
                  print(error)
               }
            }
        }
        task.resume()
    }
    
    func getCommentsFor(galleryHash:String, completion: @escaping ((CommentsList?) -> Void)){
        let url = albumURL + "/\(galleryHash)/comments/"
        var urlRequest:URLRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Client-ID \(IMGUR_API_CLIENT_ID)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: urlRequest){data,response,error in
                if let data = data {
                   do {
                        let commentsList = try JSONDecoder().decode(CommentsList.self, from: data)
                        completion(commentsList)
                    
                   } catch let error {
                      print(error)
                   }
                }
        }
        task.resume()
    }
}
