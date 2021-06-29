
import Foundation
 
class NameSurname {
    static let shared = NameSurname()
    
    private let kUserNameKey="NameSurname.kUserNameKey"
    private let kUserSurnameKey="NameSurname.kUserSurnameKey"
    var userName:String? {
        set {UserDefaults.standard.set(newValue, forKey: kUserNameKey)}
        get {return UserDefaults.standard.string(forKey: kUserNameKey)}
    }
    var userSurname:String? {
        set {UserDefaults.standard.set(newValue, forKey: kUserSurnameKey)}
        get {return UserDefaults.standard.string(forKey: kUserSurnameKey)}
    }
}
