//
//  Athlete.swift
//  FavoriteAthlete
//
//  Created by Gwen Thelin on 11/19/24.
//

import Foundation

struct Athlete {
	var name: String
	var age: Int
	var league: String
	var team: String
	
	var desctiption: String {
		return "\(name) is \(age) years old and plays for the \(team) in the \(league)"
	}
}
