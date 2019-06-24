import UIKit

class ColorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let colorTable = UITableView()
    var darkIsMarked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "主題顏色"
        
        colorTable.delegate = self
        colorTable.dataSource = self
        
        colorTable.register(ColorCell.self, forCellReuseIdentifier: "colorCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        colorTable.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(colorTable)
        
        colorTable.topAnchor.constraint(equalTo: (self.navigationController?.navigationBar.bottomAnchor)!, constant: 30).isActive = true
        colorTable.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        colorTable.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        colorTable.bottomAnchor.constraint(equalTo: (self.tabBarController?.tabBar.topAnchor)!).isActive = true
        colorTable.separatorStyle = UITableViewCellSeparatorStyle.none
        colorTable.estimatedRowHeight = 0
        colorTable.rowHeight = 60
        
        self.view.backgroundColor = viewBackgroundColor
        colorTable.backgroundColor = viewBackgroundColor
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let colorCell = tableView.dequeueReusableCell(withIdentifier: "colorCell", for: indexPath) as! ColorCell
        if isBlackMode{
            if indexPath.row == 0{
                colorCell.colorTypeLabel.text = "深色主題"
                colorCell.markSign.image = #imageLiteral(resourceName: "whiteTick")
            }else{
                colorCell.colorTypeLabel.text = "淺色主題"
                colorCell.markSign.image = nil
            }
        }else{
            if indexPath.row == 0{
                colorCell.colorTypeLabel.text = "深色主題"
                colorCell.markSign.image = nil
            }else{
                colorCell.colorTypeLabel.text = "淺色主題"
                colorCell.markSign.image = #imageLiteral(resourceName: "icons8-checkmark-90")
            }
        }
        colorCell.contentView.layer.borderWidth = 2
        colorCell.contentView.layer.borderColor = borderLineColor.cgColor
        colorCell.contentView.backgroundColor = viewBackgroundColor
        colorCell.colorTypeLabel.textColor = fontColor
        
        return colorCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isBlackMode{
            if indexPath.row == 1{
                // Is in light-color theme
                isBlackMode = false
                
                borderLineColor = UIColor(red: 0xAA/0xFF, green: 0xAA/0xFF, blue: 0xAA/0xFF, alpha: 1)
                imageBorderColor = UIColor(red: 0x00/0xFF, green: 0x88/0xFF, blue: 0x88/0xFF, alpha: 1)
                navigationBarColor = UIColor(red: 0x00/0xFF, green: 0xFF/0xFF, blue: 0xCC/0xFF, alpha: 1)
                headerColor = UIColor(red: 0xDD/0xFF, green: 0xDD/0xFF, blue: 0xDD/0xFF, alpha: 1)
                fontColor = UIColor.black
                viewBackgroundColor = UIColor.white
                
                navigationController?.navigationBar.barTintColor = navigationBarColor
                colorTable.backgroundColor = viewBackgroundColor
                self.view.backgroundColor = viewBackgroundColor
                tabBarController?.tabBar.barStyle = .default
                tabBarController?.tabBar.tintColor = UIColor.darkGray
                tabBarController?.tabBar.backgroundColor = UIColor.white
                UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
                
                colorTable.reloadData()
            }
        }else{
            if indexPath.row == 0{
                // Is in dark-color theme
                isBlackMode = true
                
                borderLineColor = UIColor.red
                imageBorderColor = UIColor.brown
                navigationBarColor = UIColor.red
                headerColor = UIColor(red: 0xFF/0xFF, green: 0x88/0xFF, blue: 0x88/0xFF, alpha: 1)
                fontColor = UIColor.white
                viewBackgroundColor = UIColor.black
                
                navigationController?.navigationBar.barTintColor = navigationBarColor
                colorTable.backgroundColor = viewBackgroundColor
                self.view.backgroundColor = viewBackgroundColor
                tabBarController?.tabBar.barStyle = .black
                tabBarController?.tabBar.tintColor = UIColor.red
                tabBarController?.tabBar.backgroundColor = UIColor.black
                UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
                
                colorTable.reloadData()
            }
        }
        colorTable.reloadData()
    }
}

class CollectionViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    let musicLabel = UILabel()
    let movieLabel = UILabel()
    let collectionTable = UITableView()
    let topLine = UIView()
    let bottomLine = UIView()
    var isSelectedMovie = true
    var movieData = [Dictionary <String, String>]()
    var musicData = [Dictionary <String, String>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        movieData = Array(movieCollections.values)
        musicData = Array(musicCollections.values)
        
        self.title = "收藏項目"
        
        // Set gesture recognizer to switch collections between movie and music
        let swipeToLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipe(gesture:)))
        swipeToLeft.direction = .left
        self.collectionTable.addGestureRecognizer(swipeToLeft)
        
        let swipeToRight = UISwipeGestureRecognizer(target: self, action: #selector(swipe(gesture:)))
        swipeToRight.direction = .right
        self.collectionTable.addGestureRecognizer(swipeToRight)
        
        let tapMovie = UITapGestureRecognizer(target: self, action: #selector(tap(gesture:)))
        tapMovie.name = "tapMovie"
        tapMovie.numberOfTapsRequired = 1
        tapMovie.numberOfTouchesRequired = 1
        self.movieLabel.addGestureRecognizer(tapMovie)
        
        let tapMusic = UITapGestureRecognizer(target: self, action: #selector(tap(gesture:)))
        tapMusic.name = "tapMusic"
        tapMusic.numberOfTapsRequired = 1
        tapMusic.numberOfTouchesRequired = 1
        self.musicLabel.addGestureRecognizer(tapMusic)
        
        collectionTable.delegate = self
        collectionTable.dataSource = self
        
        collectionTable.register(MovieCell.self, forCellReuseIdentifier: "movieCell")
        collectionTable.register(MusicCell.self, forCellReuseIdentifier: "musicCell")
        
        collectionTable.separatorStyle = UITableViewCellSeparatorStyle.none
        
        movieLabel.backgroundColor = UIColor.lightGray
        musicLabel.backgroundColor = UIColor.white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // UI init
        self.view.addSubview(musicLabel)
        self.view.addSubview(movieLabel)
        self.view.addSubview(collectionTable)
        self.view.addSubview(topLine)
        self.view.addSubview(bottomLine)
        musicLabel.translatesAutoresizingMaskIntoConstraints = false
        movieLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionTable.translatesAutoresizingMaskIntoConstraints = false
        topLine.translatesAutoresizingMaskIntoConstraints = false
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        
        movieLabel.topAnchor.constraint(equalTo: (self.navigationController?.navigationBar.bottomAnchor)!, constant: 10).isActive = true
        movieLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -self.view.frame.width / 6).isActive = true
        movieLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        movieLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.33).isActive = true
        movieLabel.text = "電影"
        movieLabel.textAlignment = .center
        movieLabel.layer.borderWidth = 1
        movieLabel.isUserInteractionEnabled = true
        
        
        musicLabel.topAnchor.constraint(equalTo: movieLabel.topAnchor).isActive = true
        musicLabel.leftAnchor.constraint(equalTo: movieLabel.rightAnchor).isActive = true
        musicLabel.widthAnchor.constraint(equalTo: movieLabel.widthAnchor).isActive = true
        musicLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        musicLabel.text = "音樂"
        musicLabel.textAlignment = .center
        musicLabel.layer.borderWidth = 1
        musicLabel.isUserInteractionEnabled = true
        
        collectionTable.topAnchor.constraint(equalTo: movieLabel.bottomAnchor, constant: 30).isActive = true
        collectionTable.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        collectionTable.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        collectionTable.bottomAnchor.constraint(equalTo: (self.tabBarController?.tabBar.topAnchor)!, constant: -30).isActive = true
        
        topLine.bottomAnchor.constraint(equalTo: collectionTable.topAnchor).isActive = true
        topLine.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        topLine.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        topLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        bottomLine.topAnchor.constraint(equalTo: collectionTable.bottomAnchor).isActive = true
        bottomLine.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        bottomLine.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        bottomLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        // Set UI color here:
        self.view.backgroundColor = viewBackgroundColor
        movieLabel.layer.borderColor = UIColor.black.cgColor
        musicLabel.layer.borderColor = UIColor.black.cgColor
        collectionTable.backgroundColor = viewBackgroundColor
        topLine.backgroundColor = borderLineColor
        bottomLine.backgroundColor = borderLineColor

    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
        header.backgroundColor = viewBackgroundColor
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSelectedMovie{
            return movieCollections.count
        }else{
            return musicCollections.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let imageCache = NSCache<AnyObject, AnyObject>()
        var needToLoad = true
        
        if isSelectedMovie{
            let movieCell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieCell
            
            // Assign data from collection dictionary(from movieCollections)
            movieCell.trackLabel.text = movieData[indexPath.row]["trackName"]
            movieCell.artistLabel.text = movieData[indexPath.row]["artistName"]
            movieCell.collectionLabel.text = movieData[indexPath.row]["collectionName"]
            movieCell.trackTimeLabel.text = movieData[indexPath.row]["trackTimeMillis"]
            movieCell.descriptionLabel.text = movieData[indexPath.row]["longDescription"]
            let movieImageUrl = URL(string: movieData[indexPath.row]["artworkUrl100"]!)!
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
            movieCell.followBtn.addTarget(self, action: #selector(removeMovieCollection), for: .touchUpInside)
            movieCell.followBtn.setTitle("取消收藏", for: .normal)
            
            let descriptionSize = movieCell.descriptionLabel.text?.size(withAttributes:[.font: UIFont.systemFont(ofSize:12.0)])
            if (descriptionSize?.width)! > movieCell.descriptionLabel.frame.width * 2{
                movieCell.prepareReadMore(isNeeded: true)
            }else{
                movieCell.prepareReadMore(isNeeded: false)
            }
            
            movieCell.contentView.backgroundColor = viewBackgroundColor
            movieCell.contentView.layer.borderWidth = 2
            movieCell.contentView.layer.borderColor = borderLineColor.cgColor
            
            return movieCell
        }else{
            let musicCell = tableView.dequeueReusableCell(withIdentifier: "musicCell", for: indexPath) as! MusicCell
            
            // Assign data from collection dictionary(from musicCollections)
            musicCell.trackLabel.text = musicData[indexPath.row]["trackName"]
            musicCell.artistLabel.text = musicData[indexPath.row]["artistName"]
            musicCell.collectionLabel.text = musicData[indexPath.row]["collectionName"]
            musicCell.trackTimeLabel.text = musicData[indexPath.row]["trackTimeMillis"]
            let musicImageUrl = URL(string: musicData[indexPath.row]["artworkUrl100"]!)!
            musicCell.infoImage.image = nil
            
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
            
            
            musicCell.followBtn.tag = indexPath.row
            musicCell.followBtn.addTarget(self, action: #selector(removeMusicCollection), for: .touchUpInside)
            musicCell.followBtn.setTitle("取消收藏", for: .normal)
            
            musicCell.contentView.backgroundColor = viewBackgroundColor
            musicCell.contentView.layer.borderWidth = 2
            musicCell.contentView.layer.borderColor = borderLineColor.cgColor
            
            return musicCell
        }
    }
    
    @objc func tap(gesture: UITapGestureRecognizer){
        if gesture.name == "tapMovie"{
            movieLabel.backgroundColor = UIColor.lightGray
            musicLabel.backgroundColor = UIColor.white
            isSelectedMovie = true
        }else{
            movieLabel.backgroundColor = UIColor.white
            musicLabel.backgroundColor = UIColor.lightGray
            isSelectedMovie = false
        }
        collectionTable.reloadData()
    }
    
    @objc func swipe(gesture: UISwipeGestureRecognizer){
        if gesture.direction == .left{
            print("left")
            movieLabel.backgroundColor = UIColor.white
            musicLabel.backgroundColor = UIColor.lightGray
            isSelectedMovie = false
        }
        else if gesture.direction == .right{
            print("right")
            movieLabel.backgroundColor = UIColor.lightGray
            musicLabel.backgroundColor = UIColor.white
            isSelectedMovie = true
        }
        collectionTable.reloadData()
    }
    
    @objc func removeMovieCollection(sender: UIButton){
        if sender.titleLabel?.text == "取消收藏"{
            sender.setTitle("收藏", for: .normal)
            let key = movieData[sender.tag]["trackViewUrl"]
            movieCollections[key!] = nil
        }else{
            sender.setTitle("取消收藏", for: .normal)
            let key = movieData[sender.tag]["trackViewUrl"]
            movieCollections[key!] = movieData[sender.tag]
        }
    }
    
    @objc func removeMusicCollection(sender: UIButton){
        if sender.titleLabel?.text == "取消收藏"{
            sender.setTitle("收藏", for: .normal)
            let key = musicData[sender.tag]["trackViewUrl"]
            musicCollections[key!] = nil
        }else{
            sender.setTitle("取消收藏", for: .normal)
            let key = musicData[sender.tag]["trackViewUrl"]
            musicCollections[key!] = musicData[sender.tag]
        }

    }
}

