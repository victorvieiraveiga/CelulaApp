//
//  CelulaTableViewCell.swift
//  Celula
//
//  Created by Victor Vieira Veiga on 24/03/20.
//  Copyright © 2020 Victor Vieira Veiga. All rights reserved.
//

import UIKit
import CoreData

class CelulaTableViewCell: UITableViewCell {

    @IBOutlet weak var labelNomeCelula: UILabel!
    @IBOutlet weak var labelNomeLider: UILabel!
    
    @IBOutlet weak var labelDia: UILabel!
    @IBOutlet weak var labelAnfitriao: UILabel!
    @IBOutlet weak var labelHorario: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configuraCelula (celula: NSManagedObject) {
        
        
        guard let nome = celula.value(forKey: "nome") else {return}
        guard let lider = celula.value(forKey: "lider") else {return}
        guard let anfitriao = celula.value(forKey: "anfitriao") else {return}
        guard let dia = celula.value(forKey: "dia") else {return}
        guard let horario = celula.value(forKey: "horario") else {return}
        
        labelNomeCelula.text = nome as? String
        labelNomeLider.text = "Líder: \(lider)"
        labelAnfitriao.text = "Anfitrião: \(anfitriao)"
        labelDia.text = "Dia: \(dia)"
        labelHorario.text = "Horario: \(horario) H"
        
    }

}
