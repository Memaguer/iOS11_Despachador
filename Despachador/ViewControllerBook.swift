//
//  ViewControllerBook.swift
//  Despachador
//
//  Created by MBG on 11/1/17.
//  Copyright © 2017 MBG. All rights reserved.
//

import UIKit
import CoreData

class ViewControllerBook: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    var notes: [Log] = []
    var filteredData: [Log] = []
    var isSearching = false
    var category: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableSettings()
        searchBarSettings()
        loadInfoFromCoraData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableSettings() {
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func searchBarSettings(){
        self.searchBar.delegate = self
        self.searchBar.placeholder = "Buscar en bitácora"
    }
    
    func loadInfoFromCoraData(){
        let fetchRequest: NSFetchRequest<Log> = Log.fetchRequest()
        do {
            let logs = try PersistenceService.context.fetch(fetchRequest)
            self.notes = logs
            self.tableView.reloadData()
        } catch {}
    }
    
    @IBAction func EditNote(_ sender: Any) {
        let alert = UIAlertController(title: "Categoría", message: "Selecciona la categoría de bitácora", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Unidades", style: .default, handler: { (action) -> Void in
            self.category = "Unidades"
            self.showAlertForm()
        })
        let action2 = UIAlertAction(title: "Pasajeros", style: .default, handler: { (action) -> Void in
            self.category = "Pasajeros"
            self.showAlertForm()
        })
        let action3 = UIAlertAction(title: "Estación", style: .default, handler: { (action) -> Void in
            self.category = "Estación"
            self.showAlertForm()
        })
        // Cancel button
        let cancel = UIAlertAction(title: "Cancelar", style: .destructive, handler: { (action) -> Void in })
        // Add action buttons and present the Alert
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(action3)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func AddNote(_ sender: Any) {
        let alert = UIAlertController(title: "Nota", message: "Selecciona una nota", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Apertura de estación", style: .default, handler: { (action) -> Void in
            let log = Log(context: PersistenceService.context)
            log.title = "Apertura de estación"
            log.detail = "Se incia labor en la estación."
            log.category = "Estación"
            log.date = "20/11/2017"
            log.time = "18:05"
            PersistenceService.saveContext()
            self.notes.append(log)
            self.tableView.reloadData()
        })
        let action2 = UIAlertAction(title: "Cierre de estación", style: .default, handler: { (action) -> Void in
            let log = Log(context: PersistenceService.context)
            log.title = "Cierre de estación"
            log.detail = "Se finaliza labor en la estación."
            log.category = "Estación"
            log.date = "20/11/2017"
            log.time = "18:05"
            PersistenceService.saveContext()
            self.notes.append(log)
            self.tableView.reloadData()
        })
        let action3 = UIAlertAction(title: "Arribo de unidad a la base", style: .default, handler: { (action) -> Void in
            let log = Log(context: PersistenceService.context)
            log.title = "Arribo de unidad a la base"
            log.detail = "Llega del camión a la estación"
            log.category = "Unidades"
            log.date = "20/11/2017"
            log.time = "18:05"
            PersistenceService.saveContext()
            self.notes.append(log)
            self.tableView.reloadData()
        })
        let action4 = UIAlertAction(title: "Salida de unidad de la base", style: .default, handler: { (action) -> Void in
            let log = Log(context: PersistenceService.context)
            log.title = "Salida de unidad de la base"
            log.detail = "Salida del camión"
            log.category = "Unidades"
            log.date = "20/11/2017"
            log.time = "18:05"
            PersistenceService.saveContext()
            self.notes.append(log)
            self.tableView.reloadData()
        })
        let action5 = UIAlertAction(title: "Personas esperando", style: .default, handler: { (action) -> Void in
            let log = Log(context: PersistenceService.context)
            log.title = "Personas esperando"
            log.detail = "Personas esperando en la base"
            log.category = "Pasajeros"
            log.date = "20/11/2017"
            log.time = "18:05"
            PersistenceService.saveContext()
            self.notes.append(log)
            self.tableView.reloadData()
        })
        // Cancel button
        let cancel = UIAlertAction(title: "Cancelar", style: .destructive, handler: { (action) -> Void in })
        // Add action buttons and present the Alert
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(action3)
        alert.addAction(action4)
        alert.addAction(action5)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func showAlertForm(){
        
        let alert = UIAlertController(title: "Agregar nota", message: "Introduzca todos los campos para registrar una nota", preferredStyle: .alert)
        
        // Login button
        let publishAction = UIAlertAction(title: "Publicar", style: .default, handler: { (action) -> Void in
            // Get TextFields text
            let title = alert.textFields![0]
            let detail = alert.textFields![1]
            
            print("Title: \(title.text!)\nDescription: \(detail.text!)")
            if title.text != nil && detail.text != nil {
                let log = Log(context: PersistenceService.context)
                log.title = title.text
                log.detail = detail.text
                log.category = self.category
                log.date = "20/11/2017"
                log.time = "18:05"
                PersistenceService.saveContext()
                self.notes.append(log)
                self.tableView.reloadData()
            }
        })
        
        // Cancel button
        let cancel = UIAlertAction(title: "Cancelar", style: .destructive, handler: { (action) -> Void in })
        
        // Add 1 textField (for username)
        alert.addTextField { (textField: UITextField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.placeholder = "Escribe un título"
        }
        // Add 3rd textField (for phone no.)
        alert.addTextField { (textField: UITextField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.placeholder = "Escribe una descripción"
        }
        
        // Add action buttons and present the Alert
        alert.addAction(cancel)
        alert.addAction(publishAction)
        present(alert, animated: true, completion: nil)
    }
    
}

extension ViewControllerBook : UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    // =================== SEACHBAR =========================
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredData = self.notes.filter({ (note) -> Bool in
            if (note.title?.lowercased().contains(self.searchBar.text!.lowercased()))!{
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
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false;
        self.tableView.reloadData()
    }
    
    // =================== TABLE =========================
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return self.filteredData.count
        }
        else{
            return self.notes.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "NoteCell"
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCellNote
        let note: Log
        
        if isSearching {
            note = filteredData[indexPath.row]
            cell.title.text = note.title
            cell.date.text = note.date
            cell.time.text = note.time
            switch note.category {
            case "Unidades"?:
                cell.imageNote.image = #imageLiteral(resourceName: "bus-check")
            case "Pasajeros"?:
                cell.imageNote.image = #imageLiteral(resourceName: "group")
            case "Estación"?:
                cell.imageNote.image = #imageLiteral(resourceName: "007-building-7")
            default:
                cell.imageNote.image = #imageLiteral(resourceName: "bus-wrong")
            }
            return cell
        } else {
            note = notes[indexPath.row]
            cell.title.text = note.title
            cell.date.text = note.date
            cell.time.text = note.time
            switch note.category {
            case "Unidades"?:
                cell.imageNote.image = #imageLiteral(resourceName: "bus-check")
            case "Pasajeros"?:
                cell.imageNote.image = #imageLiteral(resourceName: "group")
            case "Estación"?:
                cell.imageNote.image = #imageLiteral(resourceName: "007-building-7")
            default:
                cell.imageNote.image = #imageLiteral(resourceName: "bus-wrong")
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // Share
        let shareAction = UITableViewRowAction(style: .normal, title: "compartir") { (action, indexPath) in
            let shareMessage = "\(self.notes[indexPath.row])"
            let shareController = UIActivityViewController(activityItems: [shareMessage], applicationActivities: nil)
            self.present(shareController, animated: true, completion: nil)
        }
        shareAction.backgroundColor = UIColor.orange
        // Delete
        let deleteAction = UITableViewRowAction(style: .default, title: "eliminar") { (action, indexPath) in
            PersistenceService.context.delete(self.notes[indexPath.row])
            PersistenceService.saveContext()
            self.notes.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        return [shareAction, deleteAction]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var selectedNote: Log
        if segue.identifier == "showNoteDetail"{
            if let indexPath = self.tableView.indexPathForSelectedRow{
                selectedNote = self.notes[indexPath.row]
                let newViewControllerD = segue.destination as! ViewControllerNoteDetail
                newViewControllerD.note = selectedNote
            }
            else{
                selectedNote = self.filteredData[0]
                let newViewControllerD = segue.destination as! ViewControllerNoteDetail
                newViewControllerD.note = selectedNote
            }
        }
    }
}
