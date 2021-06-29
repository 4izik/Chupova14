
import Foundation
import RealmSwift
import Realm
@objcMembers class Hero: Object, Codable {
    @objc dynamic var image=""
    @objc dynamic var name=""
    @objc dynamic var status=""
    @objc dynamic var species=""
    @objc dynamic var location:Location?
    enum CodingKeys: String, CodingKey {
            case name = "name"
            case status = "status"
            case species="species"
            case image = "image"
            case location = "location"
        }
}
@objcMembers class Location:Object, Codable {
    @objc dynamic var name=""
    @objc dynamic var url=""
    enum CodingKeys: String, CodingKey {
            case name = "name"
            case url = "url"
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
