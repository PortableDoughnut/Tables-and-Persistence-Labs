import UIKit

class AthleteTableViewController: UITableViewController {
    
    struct PropertyKeys {
        static let athleteCell = "AthleteCell"
    }

    var athletes: [Athlete] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return athletes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.athleteCell, for: indexPath)
        
        let athlete = athletes[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = athlete.name
        content.secondaryText = athlete.description
        cell.contentConfiguration = content
        
        return cell
    }
	
	@IBSegueAction func addAthlete(_ coder: NSCoder, sender: Any?) -> AthleteFormViewController? {
		guard let athleteForm: AthleteFormViewController = .init(coder: coder, athlete: nil)
		else { return nil }
		
		return athleteForm
	}
	
	@IBSegueAction func editAthlete(_ coder: NSCoder, sender: Any?) -> AthleteFormViewController? {
		guard let senderCell = sender as? UITableViewCell,
			  let indexPath = tableView.indexPath(for: senderCell),
			  let athleteForm: AthleteFormViewController = .init(coder: coder, athlete: athletes[indexPath.row])
		else { return nil }
		
		return athleteForm
	}
	
	@IBAction func unwindToHome(_ segue: UIStoryboardSegue) {
		guard let sourceViewController = segue.source as? AthleteFormViewController else { return }
		
		if let indexPath = tableView.indexPathForSelectedRow {
			athletes[indexPath.row] = sourceViewController.athlete!
			tableView.reloadRows(at: [indexPath], with: .none)
		} else {
			athletes.append(sourceViewController.athlete!)
			tableView.reloadData()
		}
	}
	
}
