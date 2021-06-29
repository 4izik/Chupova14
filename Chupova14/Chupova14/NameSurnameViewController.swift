
import UIKit

class NameSurnameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.text=NameSurname.shared.userName
        surnameTextField.text=NameSurname.shared.userSurname
        nameTextField.delegate=self
        surnameTextField.delegate=self
    }
    
    @IBAction func nameInput(_ sender: Any) {
        NameSurname.shared.userName=nameTextField.text
    }
    
    @IBAction func surnameInput(_ sender: Any) {
        NameSurname.shared.userSurname=surnameTextField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
