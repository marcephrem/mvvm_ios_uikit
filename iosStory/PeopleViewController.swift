import UIKit
import SafariServices
// creation du peopleDelagate pour la communication
protocol PeopleViewModelDelegate: AnyObject {
    func didFinish( )
    func didFail(error:Error)
}

class PeopleViewController: UIViewController {
    
    // creation d une instane pour capturer le nombre item a partir de la vue
    private let vm = PeopleViewModel()
    
    // creer une collection vue
    private lazy var cv : UICollectionView = {
        
        // creation d un layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: UIScreen.main.bounds.width, height: 130)
        
        
        // creation du collection view
        let vw = UICollectionView(frame: .zero , collectionViewLayout: layout)
        vw.register(PeopleCollectionViewCell.self, forCellWithReuseIdentifier: "PeopleCollectionViewCell")
        vw.dataSource = self
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        // creation du dataSourceKit
        return vw
    }( )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        vm.delegate = self
        vm.GetUser()

    }
    

}

// creer une extension pour peopleViewController
extension PeopleViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        vm.people.count
    }
    
    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // pour la recuperation des valeurs
        let item = vm.people[indexPath.item]
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PeopleCollectionViewCell", for: indexPath) as! PeopleCollectionViewCell
        
        // pour le subscribe
        cell.delegate = self
        // utilisation du cell de telle sorte a pouvoir attribuer les valeurs au cell
        cell.item = item
      
        return cell
    }
}

// extension for vieWdelegate
extension PeopleViewController: PeopleViewModelDelegate{
    func didFinish() {
        cv.reloadData()
    }
    func didFail(error: any Error) {
        print("ERROR")
    }
}

private extension PeopleViewController {
    func setup( ) {
        
        
        
        self.view.backgroundColor = .white
        self.view.addSubview(cv)
        
        
        // changer le titre de la vue
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "People"
        
        
        
        NSLayoutConstraint.activate([
            self.cv.topAnchor.constraint(equalTo: view.topAnchor),
            self.cv.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.cv.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.cv.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension PeopleViewController: PeopleCollectionViewCellDelegate {
    func didTapSubscribe() {
        // pour le subscribe
        let url = URL(string: "https://ndaya.com")!
        let vc = SFSafariViewController(url: url)
        
        // pour que le resultat s affiche comme un bottombar
        vc.modalPresentationStyle = .formSheet
        self.present(vc, animated: true)
    }
}
