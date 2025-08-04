//
//  ViewController2.swift
//  AdilIntoToNetwork
//
//  Created by Aldiyar Aitpayev on 23.07.2025.
//

import UIKit
import Kingfisher

class CharacterCell: UITableViewCell {
    var task: CharacterModel?
    var delegate: ViewController?
    var index = 0
    
    lazy var avatar: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 30
        return image
    }()
    lazy var nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = .boldSystemFont(ofSize: 20)
       
        return lbl
    }()
    lazy var famalyLbl: UILabel = {
        let fml = UILabel()
        fml.font = .systemFont(ofSize: 15)
        fml.numberOfLines = 0
        fml.textColor = .darkGray
        return fml
    }()
    lazy var textfl: UITextField = {
        let txt = UITextField()
        txt.placeholder = "Search"
        return txt
    }()
    
    func setUp(task: CharacterModel) {
        self.task = task
        nameLbl.text = task.fullName
        famalyLbl.text = task.family == "" ? "Mangurt" : task.family
        
        
        if let url = URL(string: task.imageUrl) {
            avatar.kf.setImage(
                with: url,
                placeholder: UIImage(systemName: "person.circle")
            )
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubview(avatar)
        contentView.addSubview(nameLbl)
        contentView.addSubview(famalyLbl)
        avatar.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.height.width.equalTo(60)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        nameLbl.snp.makeConstraints { make in
            make.leading.equalTo(avatar.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(16)
        }
        famalyLbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom).offset(10)
            make.leading.equalTo(avatar.snp.trailing).offset(20)
          
        }

       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}
