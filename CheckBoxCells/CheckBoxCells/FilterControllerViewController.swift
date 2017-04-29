//
//  FilterControllerViewController.swift
//  CheckBoxCells
//
//  Created by DonMag on 4/29/17.
//  Copyright © 2017 DonMag. All rights reserved.
//

import UIKit

class FilterControllerViewController: UIViewController {
	
	@IBOutlet weak var filterTable: UITableView!
	
	let ControllerData = ["Menu Line A", "Menu Line B", "Menu Line C"]
	
	// this will be our "Tracking Array" - holds the current checked / unchecked "state" of each row
	var selectedButtonIndex: [Bool] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// initialize our data and tableView by calling our "cancel selections" function
		cancelDataItemSelected(nil)
	}
	
	@IBAction func cancelDataItemSelected(_ sender: Any?) {
		
		// reset our "Tracking Array" to all false
		selectedButtonIndex = Array(repeating: false, count: ControllerData.count)
		
		// reload the table
		filterTable.reloadData()
		
	}
	
}

extension FilterControllerViewController: UITableViewDataSource, UITableViewDelegate
{
	// NUMBER OF ROWS IN SECTION
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
		return ControllerData.count
	}
	
	// CELL FOR ROW IN INDEX PATH
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let filterCell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath) as! ControllerCellTableViewCell
		
		// set the label in filterCell
		filterCell.filterTableMenu.text = ControllerData[indexPath.item]
		
		// set current state of checkbox, using Bool value from out "Tracking Array"
		filterCell.isChecked = self.selectedButtonIndex[indexPath.row]
		
		// set a "Callback Closure" in filterCell
		filterCell.radioButtonTapAction = {
			(checked) in
			// set the slot in our "Tracking Array" to the new state of the checkbox button in filterCell
			self.selectedButtonIndex[indexPath.row] = checked
		}
		
		return filterCell
		
	}
}

class ControllerCellTableViewCell: UITableViewCell {
	
	@IBOutlet weak var filterTableMenu: UILabel!
	@IBOutlet weak var tableRadioButton: UIButton!
	
	var radioButtonTapAction : ((Bool)->Void)?
	
	// CHECKED RADIO BUTTON IMAGE
	let checkedImage = (UIImage(named: "CheckButton")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))! as UIImage
	
	// UNCHECKED RADIO BUTTON IMAGE
	let uncheckedImage = (UIImage(named: "CheckButton__Deselect")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))! as UIImage
	
	// Bool STORED property
	// set the corresponding checked / unchecked image for the button
	var isChecked: Bool = false {
		didSet{
			tableRadioButton.setImage(isChecked ? checkedImage : uncheckedImage, for: UIControlState.normal)
		}
	}
	
	// FILTER CONTROLLER RADIO BUTTON ACTION
	@IBAction func RadioButtonTapped(_ sender: Any) {
		isChecked = !isChecked
		radioButtonTapAction?(isChecked)
	}
	
}
