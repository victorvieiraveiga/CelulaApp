//
//  FormataReuniao.swift
//  Celula
//
//  Created by Victor Vieira Veiga on 11/04/20.
//  Copyright © 2020 Victor Vieira Veiga. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class FormataReuniao {
    
    func DesenbrulhaParticipantes (_ participantes : [NSManagedObject] ) ->  String {
        var participantesString : String = ""
        
        if participantes.count == 1 {
            participantesString = (participantes[0].value(forKey: "nome") as? String)!
        }else {
            
            var i : Int = 0
            
            while i < participantes.count {
                
                guard let participante: String = participantes[i].value(forKey: "nome") as? String else {return ""}
                
                if i+1 != participantes.count {
                    participantesString = participantesString + participante + ", "
                } else {
                    participantesString = participantesString + participante
                }
                
                i = i + 1
            }
        }

        return participantesString
    }
    
    
    func CarragaParticipantesReuniao (idReuniao: String? = nil, nomeCelula: String) -> [NSManagedObject] {
        var participantesReuniao: [NSManagedObject] = []
        
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
    
    func CarregaReuniao () -> [NSManagedObject] {
        //Mark - Cria conexão com CoreData
        var reuniaoList : [NSManagedObject] = []
         let appDelegate = UIApplication.shared.delegate as? AppDelegate
         let context = appDelegate?.persistentContainer.viewContext
         let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ReuniaoCelulaDB")
        
        let sort = NSSortDescriptor(key: "data", ascending: false)
        request.sortDescriptors = [sort]
        //request.fetchLimit = 5
        
         do {
            reuniaoList = try  context?.fetch(request) as! [NSManagedObject]
         } catch  {
             print ("Erro ao carregar Reuniao")
         }
         return reuniaoList
    }
    
    func CarregaReuniao (numero_registros: Int) -> [NSManagedObject] {
        //Mark - Cria conexão com CoreData
        var reuniaoList : [NSManagedObject] = []
         let appDelegate = UIApplication.shared.delegate as? AppDelegate
         let context = appDelegate?.persistentContainer.viewContext
         let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ReuniaoCelulaDB")
        
        let sort = NSSortDescriptor(key: "data", ascending: false)
        request.sortDescriptors = [sort]
        request.fetchLimit = numero_registros
        
         do {
            reuniaoList = try  context?.fetch(request) as! [NSManagedObject]
         } catch  {
             print ("Erro ao carregar Reuniao")
         }
         return reuniaoList
    }
    
    func numeroReunioes () -> Int{
        
        var nrReunioes : Int = 0
        
        let reuniaoList = CarregaReuniao()
        
        nrReunioes = reuniaoList.count
        
        return nrReunioes
        
    }
    
    func geraIdReuniao () -> String {
          var id: String = ""
          var cont: Int = 0
          var reuniaoQuant : [NSManagedObject] = []
          
          let appDelegate = UIApplication.shared.delegate as? AppDelegate
          let context = appDelegate?.persistentContainer.viewContext
          let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ReuniaoCelulaDB")
          let sort = NSSortDescriptor(key: "id", ascending: false)
          
          request.sortDescriptors = [sort]
          
          do {
                  reuniaoQuant = try  context?.fetch(request) as! [NSManagedObject]
              } catch  {
                  print ("Erro ao carregar participantes")
              }
          if reuniaoQuant.count == 0 {
              id = "0"
          }else {
              
              let reuniaoSelect = reuniaoQuant[0].value(forKey: "id")
              
              if reuniaoSelect == nil{
                  id = "0"
              } else {
                  id = reuniaoQuant[0].value(forKey: "id") as! String
                  cont = Int(id)! + 1
                  id = String(cont)
              }

          }
          return id
      }
    
   
    
}
