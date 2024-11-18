//
//  EmployeeTypeTableViewController.swift
//  EmployeeRoster
//
//  Created by Gwen Thelin on 11/18/24.
//

import UIKit

class EmployeeTypeTableViewController: UITableViewController {
	
	var employeeType: EmployeeType? {
		didSet {
			tableView.reloadData()
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
		1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		EmployeeType.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeTypeCell", for: indexPath)
		
		let type = EmployeeType.allCases[indexPath.row]
		var content = cell.defaultContentConfiguration()
		
		content.text = type.description
		cell.contentConfiguration = content
		
		if employeeType == type {
			cell.accessoryType = .checkmark
		} else {
			cell.accessoryType = .none
		}
		
        return cell
    }
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		employeeType = EmployeeType.allCases[indexPath.row]
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
