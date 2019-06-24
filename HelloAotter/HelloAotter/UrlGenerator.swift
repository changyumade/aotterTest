import Foundation

// Generate url for NetworkingProcessor
enum UrlGenerator{
    case searchMusic(term: String)
    case searchMovie(term: String)
    
    var searchURL: String{
        var components = URLComponents(string: baseSearchURL)!
        components.queryItems = queryComponent
        let url = components.string!
        return url
    }
    
    private var baseSearchURL: String{
        return "https://itunes.apple.com/search?"
    }
    
    struct ParameterKeys{
        static let term = "term"
        static let entity = "entity"
    }
    
    private var parameters: [String : Any]{
        var allParameters = [String : Any]()
        switch self {
        case .searchMovie(let term):
            allParameters = [
                ParameterKeys.term : term,
                ParameterKeys.entity : "movie"
            ]
        return allParameters
        case .searchMusic(let term):
            allParameters = [
                ParameterKeys.term : term,
                ParameterKeys.entity : "musicVideo"
            ]
        }
        return allParameters
    }
    
    private var queryComponent: [URLQueryItem]{
        var components = [URLQueryItem]()
        for (key, value) in parameters{
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.append(queryItem)
        }
        return components
    }
}
