//
//  ConfigCellParticipantes.swift
//  Celula
//
//  Created by Victor Vieira Veiga on 28/05/20.
//  Copyright © 2020 Victor Vieira Veiga. All rights reserved.
//

import UIKit
import  CoreData

class ConfigCellParticipantes: UICollectionViewCell {
    
    @IBOutlet weak var imageFoto: UIImageView!
    @IBOutlet weak var labelNome: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelTelefone: UILabel!
    @IBOutlet weak var labelIdade: UILabel!
    
    
    
    
    
    func configuraParticipanted (_ participante: NSManagedObject) {
        
           guard let nome =  participante.value(forKey: "nome") else {return}
           guard let email =  participante.value(forKey: "email") else {return}
           guard let telefone =  participante.value(forKey: "telefone") else {return}
           guard let idade =  participante.value(forKey: "data_nascimento") else {return}
           guard let foto =  participante.value(forKey: "foto") else {return}
           
           
           
           labelNome.text = nome as? String
           labelEmail.text = "Email: \(email)"
           labelTelefone.text = "Telefone: \(telefone)"
           labelIdade.text = "Data de Nascimento: \(idade)"
           imageFoto.image = UIImage(data: foto as! Data)
           
           
       }
}
