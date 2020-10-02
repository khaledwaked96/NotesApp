//
//  ViewController.swift
//  NoteApp
//
//  Created by macintosh on 10/1/20.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let defaults = UserDefaults.standard
    
    var latestSavedNotes: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
        latestSavedNotes = defaults.stringArray(forKey: KEY_NOTES_LIST) ?? Array<String>()
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        latestSavedNotes.count
    }
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteTableView
        
        cell.noteLabel?.text = latestSavedNotes[indexPath.row]
    
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
    let editButton = UITableViewRowAction(style: .normal, title: "Edit", handler: {rowAction, indixPath in
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "noteViewController") as! EnterNoteViewController
        
        newViewController.indexForEdit = indexPath.row
        newViewController.isForEdit = true
        
        self.present(newViewController, animated: true, completion: nil)
        
        print("Edit Button Clicked")
    })
        editButton.backgroundColor = .orange
        
        let deleteButton = UITableViewRowAction(style: .destructive, title: "Delete", handler: {rowAction, indixPath in
            
            print("Delete Button Clicked")
            
            self.latestSavedNotes.remove(at: indexPath.row)
            self.defaults.set(self.latestSavedNotes, forKey: KEY_NOTES_LIST)
            
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
        })
    
        deleteButton.backgroundColor = .red
     
        return [editButton, deleteButton]
    }

}

