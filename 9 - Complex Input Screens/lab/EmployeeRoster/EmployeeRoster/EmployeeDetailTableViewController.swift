
import UIKit

protocol EmployeeDetailTableViewControllerDelegate: AnyObject {
    func employeeDetailTableViewController(_ controller: EmployeeDetailTableViewController, didSave employee: Employee)
}

class EmployeeDetailTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var dobLabel: UILabel!
    @IBOutlet var employeeTypeLabel: UILabel!
    @IBOutlet var saveBarButtonItem: UIBarButtonItem!
	@IBOutlet weak var birthdayDatePicker: UIDatePicker!
	
	var employeeType: EmployeeType?
	
    weak var delegate: EmployeeDetailTableViewControllerDelegate?
    var employee: Employee?
	
	var isEditingBirthday: Bool = false {
		didSet {
			tableView.beginUpdates()
			tableView.endUpdates()
		}
	}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
        updateSaveButtonState()
    }
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath == IndexPath(indexes: [0, 2]) && !isEditingBirthday {
			return 0
		} else {
			return UITableView.automaticDimension
		}
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		if indexPath == IndexPath(indexes: [0, 1]) {
			isEditingBirthday.toggle()
		}
	}
    
    func updateView() {
        if let employee = employee {
            navigationItem.title = employee.name
            nameTextField.text = employee.name
            
            dobLabel.text = employee.dateOfBirth.formatted(date: .abbreviated, time: .omitted)
            dobLabel.textColor = .label
            employeeTypeLabel.text = employee.employeeType.description
            employeeTypeLabel.textColor = .label
        } else {
            navigationItem.title = "New Employee"
        }
    }
    
    private func updateSaveButtonState() {
		let shouldEnableSaveButton = nameTextField.text?.isEmpty == false &&
		employeeTypeLabel.textColor == .systemBlue
		
        saveBarButtonItem.isEnabled = shouldEnableSaveButton
		
		
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text else {
            return
        }
        
		let employee = Employee(name: name, dateOfBirth: birthdayDatePicker.date, employeeType: .exempt)
        delegate?.employeeDetailTableViewController(self, didSave: employee)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        employee = nil
    }
	
	@IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
		dobLabel.text = sender.date.formatted(date: .abbreviated, time: .omitted)
		dobLabel.textColor = .label
	}
	
    @IBAction func nameTextFieldDidChange(_ sender: UITextField) {
        updateSaveButtonState()
    }
	
	@IBSegueAction func showEmployeeType(_ coder: NSCoder, sender: Any?) -> EmployeeTypeTableViewController? {
		let employeeTypeTableViewController = EmployeeTypeTableViewController(coder: coder)
		employeeTypeTableViewController!.delegate = self
		return employeeTypeTableViewController
	}
	

}

extension EmployeeDetailTableViewController: EmployeeTypeTableViewControllerDelegate {
	func employeeTypeTableViewController(_ controller: EmployeeTypeTableViewController, didSelect employeeType: EmployeeType) {
		self.employeeType = employeeType
		self.employeeTypeLabel.text = self.employeeType?.description
		self.employeeTypeLabel.textColor = .systemBlue
	}
}
