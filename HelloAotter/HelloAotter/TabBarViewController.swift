import Foundation
import UIKit
import Alamofire

// Global variable declarattion
let resultTable = UITableView()
var musics = [Dictionary <String, String>]()
var movies = [Dictionary <String, String>]()
var musicCollections = [String : Dictionary <String, String>]()
var movieCollections = [String : Dictionary <String, String>]()
var isBlackMode = false

// PreSet a space in the begining of textField
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UITabBar.appearance().tintColor = UIColor.darkGray
        UITabBar.appearance().backgroundColor = UIColor.white
    }
}

// Handle the view of searching
class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let searchBar = UITextField()
    let searchBtn = UIButton()
    let topLine = UIView()
    let sectionTitle = ["音樂", "電影"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // UI init
        self.view.addSubview(searchBar)
        self.view.addSubview(searchBtn)
        self.view.addSubview(resultTable)
        self.view.addSubview(topLine)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBtn.translatesAutoresizingMaskIntoConstraints = false
        resultTable.translatesAutoresizingMaskIntoConstraints = false
        topLine.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        searchBar.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true
        searchBar.rightAnchor.constraint(equalTo: searchBtn.leftAnchor, constant: -5).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchBar.layer.borderWidth = 2
        searchBar.setLeftPaddingPoints(10)
        searchBar.placeholder = " 搜尋"
        
        searchBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 35).isActive = true
        searchBtn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        searchBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        searchBtn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        searchBtn.addTarget(self, action: #selector(getData), for: .touchUpInside)
        searchBtn.setImage(#imageLiteral(resourceName: "searchicon"), for: .normal)
        searchBtn.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        
        resultTable.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10).isActive = true
        resultTable.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true
        resultTable.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant: -5).isActive = true
        resultTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -49).isActive = true
        resultTable.layer.borderWidth = 2
        resultTable.separatorStyle = UITableViewCellSeparatorStyle.none
        
        topLine.topAnchor.constraint(equalTo: searchBar.topAnchor).isActive = true
        topLine.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        topLine.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        topLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
        topLine.backgroundColor = borderLineColor
        
        // Set tableView delegate and dataSource as self
        resultTable.delegate = self
        resultTable.dataSource = self
        
        // Register the custom cell
        resultTable.register(MovieCell.self, forCellReuseIdentifier: "movieCell")
        resultTable.register(MusicCell.self, forCellReuseIdentifier: "musicCell")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Set color of UI here:
        self.view.backgroundColor = viewBackgroundColor
        searchBar.layer.borderColor = borderLineColor.cgColor
        searchBar.textColor = fontColor
        resultTable.backgroundColor = viewBackgroundColor
        resultTable.layer.borderColor = borderLineColor.cgColor
        topLine.backgroundColor = borderLineColor
        
        if isBlackMode{
            searchBtn.setImage(#imageLiteral(resourceName: "whiteSearch"), for: .normal)
        }else{
            searchBtn.setImage(#imageLiteral(resourceName: "searchicon"), for: .normal)
        }
        
        resultTable.estimatedRowHeight = 100
        resultTable.rowHeight = UITableViewAutomaticDimension
        resultTable.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return sectionTitle[0]
        }else{
            return sectionTitle[1]
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = headerColor
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return musics.count
        }else{
            return movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let imageCache = NSCache<AnyObject, AnyObject>()
        var needToLoad = true
        
        // In music section
        if indexPath.section == 0{
            let musicCell = tableView.dequeueReusableCell(withIdentifier: "musicCell", for: indexPath) as! MusicCell
            
            // Assign value from Alamofire's response to each UI element
            musicCell.trackLabel.text = musics[indexPath.row]["trackName"]
            musicCell.artistLabel.text = musics[indexPath.row]["artistName"]
            musicCell.collectionLabel.text = musics[indexPath.row]["collectionName"]
            musicCell.trackTimeLabel.text = musics[indexPath.row]["trackTimeMillis"]
            
            musicCell.trackLabel.textColor = fontColor
            musicCell.artistLabel.textColor = fontColor
            musicCell.collectionLabel.textColor = fontColor
            musicCell.trackTimeLabel.textColor = fontColor
            
            let musicImageUrl = URL(string: musics[indexPath.row]["artworkUrl100"]!)!
            // In order to avoid downloading wrong image to the cell
            musicCell.infoImage.image = nil
            
            // Image Downloadong process(to line 184)
            if let imageFromCache = imageCache.object(forKey: musicImageUrl as AnyObject) as? UIImage {
                musicCell.infoImage.image = imageFromCache
                needToLoad = false
            }
            if needToLoad{
                DispatchQueue.global().async {
                    do{
                        let musicImageData = try Data(contentsOf: musicImageUrl)
                        DispatchQueue.main.async {
                            let imageToCache = UIImage(data: musicImageData)
                            imageCache.setObject(imageToCache!, forKey: musicImageUrl as AnyObject)
                            musicCell.infoImage.image = imageToCache
                        }
                    } catch {
                        // not gonna happen
                    }
                }
            }
            
            // set collection button property
            musicCell.followBtn.tag = indexPath.row
            musicCell.followBtn.addTarget(self, action: #selector(musicCollectionProcess(sender:)), for: .touchUpInside)
            musicCell.followBtn.setTitle("收藏", for: .normal)
            for (key, _) in musicCollections{
                if key == musics[indexPath.row]["trackViewUrl"]{
                    musicCell.followBtn.setTitle("取消收藏", for: .normal)
                }
            }
            
            // Set cell color style with proper theme-color
            musicCell.contentView.layer.borderWidth = 2
            musicCell.contentView.layer.borderColor = borderLineColor.cgColor
            musicCell.contentView.backgroundColor = viewBackgroundColor
            
            return musicCell
        }
        // In movie section (Implementing similar code with music section)
        let movieCell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieCell
        movieCell.trackLabel.text = movies[indexPath.row]["trackName"]
        movieCell.artistLabel.text = movies[indexPath.row]["artistName"]
        movieCell.collectionLabel.text = movies[indexPath.row]["collectionName"]
        movieCell.trackTimeLabel.text = movies[indexPath.row]["trackTimeMillis"]
        movieCell.descriptionLabel.text = movies[indexPath.row]["longDescription"]
        
        movieCell.trackLabel.textColor = fontColor
        movieCell.artistLabel.textColor = fontColor
        movieCell.collectionLabel.textColor = fontColor
        movieCell.trackTimeLabel.textColor = fontColor
        movieCell.descriptionLabel.textColor = fontColor
        
        let movieImageUrl = URL(string: movies[indexPath.row]["artworkUrl100"]!)!
        movieCell.infoImage.image = nil
        
        if let imageFromCache = imageCache.object(forKey: movieImageUrl as AnyObject) as? UIImage{
            movieCell.infoImage.image = imageFromCache
            needToLoad = false
        }
        if needToLoad{
            DispatchQueue.global().async {
                do{
                    let movieImageData = try Data(contentsOf: movieImageUrl)
                    DispatchQueue.main.async {
                        let imageToCache = UIImage(data: movieImageData)
                        imageCache.setObject(imageToCache!, forKey: movieImageUrl as AnyObject)
                        movieCell.infoImage.image = imageToCache
                    }
                } catch {
                    // not gonna happen
                }
            }
        }
        
        movieCell.followBtn.tag = indexPath.row
        movieCell.followBtn.addTarget(self, action: #selector(movieCollectionProcess(sender:)), for: .touchUpInside)
        
        movieCell.followBtn.setTitle("收藏", for: .normal)
        for (key, _) in movieCollections{
            if key == movies[indexPath.row]["trackViewUrl"]{
                movieCell.followBtn.setTitle("取消收藏", for: .normal)
            }
        }

        // Check if the movie description is over 2 lines
        let descriptionSize = movieCell.descriptionLabel.text?.size(withAttributes:[.font: UIFont.systemFont(ofSize:12.0)])
        if (descriptionSize?.width)! > movieCell.descriptionLabel.frame.width * 2{
            // Is over 2 lines, put a "readMore" button on the end of cell
            movieCell.prepareReadMore(isNeeded: true)
        }else{
            movieCell.prepareReadMore(isNeeded: false)
        }
        
        movieCell.contentView.layer.borderWidth = 2
        movieCell.contentView.layer.borderColor = borderLineColor.cgColor
        movieCell.contentView.backgroundColor = viewBackgroundColor
        
        return movieCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Tap on the cell and move to the website
        
        if indexPath.section == 1{
            let urlString = movies[indexPath.row]["trackViewUrl"]
            let url = URL(string: urlString!)
            let canOpen = UIApplication.shared.canOpenURL(url!)
            if canOpen{
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            }else{
                //set alert
            }
        }else{
            let urlString = musics[indexPath.row]["trackViewUrl"]
            let url = URL(string: urlString!)
            let canOpen = UIApplication.shared.canOpenURL(url!)
            if canOpen{
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            }else{
                //set alert
            }
        }
    }
    
    // Trigger this func after tapping on the search button
    @objc func getData(){
        movies = [Dictionary <String, String>]()
        musics = [Dictionary <String, String>]()
        let term = searchBar.text
        searchBar.text = ""
        let movieURL = UrlGenerator.searchMovie(term: term!).searchURL
        let musicURL = UrlGenerator.searchMusic(term: term!).searchURL
        NetworkingProcessor().fetchJSON(url: movieURL, entity: "movie")
        NetworkingProcessor().fetchJSON(url: musicURL, entity: "musicVideo")
    }
    
    // tap collection button and add corresponding data to the global dictionary
    @objc func musicCollectionProcess(sender: UIButton){
        if sender.titleLabel?.text == "收藏"{
            musicCollections[musics[sender.tag]["trackViewUrl"]!] = musics[sender.tag]
            sender.setTitle("取消收藏", for: .normal)
        }else{
            musicCollections[musics[sender.tag]["trackViewUrl"]!] = nil
            sender.setTitle("收藏", for: .normal)
        }
    }
    
    // tap collection button and add corresponding data to the global dictionary
    @objc func movieCollectionProcess(sender: UIButton){
        if sender.titleLabel?.text == "收藏"{
            movieCollections[movies[sender.tag]["trackViewUrl"]!] = movies[sender.tag]
            sender.setTitle("取消收藏", for: .normal)
        }else{
            movieCollections[movies[sender.tag]["trackViewUrl"]!] = nil
            sender.setTitle("收藏", for: .normal)
        }
    }
}


// Handling a view of profile
class IndividualViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let personalTable = UITableView()
    let line = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationController?.navigationBar.topItem?.title = "個人資料"
        
        personalTable.delegate = self
        personalTable.dataSource = self
        
        personalTable.register(PersonalTableCell.self, forCellReuseIdentifier: "personalTableCell")
        personalTable.register(InfoCell.self, forCellReuseIdentifier: "infoCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // UI init
        self.navigationController?.navigationBar.addSubview(line)
        self.view.addSubview(personalTable)
        personalTable.translatesAutoresizingMaskIntoConstraints = false
        
        line.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.height)!, width: self.view.frame.width, height: 2)
        
        personalTable.translatesAutoresizingMaskIntoConstraints = false
        personalTable.topAnchor.constraint(equalTo: (self.navigationController?.navigationBar.bottomAnchor)!).isActive = true
        personalTable.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: -2).isActive = true
        personalTable.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 2).isActive = true
        personalTable.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        personalTable.separatorStyle = UITableViewCellSeparatorStyle.none
        
        // Set color of UI here:
        self.view.backgroundColor = viewBackgroundColor
        line.backgroundColor = imageBorderColor
        navigationController?.navigationBar.barTintColor = navigationBarColor
        personalTable.backgroundColor = viewBackgroundColor
        
        // Set fix rowHeight of cell
        personalTable.estimatedRowHeight = 0
        personalTable.rowHeight = 50
        
        personalTable.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: personalTable.frame.size.width, height: 25))
            headerView.backgroundColor = viewBackgroundColor
            return headerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Setting row of "About apple iTunes"
        if indexPath.row == 1{
            let infoCell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! InfoCell
            
            infoCell.infoLabel.text = "關於Apple iTunes"
            infoCell.helpBtn.addTarget(self, action: #selector(goToITunes), for: .touchUpInside)
            
            if isBlackMode{
                infoCell.questionMark.image = #imageLiteral(resourceName: "whiteQuestion")
            }else{
                infoCell.questionMark.image = #imageLiteral(resourceName: "icons8-help-100")
            }
            infoCell.contentView.backgroundColor = viewBackgroundColor
            infoCell.infoLabel.textColor = fontColor
            
            return infoCell
        }
        
        // Setting rest of rows
        let personalTableCell = tableView.dequeueReusableCell(withIdentifier: "personalTableCell", for: indexPath) as! PersonalTableCell
        
        personalTableCell.contentView.layer.borderWidth = 2
        personalTableCell.contentView.layer.borderColor = borderLineColor.cgColor
        personalTableCell.contentView.backgroundColor = viewBackgroundColor
        personalTableCell.captionView.textColor = fontColor
        personalTableCell.descriptionView.textColor = fontColor
        
        if indexPath.section == 0{
            personalTableCell.descriptionView.text = "主題顏色"
            if isBlackMode{
                personalTableCell.captionView.text = "深色主題"
            }else{
                personalTableCell.captionView.text = "淺色主題"
            }
            
            return personalTableCell
        }
        personalTableCell.descriptionView.text = "收藏項目"
        personalTableCell.captionView.text = "共有\(musicCollections.count + movieCollections.count)項收藏"
        
        return personalTableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            let vc = ColorViewController()
            navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.section == 1 && indexPath.row == 0{
            let vc = CollectionViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func goToITunes(){
        let url = URL(string: "https://support.apple.com/itunes")
        let canOpen = UIApplication.shared.canOpenURL(url!)
        if canOpen{
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }else{
            // alert
        }
    }
}
