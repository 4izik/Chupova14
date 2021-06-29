

import UIKit
import RealmSwift


class RikAndMortyViewController: UIViewController {
    var heroes:[Hero] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
     override func viewDidLoad() {
         super.viewDidLoad()
        let allHeroes=SaveHeroRealm.sharedHero.allHeroesRealm()
        if allHeroes != 0
        {
            self.loadHeroRealm()
            
        }
        else {
            HeroesLoader().loadHeroes { heroes in
                 self.heroes=heroes
                for object in heroes {
                    SaveHeroRealm.sharedHero.addHeroRealm(hero: object)
                }
                self.tableView.reloadData()
                     }
        }
        tableView.tableFooterView=UIView()
     
     }
     override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
       
     }
    func loadHeroRealm() {
        let realm=try! Realm()
        var heroes=[Hero]()
        for character in realm.objects(Hero.self)
        {
            heroes.append(character)
        }
        self.heroes=heroes
    }

 }

 extension RikAndMortyViewController: UITableViewDataSource, UITableViewDelegate {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
     }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell=tableView.dequeueReusableCell(withIdentifier: "HeroCell") as! HeroTableViewCell
         let character=heroes[indexPath.row]
         cell.setup(with: character)
         return cell
     }

    
}
