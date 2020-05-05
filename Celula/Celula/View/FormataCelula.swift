//
//  FormataCelula.swift
//  Celula
//
//  Created by Victor Vieira Veiga on 18/04/20.
//  Copyright © 2020 Victor Vieira Veiga. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class FormataCelula {
    
    func CarregaCelula () -> [NSManagedObject] {
        //Mark - Cria conexão com CoreData
        var celula: [NSManagedObject] = []
         let appDelegate = UIApplication.shared.delegate as? AppDelegate
         let context = appDelegate?.persistentContainer.viewContext
         let requestFavorite = NSFetchRequest<NSFetchRequestResult>(entityName: "CelulaDB")
        
         do {
            celula = try  context?.fetch(requestFavorite) as! [NSManagedObject]
         } catch  {
             print ("Erro ao carregar celula")
         }
        
        return celula
    }
    
    
    func existeCelula () -> Bool {
        var temCelula : Bool = false
        
        let celula = CarregaCelula()
        if celula.count == 0 {
            temCelula = false
        }else {
            temCelula = true
        }
        return temCelula
    }
    
    func verificaCelulaExiste (_ nomeCelula: String) -> Bool {
        var existeCelula : Bool = false
        var celula: [NSManagedObject] = []
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        let requestFavorite = NSFetchRequest<NSFetchRequestResult>(entityName: "CelulaDB")
        
        do {
           celula = try  context?.fetch(requestFavorite) as! [NSManagedObject]
        } catch  {
            print ("Erro ao carregar celula")
        }
        
       
        
        for cel in celula {
            guard let nome = cel.value(forKey: "nome")  else {return false}
                       
            if nome != nil{
            
                if cel.value(forKey: "nome") as! String == nomeCelula {
                    existeCelula = true
                }
                else {
                    existeCelula = false
                }
            }
        }
        return existeCelula
    }
    
}
