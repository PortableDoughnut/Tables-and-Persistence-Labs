//
//  AthleteFormViewController.swift
//  FavoriteAthlete
//
//  Created by Gwen Thelin on 11/19/24.
//

import UIKit

class AthleteFormViewController: UIViewController {
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var ageTextField: UITextField!
	@IBOutlet weak var leagueTextField: UITextField!
	@IBOutlet weak var teamTextField: UITextField!
	
	var athlete: Athlete?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		updateView()
    }
	
	init?(coder: NSCoder, athlete: Athlete?) {
		super.init(coder: coder)
		
		self.athlete = athlete
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func updateView() {
		guard let athlete else { return }
		
		nameTextField.text = athlete.name
		ageTextField.text = String(athlete.age)
		leagueTextField.text = athlete.league
		teamTextField.text = athlete.team
	}
	
	@IBAction func onSaveButtonPressed(_ sender: UIButton) {
		guard let name = nameTextField.text,
			  let ageString = ageTextField.text,
			  let age = Int(ageString),
			  let league = leagueTextField.text,
			  let team = teamTextField.text
		else { return }
		
		athlete = Athlete(name: name, age: age, league: league, team: team)
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
