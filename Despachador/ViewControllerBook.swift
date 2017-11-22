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
    
    func loadInfoFromCoraData() {
        let fetchRequest: NSFetchRequest<Log> = Log.fetchRequest()
        do {
            let logs = try PersistenceService.context.fetch(fetchRequest)
            self.notes = logs
            self.tableView.reloadData()
        } catch {}
    }
    
    func getDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_SP")
        formatter.dateFormat = "dd 'de' MMMM 'de' yyyy"
        
        return formatter.string(from: date)
    }
    
    func getTime() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    func getImageByCategory(category: String) -> UIImage {
        var image: UIImage
        switch category {
        case "unidades":
            image = #imageLiteral(resourceName: "transport")
        case "llegada":
            image = #imageLiteral(resourceName: "arrowGreen")
        case "salida":
            image = #imageLiteral(resourceName: "arrowRed")
        case "cerrado":
            image = #imageLiteral(resourceName: "closed")
        case "abierto":
            image = #imageLiteral(resourceName: "open")
        case "pasajeros":
            image = #imageLiteral(resourceName: "passenger")
        case "estación":
            image = #imageLiteral(resourceName: "signStation")
        default:
            image = #imageLiteral(resourceName: "forbidden")
        }
        return image
    }
    
    func fillForm(title: String, detail: String, category: String) {
        let log = Log(context: PersistenceService.context)
        log.title = title
        log.detail = detail
        log.category = category
        log.date = self.getDate()
        log.time = self.getTime()
        PersistenceService.saveContext()
        self.notes.append(log)
        self.tableView.reloadData()
    }
    
    @IBAction func EditNote(_ sender: Any) {
        let alert = UIAlertController(title: "Categoría", message: "Selecciona la categoría de bitácora", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Unidades", style: .default, handler: { (action) -> Void in
            self.category = "unidades"
            self.showAlertForm()
        })
        let action2 = UIAlertAction(title: "Pasajeros", style: .default, handler: { (action) -> Void in
            self.category = "pasajeros"
            self.showAlertForm()
        })
        let action3 = UIAlertAction(title: "Estación", style: .default, handler: { (action) -> Void in
            self.category = "estación"
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
            self.fillForm(title: "Apertura de estación", detail: "Se incian labores en la estación.", category: "abierto")
        })
        let action2 = UIAlertAction(title: "Cierre de estación", style: .default, handler: { (action) -> Void in
            self.fillForm(title: "Cierre de estación", detail: "Se finaliza labor en la estación.", category: "cerrado")
        })
        let action3 = UIAlertAction(title: "Arribo de unidad a la base", style: .default, handler: { (action) -> Void in
            self.fillForm(title: "Arribo de unidad a la base", detail: "Llega del camión a la estación.", category: "llegada")
        })
        let action4 = UIAlertAction(title: "Salida de unidad de la base", style: .default, handler: { (action) -> Void in
            self.fillForm(title: "Salida de unidad de la base", detail: "Salida del camión.", category: "salida")
        })
        let action5 = UIAlertAction(title: "Personas esperando", style: .default, handler: { (action) -> Void in
            self.fillForm(title: "Personas esperando", detail: "Personas esperando en la base.", category: "pasajeros")
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
        // Publish button
        let publishAction = UIAlertAction(title: "Publicar", style: .default, handler: { (action) -> Void in
            // Get TextFields text
            let title = alert.textFields![0]
            let detail = alert.textFields![1]
            if title.text != nil && detail.text != nil {
                self.fillForm(title: title.text!, detail: detail.text!, category: self.category)
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
    
    // =================== SEARCHBAR =========================
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
    
    // =================== TABLE ========================
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
            cell.imageNote.image = getImageByCategory(category: note.category!)
            return cell
        } else {
            note = notes[indexPath.row]
            cell.title.text = note.title
            cell.date.text = note.date
            cell.time.text = note.time
            cell.imageNote.image = getImageByCategory(category: note.category!)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedNote: Log
        selectedNote = self.notes[indexPath.row]
        let alert = UIAlertController(title: "\n\n\n\n\(selectedNote.title!)", message: selectedNote.detail!, preferredStyle: .alert)
        // OK button
        let okButton = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in })
        let imageView = UIImageView(frame: CGRect(x: 95, y: 15, width: 80, height: 80))
        imageView.image = getImageByCategory(category: selectedNote.category!)
        // Add action buttons and present the Alert
        alert.view.addSubview(imageView)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}
