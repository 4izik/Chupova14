
import Foundation
class CommonResult:Codable {
    let info:Info
    let results:[Hero]
}
class Info:Codable {
    let count:Int
    let pages:Int
    let next:String
    let prev:String?
}
