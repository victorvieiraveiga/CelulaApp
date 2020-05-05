//
//  ReuniaoTableViewCell.swift
//  Celula
//
//  Created by Victor Vieira Veiga on 26/03/20.
//  Copyright © 2020 Victor Vieira Veiga. All rights reserved.
//

import UIKit
import CoreData

class ReuniaoTableViewCell: UITableViewCell {


    @IBOutlet weak var labelData: UILabel!
    @IBOutlet weak var labelParticipantes: UILabel!
    @IBOutlet weak var botaoCompartilhar: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    func configuraReuniao (reuniao: NSManagedObject, participantes: [NSManagedObject] ) {
        
        guard let date =  reuniao.value(forKey: "data") else {return}
        //converte data para string
        let dateFormatter = DateFormatter ()
        dateFormatter.locale = Locale(identifier: "pt_br")
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let strDate = dateFormatter.string(from: date as! Date)
        
        labelData.text = strDate
        labelParticipantes.text = ""
        if participantes.count == 1 {
            labelParticipantes.text = participantes[0].value(forKey: "nome") as? String
        }else {
            
            var i : Int = 0
            
            while i < participantes.count {
                guard let participante: String = participantes[i].value(forKey: "nome") as! String else {return}
                
                if i+1 != participantes.count {
                    labelParticipantes.text = labelParticipantes.text! + participante + ", "
                } else {
                    labelParticipantes.text = labelParticipantes.text! + participante
                }
                
                i = i + 1
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
