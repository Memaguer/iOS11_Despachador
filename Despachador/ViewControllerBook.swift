//
//  ViewControllerBook.swift
//  Despachador
//
//  Created by MBG on 11/1/17.
//  Copyright © 2017 MBG. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewControllerBook: UIViewController, UISearchBarDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    var notes: [Note] = []
    
    var filteredData: [Note] = []
    var isSearching = false
    
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        var note = Note(title: "Sale camión de base", date:"2/11/2017", category: "Unidad", detail:"El camión FRE-432 salió a las 2:34. El camíon lo manejaba Armando Contreras. Estuvo detenido 5 minutos en la base.")
        notes.append(note)
        note = Note(title: "Camión con choque", date:"2/11/2017", category: "Unidad", detail:"El camión ZBT-646 chocó en Tlalpan y Xola. No hubo heridos pero la unidad necesita ser transportada al despacho más cercano. El condutor de la unidad es Rafael Figueroa")
        notes.append(note)
        note = Note(title: "Capacidad llena", date:"2/11/2017", category: "Unidad", detail:"EL camión se encuentra en su capacidad máxima. Aviso desde el desapcho General Anaya.")
        notes.append(note)
        note = Note(title: "5 personas esperando en base", date:"2/11/2017", category: "Pasajeros", detail:"No han apasado unidades hace 15 min. Hay personas esperaando en al despacho del Estadio Azteca")
        notes.append(note)
        note = Note(title: "Cambio de turno", date:"2/11/2017", category: "Despachador", detail:"Cambio de turno en el depacho. Jonathan Lozano sale a las 4:32 y entra por su parte Luis Martínes")
        notes.append(note)
        
        self.searchBar.delegate = self
        self.searchBar.placeholder = "Buscar en bitácora"
        
        tableSettings()
        
        getBusesFromFirebase()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableSettings() {
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.filteredData = self.notes.filter({ (note) -> Bool in
            if note.title.lowercased().contains(self.searchBar.text!.lowercased()){
                return true
            }else{
                return false
            }
        })
        if(filteredData.count == 0){
            isSearching = false;
        } else {
            isSearching = true;
        }
        self.tableView.reloadData()
    }
    
    func getBusesFromFirebase(){
        ref = Database.database().reference()
        databaseHandle = ref?.child("notes").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject]{
                print(dictionary)
                print(dictionary.count)
                let title = dictionary["title"] as? String
                let date = dictionary["date"] as? String
                let detail = dictionary["detail"] as? String
                let category = dictionary["category"] as? String
                let note = Note(title: title!, date: date!, category: category!, detail: detail!)
                self.notes.append(note)
            }
        })
    }

}

extension ViewControllerBook : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            return filteredData.count
        }
        
        return self.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "NoteCell"
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCellNote
        
        let note: Note
        
        if isSearching {
            note = filteredData[indexPath.row]
            cell.title.text = note.title
            cell.date.text = note.date
            cell.imageNote.image = note.image
            
            return cell
        } else {
            note = notes[indexPath.row]
            cell.title.text = note.title
            cell.date.text = note.date
            cell.imageNote.image = note.image
            
            return cell
        }
    }
    
    /*func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        //Compartir
        let shareAction = UITableViewRowAction(style: .normal, title: "compartir") { (action, indexPath) in
            let shareMessage = "\(self.notes[indexPath.row])"
            let shareController = UIActivityViewController(activityItems: [shareMessage], applicationActivities: nil)
            self.present(shareController, animated: true, completion: nil)
        }
        shareAction.backgroundColor = UIColor.orange
        
        //Eliminar
        
        let deleteAction = UITableViewRowAction(style: .default, title: "eliminar") { (action, indexPath) in
            self.notes.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        return [shareAction, deleteAction]
    }*/
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            self.notes.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            /*let shareMessage = "\(self.notes[indexPath.row])"
            let shareController = UIActivityViewController(activityItems: [shareMessage], applicationActivities: nil)
            self.present(shareController, animated: true, completion: nil)*/
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNoteDetail"{
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let selectedNote = self.notes[indexPath.row]
                let newViewControllerD = segue.destination as! ViewControllerNoteDetail
                newViewControllerD.note = selectedNote
            }
        }
    }
    
    
    
}
