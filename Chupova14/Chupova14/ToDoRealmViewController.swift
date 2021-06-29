import UIKit
import RealmSwift
class ToDoRealmViewController: UIViewController, UITextFieldDelegate {
    
    var deleteCell=0
    var tasks=[Task]()
    @IBOutlet weak var realmTableView: UITableView!
    
    @IBOutlet weak var newTaskTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTask()
        newTaskTextField.delegate=self
        realmTableView.tableFooterView=UIView()
    }
    @IBAction func addTask(_ sender: Any) {
        let clickTask=Task()
        tasks.append(clickTask)
        clickTask.textTask=newTaskTextField.text ?? ""
        SaveTask.shared.addTaskRealm(text: newTaskTextField.text ?? "")
        newTaskTextField.text=""
        realmTableView.reloadData()
    }
    
    func loadTask() {
        let realm=try! Realm()
        var tasks=[Task]()
        for task in realm.objects(Task.self)
        {
            tasks.append(task)
        }
        self.tasks=tasks
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
     
    
}
extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
extension ToDoRealmViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tasks.count==0 {
            self.realmTableView.setEmptyMessage("Пока нет задач")
        }
        else {
            self.realmTableView.restore()
        }
        return tasks.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "CellRealm") as! ToDoRealmTableViewCell
        if self.tasks.count>0 {
        let task=self.tasks[indexPath.row]
            cell.taskLabel.text=task.textTask }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        deleteCell=indexPath.row
        
    }
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
    if editingStyle == .delete {
        SaveTask.shared.deleteTaskRealm(text: tasks[indexPath.row].textTask)
            self.tasks.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
    
}
