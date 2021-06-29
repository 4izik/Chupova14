

import UIKit
import CoreData
class ToDoCoreDataViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var coreDataTableView: UITableView!
    @IBOutlet weak var newTaskCoreDataTextField: UITextField!
    var tasksCoreData=[TaskCoreData]()
    static let persistentContainer: NSPersistentContainer = {
          let container = NSPersistentContainer(name: "Chupova14")
          container.loadPersistentStores(completionHandler: { (storeDescription, error) in
              if let error = error as NSError? {
                  fatalError("Unresolved error \(error), \(error.userInfo)")
              }
          })
          return container
      }()
    var context:  NSManagedObjectContext = {
        return persistentContainer.viewContext

    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTaskCoreData()
        newTaskCoreDataTextField.delegate=self
        coreDataTableView.tableFooterView=UIView()
    }
    
    //добавление задачи по нажатию на кнопку
    @IBAction func addTaskCoreData(_ sender: Any) {
        let newTask=TaskCoreData(context: context)
        newTask.text=newTaskCoreDataTextField.text
        if newTask.text != "" {
        tasksCoreData.append(newTask)
        saveTaskCoreData(onetask: newTask)
        }
        newTaskCoreDataTextField.text=""
        coreDataTableView.reloadData()
    }
    //создание экземпляра ManagedObject
    func persistent() -> NSManagedObjectContext {
        return context
    }
    //сохранение контекста
    func saveContext(context:  NSManagedObjectContext) {
        if context.hasChanges {
                  do {
                      try context.save()
                  } catch {
                    context.rollback()
                      let nserror = error as NSError
                      fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                  }
              }

    }
    // сохраение задачи в БД
    func saveTaskCoreData (onetask: TaskCoreData) {
        let context=persistent()
        var task=TaskCoreData(context: context)
        task=onetask
        saveContext(context: context)
    }
    
    // загрузка задач из БД
    func loadTaskCoreData() {
        let context=persistent()
        let fetchRequest: NSFetchRequest<TaskCoreData> = TaskCoreData.fetchRequest()
        let objects = try! context.fetch(fetchRequest)
        for task in objects {
            tasksCoreData.append(task)
        }
    }
   
    //удаление задач из БД
    func deleteTaskCoreData(task:TaskCoreData){
        let context=persistent()
        let fetchRequest: NSFetchRequest<TaskCoreData> = TaskCoreData.fetchRequest()
        let objects = try! context.fetch(fetchRequest)
        for result in objects {
            if result==task
            {
                context.delete(result)
            }
        }
        saveContext(context: context)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


extension UITableView {
    func setEmptyMessageCoreData(_ message: String) {
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

    func restoreCoreData() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
extension ToDoCoreDataViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "CellCoreData") as! ToDoCoreDataTableViewCell
        cell.taskLabel.text=tasksCoreData[indexPath.row].text
        return cell
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tasksCoreData.count==0 {
            self.coreDataTableView.setEmptyMessageCoreData("Пока нет задач")
        }
        else {
            self.coreDataTableView.restoreCoreData()
        }
        return tasksCoreData.count
    }
    
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
    if editingStyle == .delete {
        deleteTaskCoreData(task: tasksCoreData[indexPath.row])
            self.tasksCoreData.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
    
 
}
