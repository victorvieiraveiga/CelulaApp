//
//  CelulaViewController.swift
//  Celula
//
//  Created by Victor Vieira Veiga on 25/03/20.
//  Copyright © 2020 Victor Vieira Veiga. All rights reserved.
//

import UIKit
import CoreData

class CelulaViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    

    @IBOutlet weak var tableview: UITableView!
    

    var celula : [NSManagedObject] = []
    var celulaObject = FormataCelula()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.celula = celulaObject.CarregaCelula()
    }
    
    override func viewDidAppear(_ animated: Bool) {
         self.celula = celulaObject.CarregaCelula()
         tableview.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return celula.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CelulaTableViewCell
        let celulaItem = self.celula[indexPath.item]
        cell.configuraCelula(celula: celulaItem)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let celula =    self.celula[indexPath.item]
             
             let storyboard = UIStoryboard(name: "Main", bundle: nil)
             let controller = storyboard.instantiateViewController(identifier: "cadCelula") as! CadastroCelulaViewController
             
             controller.celulaSelecionada = [celula]
             //self.present(controller, animated: true, completion: nil)
             self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let celulaItem = self.celula[indexPath.row]
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        context?.delete(celulaItem)
        do {
            try context?.save()
        } catch let erro {
            print ("Erro ao remover item \(erro)")
        }
        self.celula.remove(at: indexPath.row)
        tableView.reloadData()
        
    }

}
