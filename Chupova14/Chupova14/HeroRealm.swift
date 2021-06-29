import Foundation
import RealmSwift

class HeroRealm:Object {
    @objc dynamic var imageURL=""
    @objc dynamic var name=""
    @objc dynamic var status=""
    @objc dynamic var location=""
}
class SaveHeroRealm {
    static let sharedHero = SaveHeroRealm()
    private let realm = try! Realm()
    func addHeroRealm(hero:Hero) {
        let character=HeroRealm()
        character.imageURL=hero.image
        character.name=hero.name
        character.status=hero.status + "-" + hero.species
        character.location=hero.location.name
        try! realm.write{
            realm.add(character)
        }
    }
    
    func deleteHeroRealm(hero:Hero) {
        for objects in realm.objects(HeroRealm.self)
        {
            if objects.name==hero.name
            {
                try! realm.write{
                    realm.delete(objects)
                }
            }
        }
        
    }
}


