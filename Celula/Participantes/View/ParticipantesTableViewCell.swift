//
//  ParticipantesTableViewCell.swift
//  Celula
//
//  Created by Victor Vieira Veiga on 26/03/20.
//  Copyright © 2020 Victor Vieira Veiga. All rights reserved.
//

import UIKit
import CoreData

class ParticipantesTableViewCell: UITableViewCell {

    @IBOutlet weak var imageParticipante: UIImageView!
    @IBOutlet weak var labelNome: UILabel!
    @IBOutlet weak var labelDataNascimento: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configuraCelula (participante: NSManagedObject) {

        guard let nome = participante.value(forKey: "nome") else {return}
        guard let dataNascimento = participante.value(forKey: "data_nascimento") else {return}
        guard let image = participante.value(forKey: "foto") else {return}
        
        labelNome.text = nome as? String
        labelDataNascimento.text = "Data de Nascimento: \(dataNascimento)"
        imageParticipante.image = UIImage(data: image as! Data)
      
    }

}
