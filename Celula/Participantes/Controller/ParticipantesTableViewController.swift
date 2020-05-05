//
//  ParticipantesTableViewController.swift
//  Celula
//
//  Created by Victor Vieira Veiga on 26/03/20.
//  Copyright © 2020 Victor Vieira Veiga. All rights reserved.
//

import UIKit
import CoreData

class ParticipantesTableViewController: UITableViewController {

    
    var participantes : [NSManagedObject] = []
    var participanteObject = FormataParticipantes()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.participantes = participanteObject.CarregaParticipante()
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
         self.participantes = participanteObject.CarregaParticipante()
         tableView.reloadData()
    }
    
    @IBAction func buttonVoltar(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonAdicionar(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "addParticipanteId") as! ParticipanteViewController
        self.navigationController?.pushViewController(controller, animated: false)
    }
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return participantes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ParticipantesTableViewCell
        let participante = self.participantes[indexPath.item]
        cell.configuraCelula(participante: participante)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let participanteItem = self.participantes[indexPath.row]
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
               let context = appDelegate?.persistentContainer.viewContext
               context?.delete(participanteItem)
               do {
                   try context?.save()
               } catch let erro {
                   print ("Erro ao remover item \(erro)")
               }
        self.participantes.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
}
