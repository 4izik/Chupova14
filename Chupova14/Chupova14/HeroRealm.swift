import Foundation
import RealmSwift

class SaveHeroRealm {
    static let sharedHero = SaveHeroRealm()
    private let realm = try! Realm()
    func addHeroRealm(hero:Hero) {
        let character=Hero()
        character.image=hero.image
        character.name=hero.name
        character.status=hero.status + "-" + hero.species
        character.location=hero.location
        try! realm.write{
            realm.add(character)
        }
    }
    
    func deleteHeroRealm(hero:Hero) {
        for objects in realm.objects(Hero.self)
        {
            if objects.name==hero.name
            {
                try! realm.write{
                    realm.delete(objects)
                }
            }
        }
        
    }
    func allHeroesRealm() -> Int {
        return realm.objects(Hero.self).count
    }
}


