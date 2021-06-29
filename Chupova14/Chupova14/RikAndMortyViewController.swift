

import UIKit
import RealmSwift


class RikAndMortyViewController: UIViewController {
    var heroes:[Hero] = []
     var numberOfCells:Int=10
    
    @IBOutlet weak var tableView: UITableView!
    
     override func viewDidLoad() {
         super.viewDidLoad()
        var allHeroes=SaveHeroRealm.sharedHero.allHeroesRealm()
        if allHeroes != 0
        {
            self.loadHeroRealm()
            
        }
        tableView.tableFooterView=UIView()
     
     }
  /*   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         let cell=sender as? HeroCell
         let index=tableView.indexPath(for: cell!)
         let vc=segue.destination as? CharacterViewController
         vc?.idVar=heroes[index!.row].id
         
     }*/
     override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
        HeroesLoader().loadHeroes { heroes in
             self.heroes=heroes
            for object in heroes {
                SaveHeroRealm.sharedHero.addHeroRealm(hero: object)
            }
            self.tableView.reloadData()
                 }
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
