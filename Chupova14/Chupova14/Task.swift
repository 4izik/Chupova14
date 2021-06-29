
import Foundation
import RealmSwift

class Task:Object {
    @objc dynamic var textTask=""
}
class SaveTask {
    static let shared = SaveTask()
    private let realm = try! Realm()
    func addTaskRealm(text:String) {
        let task=Task()
        task.textTask=text
        try! realm.write{
            realm.add(task)
        }
    }
    
    func deleteTaskRealm(text:String) {
        for objects in realm.objects(Task.self)
        {
            if objects.textTask==text
            {
                try! realm.write{
                    realm.delete(objects)
                }
            }
        }
        
    }
}
