//
//  EditMovieTableViewController.swift
//  MovieHistory
//
//  Created by Hironobu Makado on 2017/05/26.
//  Copyright © 2017年 stash4. All rights reserved.
//

import UIKit
import CoreData

class EditMovieTableViewController: UITableViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    // MARK: - Properties
    
    @IBOutlet var editMovieTableView: UITableView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var yearTextField: NumberTextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var noteTextView: PlaceholderTextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var movie:Movie!
    
    // MARL: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editMovieTableView.dataSource = self
        editMovieTableView.delegate = self
        
        // Handle the text field’s user input through delegate callbacks.
        titleTextField.delegate = self
        self.yearTextField.delegate = self
        
        // Enable the Save button only if the text field has a valid name.
        updateSaveButtonState()
        
        // Set Placeholder to noteTextView.
        noteTextView.placeHolder = "Note"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    */
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - UITextField Delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        saveButton.isEnabled = false
        
        if let tf = textField as? NumberTextField {
            tf.beginEditing()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let tf = textField as? NumberTextField {
            return tf.shouldChange(range: range, string: string)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        updateSaveButtonState()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            return
        }
        
        if titleTextField.text == "" {
            return
        }
        
        saveMovie()
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    /*
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
        let title = titleTextField.text
        if title == "" {
            return
        }
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let movie = Movie(context: context)
        
        movie.title = title
        movie.year = Int16(yearTextField.text!)!
        movie.note = noteTextView.text
        
        // Save created movie data.
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        dismiss(animated: true, completion: nil)
    }
 */

    // MARK: - Core Data
    
    private func saveMovie(){
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        movie = Movie(context: context)
        
        movie.title = title
        movie.year = Int16(yearTextField.text!)!
        movie.note = noteTextView.text
        
        // Save created movie data.
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    // MARK: - Private Methods
    
    private func updateSaveButtonState() {
        
        // Disable the Save button if the title text field is empty.
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}
