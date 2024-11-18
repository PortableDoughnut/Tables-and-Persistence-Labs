import UIKit

class BookTableViewController: UITableViewController {
	
	var books: [Book] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		tableView.reloadData()
	}
	
	// MARK: - Table view data source
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return books.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookTableViewCell
		
		let book = books[indexPath.row]
		//        var content = cell.defaultContentConfiguration()
		//        content.text = book.title
		//        content.secondaryText = book.description
		//        cell.contentConfiguration = content
		cell.update(with: book)
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		
		
		guard editingStyle == .delete else {return}
		
		books.remove(at: indexPath.row)
		tableView.deleteRows(at: [indexPath], with: .fade)
	}
	
	// MARK: - Navigation
	
	@IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
		guard let source = segue.source as? BookFormTableViewController,
			  let book = source.book else {return}
		
		if source.isEditingBook,
		   let indexPath = source.toReturnIndexPath {
			books[indexPath.row] = book
			tableView.deselectRow(at: indexPath, animated: true)
			tableView.beginUpdates()
			tableView.endUpdates()
		} else {
			books.append(book)
		}
		tableView.reloadData()
	}
	
	@IBSegueAction func editBook(_ coder: NSCoder, sender: Any?) -> BookFormTableViewController? {
		
		guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {
			return nil
		}
		
		let book = books[indexPath.row]
		
		return BookFormTableViewController(coder: coder, book: book)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "EditBookSegue" {
			guard let destination = segue.destination as? BookFormTableViewController,
			let indexPath = tableView.indexPathForSelectedRow
			else {return}
			
			destination.book = books[indexPath.row]
			destination.toReturnIndexPath = indexPath
			destination.isEditingBook = true
			
		} else if segue.identifier == "AddBookSegue" {
			guard let destination = segue.destination as? BookFormTableViewController else {return}
			
			destination.isEditingBook = false
		}
	}
}
