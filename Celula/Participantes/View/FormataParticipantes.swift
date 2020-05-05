//
//  FormataParticipantes.swift
//  Celula
//
//  Created by Victor Vieira Veiga on 15/04/20.
//  Copyright © 2020 Victor Vieira Veiga. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FormataParticipantes {
    
    
    func existeParticipantes () -> Bool {
        var temParticipante : Bool = false
        
        let participantes = CarregaParticipante()
        if participantes.count == 0 {
            temParticipante = false
        }else {
            temParticipante = true
        }
        return temParticipante
    }
    
    
    func CarregaParticipante () -> [NSManagedObject]{
        var participantes : [NSManagedObject] = []
          let appDelegate = UIApplication.shared.delegate as? AppDelegate
          let context = appDelegate?.persistentContainer.viewContext
          let requestFavorite = NSFetchRequest<NSFetchRequestResult>(entityName: "ParticipantesDB")
         
          do {
             participantes = try  context?.fetch(requestFavorite) as! [NSManagedObject]
          } catch  {
              print ("Erro ao carregar participantes")
          }
        return participantes
     }
    
    func CarregaParticipantesReuniao (idReuniao: String? = nil, nomeCelula: String) -> [NSManagedObject] {
        //Mark - Cria conexão com CoreData
         var participantesReuniao : [NSManagedObject] = []
         let appDelegate = UIApplication.shared.delegate as? AppDelegate
         let context = appDelegate?.persistentContainer.viewContext
         let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ParticipantesReuniaoCelulaDB")
        
         //let filtro = NSPredicate(format: "ParticipantesReuniaoCelulaDB.idReuniao == %@", idReuniao!)
         let filtro = NSPredicate(format: "idReuniao == %@", idReuniao!)
         request.predicate = filtro
    
         do {
            participantesReuniao = try  context?.fetch(request) as! [NSManagedObject]
         } catch  {
             print ("Erro ao carregar participantes")
         }
        return participantesReuniao
    }
    
}
