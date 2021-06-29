
import Foundation

import Foundation

class Hero:Codable {
    let name: String
    let status: String
    let species:String
    let image: String
    let id: Int
    let type:String
    let gender:String
    let episode:[String]
    let url:String
    let location:Location
    let origin:Origin
    let created:String

}
class Location:Codable {
    let name:String
    let url:String
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
