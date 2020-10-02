
import UIKit

let KEY_NOTES_LIST = "key_notes_list"

class EnterNoteViewController: UIViewController {

    @IBOutlet weak var noteTextField: UITextField!
    
    let defaults = UserDefaults.standard
    
    var latestSavedNotes: Array<String>? = nil

    var indexForEdit = 0
    var isForEdit = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        latestSavedNotes = defaults.stringArray(forKey: KEY_NOTES_LIST)
        if(latestSavedNotes == nil){
            latestSavedNotes = Array<String>()
        }
        
        if isForEdit {
            noteTextField.text = latestSavedNotes?[indexForEdit]
        }
        
    }

    @IBAction func onSaveNoteClick(_ sender: Any) {
        
        let note = noteTextField.text
        
        if (note?.isEmpty == true) {
          showEmptyAlert()
         return
        }
        
        if isForEdit {
            latestSavedNotes?[indexForEdit] = note ?? ""
        }else {
          latestSavedNotes?.append(note ?? "")
        }
        
        defaults.set(latestSavedNotes, forKey: KEY_NOTES_LIST)
        
        self.showSafeAlert()
    }
     
    private func showEmptyAlert(){
        let alert = UIAlertController(title: "Oops!", message: "Can't save empty note, plaese enter your note.", preferredStyle: UIAlertController.Style.actionSheet)

        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    private func showSafeAlert(){
        
        
        let defaultAction = UIAlertAction(title: "Ok",
                                          style: .default) { (action) in
         
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "DataViewController") as! ViewController
            self.present(vc, animated: false, completion: nil)
         }
         
         // Create and configure the alert controller.
         let alert = UIAlertController(title: "Well done!",
               message: "The note has been saved successfully.",
               preferredStyle: .alert)
         alert.addAction(defaultAction)
    
              
         self.present(alert, animated: true,completion: nil)
            
            // The alert was presented
 
        

}
    
}
extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
