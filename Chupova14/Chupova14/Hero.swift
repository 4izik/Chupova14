
import Foundation
import RealmSwift
import Realm
@objcMembers class Hero: Object, Decodable {
    @objc dynamic var imageURL=""
    @objc dynamic var name=""
    @objc dynamic var status=""
    let locations = RealmSwift.List<Location>()
    enum CodingKeys: String, CodingKey {
            case name = "name"
            case status = "status"
            case image = "image"
            case location = "location"
        }
    required init(from decoder: Decoder) throws
        {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            imageURL = try container.decode(String.self, forKey: .image)
            name = try container.decode(String.self, forKey: .name)
            let location = try container.decode([Location].self, forKey: .location)
            locations.append(objectsIn: location)
            super.init()
        }
    override static func primaryKey() -> String?
        {
            return "name"
        }
    required init()
       {
           super.init()
       }
       
       required init(value: Any, schema: RLMSchema)
       {
           super.init(value: value, schema: schema)
       }
       
       required init(realm: RLMRealm, schema: RLMObjectSchema)
       {
           super.init(realm: realm, schema: schema)
       }
}
@objcMembers class Location:Object, Decodable {
    @objc dynamic var name=""
    @objc dynamic var url=""
    enum CodingKeys: String, CodingKey {
            case name = "name"
            case url = "url"
        }
    required init(from decoder: Decoder) throws
        {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            name = try container.decode(String.self, forKey: .name)
            url = try container.decode(String.self, forKey: .url)
            super.init()
        }
    override static func primaryKey() -> String?
        {
            return "name"
        }
    required init()
       {
           super.init()
       }
       
       required init(value: Any, schema: RLMSchema)
       {
           super.init(value: value, schema: schema)
       }
       
       required init(realm: RLMRealm, schema: RLMObjectSchema)
       {
           super.init(realm: realm, schema: schema)
       }
}
class Origin:Codable{
    let name:String
    let url:String
}
struct CustomDecodeError: Codable {

    let detail: String?

    

    init(description: String?) {

        detail = description

    }

}
