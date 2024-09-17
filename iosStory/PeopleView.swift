//
//  peopleView.swift
//  iosStory
//
//  Created by marcephrem on 17/09/2024.
//

import UIKit

class PeopleView: UIView {

    // creation du personal stack view
    private lazy var PeopleStackView: UIStackView = {
          let stackView = UIStackView()
          stackView.translatesAutoresizingMaskIntoConstraints = false
          stackView.axis = .vertical
          stackView.spacing = 8
          return stackView
      }()
    
    // creation des label
    private lazy var nameLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enter your name"
        label.textColor = .black
        return label
    }()
    
    private lazy var emailLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enter your email"
        label.textColor = .black
        return label
    }()
    
    // creation du button
    private lazy var subscribersBtn: UIButton = {
         var config = UIButton.Configuration.filled()
         config.baseBackgroundColor = .red
         config.baseForegroundColor = .white
         config.buttonSize = .large
         config.cornerStyle = .medium
         
         let btn = UIButton(configuration: config)
        btn.setTitle("Subscribe".uppercased(), for: .normal)
         btn.translatesAutoresizingMaskIntoConstraints = false // Désactiver les contraintes automatiques ici
         btn.addTarget(self, action: #selector(subscribeBtnAction), for: .touchUpInside)
         return btn
     }()
     
    var action : ( ) -> ()
    
    init(action: @escaping ( ) -> ( )) {
        self.action = action
        super.init(frame: .zero)
        setup()
    }
    
    required init? (coder: NSCoder) {
        fatalError("fatal coder: has been not initalized")
    }
    
    // creation d une fonction pour update les modifications
    func set(name:String, email:String){
        nameLbl.text = name
        emailLbl.text = email
    }
}

private extension PeopleView {
    
    func setup( ) {
        self.addSubview(PeopleStackView)
        self.layer.cornerRadius = 20
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // Ajouter les sous-vues à la stack view
        PeopleStackView.addArrangedSubview(nameLbl)
        PeopleStackView.addArrangedSubview(emailLbl)
        PeopleStackView.addArrangedSubview(subscribersBtn)
        
        // Définir les contraintes
        NSLayoutConstraint.activate([
        PeopleStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
        PeopleStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
        PeopleStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
        PeopleStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func subscribeBtnAction(sender: UIButton) {
        action( )
    }
}


