//
//  PeopleCollectionViewCell.swift
//  iosStory
//
//  Created by marcephrem on 17/09/2024.
//

import UIKit

// creer un protocole delegate pour les subscribe
protocol PeopleCollectionViewCellDelegate: AnyObject  {
    func didTapSubscribe (  )
}


class PeopleCollectionViewCell: UICollectionViewCell {
    
    private var vw : PeopleView?
    
    weak var delegate: PeopleCollectionViewCellDelegate?
    // pour la mise a jour des modifications des informations
    var item : PersonResponse? {
        didSet{
            
            // mise en forme des valeur pour la distribution
            guard let firstName = item?.firstName,
                 let lastName = item?.lastName,
                    let email = item?.email
            else {
                return
            }
            vw?.set(name: "\(firstName) \(lastName)", email: email)
                    
        }
    }
    override init (frame: CGRect){
        super.init(frame: frame)
        setup()
    }
    
    required init? (coder: NSCoder){
        fatalError("fatal error coder: has not been initialized")
    }
    
    
}
private extension PeopleCollectionViewCell {
    func setup ( ) {
        guard vw == nil else { return}
        
        // pour les subscribe
        vw = PeopleView { [weak self] in
            self?.delegate?.didTapSubscribe()
        }
        vw = PeopleView(action: {
            
        })
        
        self.contentView.addSubview(vw!)
        
        NSLayoutConstraint.activate([
            vw!.topAnchor.constraint(equalTo:contentView.topAnchor),
            vw!.bottomAnchor.constraint(equalTo:contentView.bottomAnchor),
            vw!.trailingAnchor .constraint(equalTo:contentView.trailingAnchor),
            vw!.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
} 

