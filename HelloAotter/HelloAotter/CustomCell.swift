import Foundation
import UIKit

class MusicCell: UITableViewCell{
    
    let infoImage = UIImageView()
    let trackLabel = UILabel()
    let artistLabel = UILabel()
    let collectionLabel = UILabel()
    let trackTimeLabel = UILabel()
    let descriptionLabel = UILabel()
    let followBtn = UIButton(type: UIButtonType.system)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(infoImage)
        self.contentView.addSubview(followBtn)
        self.contentView.addSubview(trackLabel)
        self.contentView.addSubview(artistLabel)
        self.contentView.addSubview(collectionLabel)
        self.contentView.addSubview(trackTimeLabel)
        self.contentView.addSubview(descriptionLabel)
        
        infoImage.translatesAutoresizingMaskIntoConstraints = false
        followBtn.translatesAutoresizingMaskIntoConstraints = false
        trackLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionLabel.translatesAutoresizingMaskIntoConstraints = false
        trackTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        infoImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        infoImage.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10).isActive = true
        infoImage.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.2).isActive = true
        infoImage.bottomAnchor.constraint(equalTo: trackTimeLabel.bottomAnchor, constant: -10).isActive = true
        infoImage.contentMode = UIViewContentMode.scaleAspectFit
        infoImage.layer.borderWidth = 2
        infoImage.layer.borderColor = imageBorderColor.cgColor
        
        trackLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        trackLabel.leftAnchor.constraint(equalTo: infoImage.rightAnchor, constant: 10).isActive = true
        trackLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -80).isActive = true
        trackLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        trackLabel.numberOfLines = 1
        trackLabel.font = UIFont.boldSystemFont(ofSize: 17)
        trackLabel.textColor = fontColor
        
        artistLabel.topAnchor.constraint(equalTo: trackLabel.bottomAnchor).isActive = true
        artistLabel.leftAnchor.constraint(equalTo: trackLabel.leftAnchor).isActive = true
        artistLabel.rightAnchor.constraint(equalTo: trackLabel.rightAnchor).isActive = true
        artistLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        artistLabel.numberOfLines = 1
        artistLabel.font = artistLabel.font.withSize(12)
        artistLabel.textColor = fontColor
        
        collectionLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor).isActive = true
        collectionLabel.leftAnchor.constraint(equalTo: trackLabel.leftAnchor).isActive = true
        collectionLabel.rightAnchor.constraint(equalTo: trackLabel.rightAnchor).isActive = true
        collectionLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        collectionLabel.numberOfLines = 1
        collectionLabel.font = collectionLabel.font.withSize(12)
        collectionLabel.textColor = fontColor
        
        trackTimeLabel.topAnchor.constraint(equalTo: collectionLabel.bottomAnchor).isActive = true
        trackTimeLabel.leftAnchor.constraint(equalTo: trackLabel.leftAnchor).isActive = true
        trackTimeLabel.rightAnchor.constraint(equalTo: trackLabel.rightAnchor).isActive = true
        trackTimeLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        trackTimeLabel.numberOfLines = 1
        trackTimeLabel.font = trackTimeLabel.font.withSize(12)
        trackTimeLabel.textColor = fontColor
        
        followBtn.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        followBtn.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true
        followBtn.widthAnchor.constraint(equalToConstant: 70).isActive = true
        followBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        followBtn.backgroundColor = UIColor.purple
        followBtn.setTitleColor(UIColor.white, for: .normal)
        followBtn.layer.cornerRadius = 5
        followBtn.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MovieCell: UITableViewCell{
    
    let infoImage = UIImageView()
    let trackLabel = UILabel()
    let artistLabel = UILabel()
    let collectionLabel = UILabel()
    let trackTimeLabel = UILabel()
    let descriptionLabel = UILabel()
    let followBtn = UIButton(type: UIButtonType.system)
    let readMoreBtn = UIButton()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(infoImage)
        self.contentView.addSubview(followBtn)
        self.contentView.addSubview(trackLabel)
        self.contentView.addSubview(artistLabel)
        self.contentView.addSubview(collectionLabel)
        self.contentView.addSubview(trackTimeLabel)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(readMoreBtn)
        
        infoImage.translatesAutoresizingMaskIntoConstraints = false
        followBtn.translatesAutoresizingMaskIntoConstraints = false
        trackLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionLabel.translatesAutoresizingMaskIntoConstraints = false
        trackTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        readMoreBtn.translatesAutoresizingMaskIntoConstraints = false
        
        infoImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        infoImage.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10).isActive = true
        infoImage.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.2).isActive = true
        infoImage.heightAnchor.constraint(equalTo: infoImage.widthAnchor, multiplier: 1.2).isActive = true
        infoImage.contentMode = UIViewContentMode.scaleAspectFit
        infoImage.layer.borderWidth = 2
        infoImage.layer.borderColor = imageBorderColor.cgColor
        
        trackLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        trackLabel.leftAnchor.constraint(equalTo: infoImage.rightAnchor, constant: 10).isActive = true
        trackLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -80).isActive = true
        trackLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        trackLabel.numberOfLines = 1
        trackLabel.font = UIFont.boldSystemFont(ofSize: 17)
        trackLabel.textColor = fontColor
        
        artistLabel.topAnchor.constraint(equalTo: trackLabel.bottomAnchor).isActive = true
        artistLabel.leftAnchor.constraint(equalTo: trackLabel.leftAnchor).isActive = true
        artistLabel.rightAnchor.constraint(equalTo: trackLabel.rightAnchor).isActive = true
        artistLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        artistLabel.numberOfLines = 1
        artistLabel.font = artistLabel.font.withSize(12)
        artistLabel.textColor = fontColor
        
        collectionLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor).isActive = true
        collectionLabel.leftAnchor.constraint(equalTo: trackLabel.leftAnchor).isActive = true
        collectionLabel.rightAnchor.constraint(equalTo: trackLabel.rightAnchor).isActive = true
        collectionLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        collectionLabel.numberOfLines = 1
        collectionLabel.font = collectionLabel.font.withSize(12)
        collectionLabel.textColor = fontColor
        
        trackTimeLabel.topAnchor.constraint(equalTo: collectionLabel.bottomAnchor).isActive = true
        trackTimeLabel.leftAnchor.constraint(equalTo: trackLabel.leftAnchor).isActive = true
        trackTimeLabel.rightAnchor.constraint(equalTo: trackLabel.rightAnchor).isActive = true
        trackTimeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        trackTimeLabel.numberOfLines = 1
        trackTimeLabel.font = trackTimeLabel.font.withSize(12)
        trackTimeLabel.textColor = fontColor
        
        followBtn.centerYAnchor.constraint(equalTo: collectionLabel.centerYAnchor).isActive = true
        followBtn.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true
        followBtn.widthAnchor.constraint(equalToConstant: 70).isActive = true
        followBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        followBtn.backgroundColor = UIColor.purple
        followBtn.setTitleColor(UIColor.white, for: .normal)

    }
    
    func prepareReadMore(isNeeded: Bool){
        if isNeeded{
            readMoreBtn.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor).isActive = true
            readMoreBtn.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true
            readMoreBtn.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
            readMoreBtn.widthAnchor.constraint(equalToConstant: 58).isActive = true
            readMoreBtn.setTitle("read more", for: .normal)
            readMoreBtn.setTitleColor(UIColor.blue, for: .normal)
            readMoreBtn.titleLabel?.font = readMoreBtn.titleLabel?.font.withSize(12)
            readMoreBtn.addTarget(self, action: #selector(readMore), for: .touchUpInside)
            self.contentView.bringSubview(toFront: readMoreBtn)
            
            descriptionLabel.topAnchor.constraint(equalTo: trackTimeLabel.bottomAnchor).isActive = true
            descriptionLabel.leftAnchor.constraint(equalTo: trackLabel.leftAnchor).isActive = true
            descriptionLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
            descriptionLabel.bottomAnchor.constraint(equalTo: readMoreBtn.topAnchor).isActive = true
            descriptionLabel.numberOfLines = 2
            descriptionLabel.font = descriptionLabel.font.withSize(12)
            descriptionLabel.textColor = fontColor
            
        }else{
            descriptionLabel.topAnchor.constraint(equalTo: trackTimeLabel.bottomAnchor).isActive = true
            descriptionLabel.leftAnchor.constraint(equalTo: trackLabel.leftAnchor).isActive = true
            descriptionLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
            descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
            descriptionLabel.numberOfLines = 2
            descriptionLabel.font = descriptionLabel.font.withSize(12)
            descriptionLabel.textColor = fontColor
        }
    }
    
    @objc func readMore(){
        // Expand the description
        if descriptionLabel.numberOfLines == 2{
            readMoreBtn.setTitle("show less", for: .normal)
            resultTable.beginUpdates()
            descriptionLabel.numberOfLines = 0
            resultTable.endUpdates()
        }
        // shorten the description
        else{
            readMoreBtn.setTitle("read more", for: .normal)
            resultTable.beginUpdates()

            descriptionLabel.numberOfLines = 2
            resultTable.endUpdates()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PersonalTableCell: UITableViewCell{
    
    let descriptionView = UILabel()
    let captionView = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(descriptionView)
        self.contentView.addSubview(captionView)
        
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        captionView.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        descriptionView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10).isActive = true
        descriptionView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.3).isActive = true
        descriptionView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor).isActive = true
        descriptionView.font = descriptionView.font.withSize(17)
        descriptionView.textColor = fontColor
        
        captionView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        captionView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true
        captionView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.3).isActive = true
        captionView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor).isActive = true
        captionView.font = captionView.font.withSize(17)
        captionView.textAlignment = .right
        captionView.textColor = fontColor
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class InfoCell: UITableViewCell{
    
    let questionMark = UIImageView()
    let infoLabel = UILabel()
    let helpBtn = UIButton(type: UIButtonType.system)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(questionMark)
        self.contentView.addSubview(infoLabel)
        self.contentView.addSubview(helpBtn)
        
        questionMark.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        helpBtn.translatesAutoresizingMaskIntoConstraints = false
        
        infoLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        infoLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        infoLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor).isActive = true
        infoLabel.widthAnchor.constraint(equalToConstant: 140).isActive = true
        infoLabel.textColor = fontColor
        
        questionMark.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        questionMark.rightAnchor.constraint(equalTo: infoLabel.leftAnchor).isActive = true
        questionMark.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.6).isActive = true
        questionMark.widthAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.6).isActive = true
        questionMark.contentMode = UIViewContentMode.scaleAspectFit
        
        helpBtn.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        helpBtn.leftAnchor.constraint(equalTo: questionMark.leftAnchor).isActive = true
        helpBtn.rightAnchor.constraint(equalTo: infoLabel.rightAnchor).isActive = true
        helpBtn.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ColorCell: UITableViewCell{
    
    let markSign = UIImageView()
    let colorTypeLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        markSign.translatesAutoresizingMaskIntoConstraints = false
        colorTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(markSign)
        self.contentView.addSubview(colorTypeLabel)
        
        markSign.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15).isActive = true
        markSign.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -15).isActive = true
        markSign.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.5).isActive = true
        markSign.widthAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.5).isActive = true
        markSign.contentMode = UIViewContentMode.scaleAspectFit
        
        
        colorTypeLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        colorTypeLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10).isActive = true
        colorTypeLabel.rightAnchor.constraint(equalTo: markSign.leftAnchor).isActive = true
        colorTypeLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor).isActive = true
        colorTypeLabel.textColor = fontColor
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

