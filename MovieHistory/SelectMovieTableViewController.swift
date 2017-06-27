//
//  SelectMovieTableViewController.swift
//  MovieHistory
//
//  Created by Hironobu Makado on 2017/05/22.
//  Copyright © 2017年 stash4. All rights reserved.
//

import UIKit
import CoreData

class SelectMovieTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    // MARK: - Properties
    
    @IBOutlet var movieTableView: UITableView!
    var movies = [Movie]()
    var movie: Movie!
    var checkMarks = [Bool]()

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        movieTableView.delegate = self
        movieTableView.dataSource = self
        
        navigationController?.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        loadMovies()
        
        checkMarks.removeAll()
        for _ in 0..<movies.count {
            checkMarks.append(false)
        }
        
        movieTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "MovieTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieTableViewCell else {
            fatalError("The dequeued cell is not an instance of HistoryTableViewCell")
        }
        
        // Fetches the appropriate movie for the data source layout.
        let movie = movies[indexPath.row]
        
        // Configure the cell...
        cell.movieTitleLabel.text = movie.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Add checkmark to selected cell.
        if let cell = tableView.cellForRow(at: indexPath) as? MovieTableViewCell {
            if cell.accessoryType == .none {
                cell.accessoryType = .checkmark
                //cell.movieTitleLabel.font = UIFont.boldSystemFont(ofSize: <#T##CGFloat#>)
                //cell.movieTitleLabel.textColor = UIColor.blue
                
                checkMarks = checkMarks.enumerated().flatMap {(elem: (Int, Bool)) -> Bool in
                    if indexPath.row != elem.0 {
                        let otherCellIndexPath = NSIndexPath(row: elem.0, section: 0)
                        if let otherCell = tableView.cellForRow(at: otherCellIndexPath as IndexPath) {
                            otherCell.accessoryType = .none
                            //cell.movieTitleLabel.font = UIFont.boldSystemFont(ofSize: <#T##CGFloat#>)
                            //cell.movieTitleLabel.textColor = UIColor.black
                        }
                    }
                    return indexPath.row == elem.0
                }
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        if let controller = viewController as? EditHistoryTableViewController{
            // checkmarks
            for (i, movie) in movies.enumerated() {
                if checkMarks[i] {
                    controller.movie = movie
                    return
                }
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func unwindToSelectMovieTableView(sender: UIStoryboardSegue) {
        
        //if let sourceViewController = sender.source as? SelectMovieTableViewController, movie = sourceViewController.movie
    }
    
    // MARK:  - CoreData
    
    private func loadMovies() {
        
        // Get an instance of AppDelegate class.
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        do {
            let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
            movies = try context.fetch(fetchRequest)
        } catch {
            print("")
        }
    }


}
