//
//  ConfigCellCelula.swift
//  Celula
//
//  Created by Victor Vieira Veiga on 27/04/20.
//  Copyright © 2020 Victor Vieira Veiga. All rights reserved.
//

import UIKit
import CoreData

class ConfigCellCelula: UICollectionViewCell {
    
    @IBOutlet weak var labelNomeCelula: UILabel!
       @IBOutlet weak var labelDiaCelula: UILabel!
       @IBOutlet weak var labelHorarioCelula: UILabel!
       @IBOutlet weak var labelEnderecoCelula: UILabel!
    
    func configuraCelula (celula: NSManagedObject) {
        
           guard let nome =  celula.value(forKey: "nome") else {return}
           guard let dia =  celula.value(forKey: "dia") else {return}
           guard let horario =  celula.value(forKey: "horario") else {return}
           guard let logradouro =  celula.value(forKey: "logradouro") else {return}
           guard let numero =  celula.value(forKey: "numero") else {return}
           guard let bairro =  celula.value(forKey: "bairro") else {return}
           
           
           labelNomeCelula.text = nome as? String
           labelDiaCelula.text = "Dia: \(dia)"
           labelHorarioCelula.text = "Horário: \(horario)"
           labelEnderecoCelula.text = "\(logradouro), \(numero) - \(bairro)"
           
           
       }
    
    
}
