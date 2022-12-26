//
//  ViewController.swift
//  introduction
//
//  Created by Daize Njounkeng on 12/20/22.
//

import UIKit
import DropDown
class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var numberOfPetsLabel: UILabel!
    @IBOutlet weak var morePetsStepper: UIStepper!
    @IBOutlet weak var morePetsSwitch: UISwitch!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var introduceYourself: UIButton!
    @IBOutlet weak var yearSegmentedControl: UISegmentedControl!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var schoolNameTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var majorButton: UIButton!
    @IBOutlet weak var majorDropDownField: UITextField!
    @IBOutlet weak var majorTitle: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    
    let defaults = UserDefaults.standard
    let dropDown = DropDown()
    
    struct keys {
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let gender = "gender"
        static let school = "school"
        static let year  = "year"
        static let major = "major"
        static let pets = "pets"
        static let morepets = "morepets"
    }
   
    // Displays drop down options
    @IBAction func showMajorOptions(_ sender: UIButton) {
        dropDown.show()
    }
    
    @IBAction func stepperDidChange(_ sender: UIStepper) {
        numberOfPetsLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction func introduceSelfDidTapped(_ sender: UIButton) {
         
         // Let's us chose the title we have selected from the segmented control
         let year = yearSegmentedControl.titleForSegment(at: yearSegmentedControl.selectedSegmentIndex)
         
         // Introduction template
        let introduction = "Hello! I am \(firstNameTextField.text!) \(lastNameTextField.text!), and I identify as a \(genderTextField.text!). I attend \(schoolNameTextField.text!). I am currently in my \(year!.lowercased()) year, majoring in \(majorTitle.text!). I own \(numberOfPetsLabel.text!) dogs. It is \(morePetsSwitch.isOn) that I want more pets."
        
        // Create an alert with above introduction
        let alertController = UIAlertController(title: "My Introduction", message: introduction, preferredStyle: .alert)
    
        // A way to dismiss the box once it pops up
        let action = UIAlertAction(title: "Enchanté", style: .default, handler: nil)
              
        // Passing this action to the alert controller so it can be dismissed
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
     }
    
    //Remove keyboard once return is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case firstNameTextField:
            lastNameTextField.becomeFirstResponder()
        case lastNameTextField:
            genderTextField.becomeFirstResponder()
        case genderTextField:
            schoolNameTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
    
    // Save entered information when save button is clicked.
    @IBAction func saveButton(_ sender: Any) {
        saveUserInfo()
    }
    
    
    //Save entered information
    func saveUserInfo(){
        defaults.set(firstNameTextField.text, forKey: keys.firstName)
        defaults.set(lastNameTextField.text, forKey: keys.lastName)
        defaults.set(genderTextField.text, forKey: keys.gender)
        defaults.set(schoolNameTextField.text, forKey: keys.school)
        defaults.set(yearSegmentedControl.selectedSegmentIndex, forKey: keys.year)
        defaults.set(majorTitle.text, forKey: keys.major)
        defaults.set(numberOfPetsLabel.text, forKey: keys.pets)
        defaults.set(morePetsSwitch.isOn, forKey: keys.morepets)
    }
    
    
    //Load existing user information.
    func checkUserInfo(){
        let firstName = defaults.value(forKey: keys.firstName) as? String ?? ""
        let lastName = defaults.value(forKey: keys.lastName) as? String ?? ""
        let gender = defaults.value(forKey: keys.gender) as? String ?? ""
        let school = defaults.value(forKey: keys.school) as? String ?? ""
        let year = defaults.value(forKey: keys.year) as? Int ?? 0
        let major = defaults.value(forKey: keys.major) as? String ?? ""
        let pets = defaults.value(forKey: keys.pets) as? String ?? "0"
        let morepets = defaults.value(forKey: keys.morepets) as? Bool ?? false
        
        firstNameTextField.text = firstName
        lastNameTextField.text = lastName
        genderTextField.text = gender
        schoolNameTextField.text = school
        yearSegmentedControl.selectedSegmentIndex = year
        majorTitle.text = major
        majorTitle.alpha = 1
        numberOfPetsLabel.text = pets
        morePetsSwitch.isOn = morepets
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        majorTitle.text = "Select Major" //Load dropdown options
        dropDown.anchorView = majorDropDownField
        let majorArray = ["Business", "Computer Science", "Engineering", "Nursing", "Mathematics", "Chemistry"]
        dropDown.dataSource = majorArray
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.majorTitle.text = majorArray[index]
            majorTitle.alpha = 1
        }
        firstNameTextField.delegate = self //set delegate to textfile
        lastNameTextField.delegate = self //set delegate to textfile
        genderTextField.delegate = self  //set delegate to textfile
        schoolNameTextField.delegate = self  //set delegate to textfile
        checkUserInfo() //Check if user data already exists and load

    }
    

}

