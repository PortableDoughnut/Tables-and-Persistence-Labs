//
//  BookFormTableViewController.swift
//  FavoriteBooks
//
//  Created by Gwen Thelin on 10/24/24.
//

import UIKit

class BookFormTableViewController: UITableViewController {
	@IBOutlet weak var lengthTextField: UITextField!
	@IBOutlet weak var genreTextField: UITextField!
	@IBOutlet weak var titleTextField: UITextField!
	@IBOutlet weak var authorTextField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false
		
		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		// self.navigationItem.rightBarButtonItem = self.editButtonItem
	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 0
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return 0
	}
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
		
		// Configure the cell...
		
		return cell
	}
	
	@IBAction func saveButtonPressed(_ sender: UIButton) {
		
	}
}
