import Foundation
import Alamofire
import SwiftyJSON

class NetworkingProcessor{
    
    func fetchJSON(url: String, entity: String){
        var jsonData = JSON()
        var results = [JSON]()
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).response { (response) in
            if response.data != nil{
                do{
                    jsonData = try JSON(data: response.data!)
                }
                catch{
                    jsonData = JSON([Dictionary <String, String>]())
                    print(error.localizedDescription)
                }
                if jsonData["results"].array != nil{
                    results = jsonData["results"].array!
                }
                for result in results{
                    var neededInfo = [String : String]()
                    let trackName = result["trackName"].stringValue
                    let artistName = result["artistName"].stringValue
                    let collectionName = result["collectionName"].stringValue
                    let longDescription = result["longDescription"].stringValue
                    let trackTimeMillis = result["trackTimeMillis"].intValue
                    let artworkUrl100 = result["artworkUrl100"].stringValue
                    let trackViewUrl = result["trackViewUrl"].stringValue
                    
                    neededInfo["trackName"] = trackName
                    neededInfo["artistName"] = artistName
                    neededInfo["collectionName"] = collectionName
                    neededInfo["longDescription"] = longDescription
                    neededInfo["trackTimeMillis"] = self.makeTimeFormat(trackTime: trackTimeMillis)
                    neededInfo["artworkUrl100"] = artworkUrl100
                    neededInfo["trackViewUrl"] = trackViewUrl
                    
                    for (key, value) in neededInfo{
                        if value == ""{
                            neededInfo[key] = "Unknown"
                        }
                    }
                    if entity == "movie"{
                        movies.append(neededInfo)
                    }else if entity == "musicVideo"{
                        musics.append(neededInfo)
                    }
                }
                print("ok")
                resultTable.reloadData()
            }else{
                print(response.error.debugDescription)
            }
        }
    }
    
    func makeTimeFormat(trackTime: Int)-> String{
        let totalSec = trackTime / 1000
        let hours = totalSec / 3600
        let minutes = totalSec / 60 % 60
        let seconds = totalSec % 60
        
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
}
