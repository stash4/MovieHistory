//
//  EditHistoryTableViewController.swift
//  MovieHistory
//
//  Created by Hironobu Makado on 2017/05/15.
//  Copyright © 2017年 stash4. All rights reserved.
//

import UIKit

class EditHistoryTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    @IBOutlet var addHistoryTableView: UITableView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateCell: UITableViewCell!
    @IBOutlet weak var timeCell: UITableViewCell!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var selectCell: UITableViewCell!
    @IBOutlet weak var noteTextView: PlaceholderTextView!
    
    var datePickerHidden = true
    var timePickerHidden = true
    var movie: Movie!
    var selectSwitch = UISwitch()
    var select = false
    
    var history: History!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        datePickerChanged()
        timePickerChanged()
        
        addHistoryTableView.dataSource = self
        addHistoryTableView.delegate = self
        
        // Enable the Save button only if the text field has a valid Movie.
        updateSaveButtonState()
        
        // Set Switch for selecting Theater.
        selectSwitch.setOn(select, animated: false)
        selectSwitch.addTarget(self, action: #selector(EditHistoryTableViewController.switchChanged), for: UIControlEvents.valueChanged)
        selectCell.accessoryView = selectSwitch
        
        // Set Placeholder to noteTextView.
        noteTextView.placeHolder = "Note"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addHistoryTableView.reloadData()
    }
    
    internal func switchChanged() {
        select = selectSwitch.isOn
        
        tableView.beginUpdates()
        tableView.endUpdates()
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0{
            toggleDatePicker()
            tableView.deselectRow(at: indexPath, animated: true)
        }
        if indexPath.section == 0 && indexPath.row == 2{
            toggleTimePicker()
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if ((datePickerHidden && indexPath.row == 1) || (timePickerHidden && indexPath.row == 3)) && indexPath.section == 0 {
            return 0
        }else if !select && indexPath.section == 2 && indexPath.row == 1 {
            return 0
        }else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
    }
    
    // MARK: - Actions

    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unwindToEditHistory(sender: UIStoryboardSegue) {
        /*
        if let sourceViewController = sender.source as? DatePickTableViewController, let date = sourceViewController.date {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            
            dateLabel.text = formatter.string(from: date)
        }
        */
    }
    
    @IBAction func datePickerValue(_ sender: Any) {
        datePickerChanged()
    }
    
    @IBAction func timePickerValue(_ sender: Any) {
        timePickerChanged()
    }
    
    // MARK: - Core Data
    
    private func saveHistory(){
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        history = History(context: context)
        
        // date
        let calender = Calendar(identifier: .gregorian)
        var d = calender.dateComponents([.year, .month, .day, .hour, .minute], from: datePicker.date)
        let t = calender.dateComponents([.hour, .minute], from: timePicker.date)
        d.hour = t.hour
        d.minute = t.minute
        let date = calender.date(from: d)
        
        history.date = date! as NSDate
        history.movie = movie
        history.theater = selectSwitch.isOn
        
        history.note = noteTextView.text
        
        // Save created history data.
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }

    // MARK: - Private Methods
    
    private func updateSaveButtonState() {
        // Disable the Save button if the  movie is nil.
        saveButton.isEnabled = movie != nil
    }
    
    private func datePickerChanged() {
        dateLabel.text = DateFormatter.localizedString(from: datePicker.date, dateStyle: .medium, timeStyle: .none)
    }
    
    private func timePickerChanged() {
        timeLabel.text = DateFormatter.localizedString(from: timePicker.date, dateStyle: .none, timeStyle: .short)
    }
    
    private func toggleDatePicker() {
        datePickerHidden = !datePickerHidden
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    private func toggleTimePicker() {
        timePickerHidden = !timePickerHidden
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }

}
