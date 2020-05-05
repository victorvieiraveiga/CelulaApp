//
//  ReuniaoParticipantesTableViewCell.swift
//  Celula
//
//  Created by Victor Vieira Veiga on 01/04/20.
//  Copyright © 2020 Victor Vieira Veiga. All rights reserved.
//

import UIKit
import CoreData

class ReuniaoParticipantesTableViewCell: UITableViewCell {

    @IBOutlet weak var labelNome: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configuraParticipanteCell (_ participante : NSManagedObject ) {
        
        guard let nome = participante.value(forKey: "nome") else {return}
        labelNome.text = nome as? String
    }

}
