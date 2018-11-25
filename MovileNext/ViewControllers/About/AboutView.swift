//
//  AboutView.swift
//  MovileNext
//
//  Created by Matheus on 25/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit
import Cartography

class AboutView: UIView {
    
    let ivLogo: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = UIImage(asset: ImgAssets.nextLogo)
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let lbTitle: UILabel = {
        let label = UILabel()
        label.text = "Movile Next iOS"
        label.font = UIFont.systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lbDescription: UILabel = {
       let label = UILabel()
        label.text = "O Movile Next é uma iniciativa criada pelo Grupo Movile, em parceria com a GlobalCode, para capacitar desenvolvedores Android, iOS e Backend de nível pleno e sênior e possibilitar um avanço em carreira. \n\nDurante 4 sábados acontecerão, simultaneamente, as formações de cada especialidade com aulas presenciais ministradas por especialistas do mercado, além de atividades e desafios complementares online durante a semana.\n\nO curso é 100% gratuito."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let lbCopyright: UILabel = {
        let label = UILabel()
        label.text = "© 2018 Matheus Fusco - All Rights Reserved"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        setupView()
        setupConstraints()
    }
    
    
    func setupView() {
        addSubview(lbTitle)
        addSubview(ivLogo)
        addSubview(lbDescription)
        addSubview(lbCopyright)
    }
    
    func setupConstraints() {
//        constrain(titleLabel, self) {_,_ in
//
//        }
        
        ivLogo.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        ivLogo.heightAnchor.constraint(equalToConstant: 50).isActive = true
        ivLogo.widthAnchor.constraint(equalToConstant: 100).isActive = true
        ivLogo.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        constrain(lbTitle, ivLogo) {
            $0.top == $1.bottom + 20
            $0.centerX == $1.centerX
        }
        
        constrain(lbDescription, lbTitle) {
            $0.top == $1.bottom + 20
            $0.centerX == $1.centerX
        }
        
        constrain(lbDescription, self) {
            $0.left == $1.left + 16
            $0.right == $1.right - 16
        }
        
        constrain(lbCopyright, self) {
            $0.bottom == $1.bottom - 16
            $0.centerX == $1.centerX
        }
    }
}
