//
//  HomeViewController.swift
//  Celula
//
//  Created by Victor Vieira Veiga on 14/04/20.
//  Copyright © 2020 Victor Vieira Veiga. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

 
    @IBOutlet weak var collectionCelula: UICollectionView!
    @IBOutlet weak var collectionReuniao: UICollectionView!
    @IBOutlet weak var contadorReuniao: UILabel!
 
    @IBOutlet weak var viewPrincipal: UIView!
    @IBOutlet weak var viewSemCelula: UIView!
    
    @IBOutlet weak var labelUltimasReunioes: UILabel!
    
    
    @IBOutlet weak var viewReuniaoMini: UIView!

    @IBOutlet weak var viewCelulaMini: UIView!
    @IBOutlet weak var labelContParticipantes: UILabel!
    @IBOutlet weak var viewParticipantesMini: UIView!
    @IBOutlet weak var labelContCelula: UILabel!
    
    var reuniaoList : [NSManagedObject] = []
    var participantesReuniao : [NSManagedObject] = []
    var celulaList : [NSManagedObject] = []
    var participantesList : [NSManagedObject] = []
    let reuniaoObject = FormataReuniao()
    let celulaObject = FormataCelula()
    let partObject = FormataParticipantes()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inicio()

        collectionReuniao.delegate = self
        collectionReuniao.dataSource = self
        collectionCelula.delegate = self
        collectionCelula.dataSource = self


        collectionReuniao.heightAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
        collectionCelula.heightAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
        
        if let flowLayoutA = collectionCelula.collectionViewLayout as? UICollectionViewFlowLayout {
               flowLayoutA.scrollDirection = .horizontal
          }
         if let flowLayoutB = collectionReuniao.collectionViewLayout as? UICollectionViewFlowLayout {
                     flowLayoutB.scrollDirection = .horizontal
           }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        inicio()

        contadorReuniao.text = String(reuniaoObject.numeroReunioes())
        collectionCelula.reloadData()
        collectionReuniao.reloadData()
    }
    
    func inicio () {
        
        if celulaObject.existeCelula() == true {
            
            viewSemCelula.isHidden = true
            viewPrincipal.isHidden = false

            self.reuniaoList = reuniaoObject.CarregaReuniao(numero_registros: 10)
            self.celulaList = celulaObject.CarregaCelula()
            self.participantesList = partObject.CarregaParticipante()
            
            exibeLabelsCelula()
            exibeLabelsReuniao()
            exibeLabelsParticipante()

        }
        else {
            viewSemCelula.isHidden = false
            viewPrincipal.isHidden = true
        }
    }
    
    func exibeLabelsReuniao () {
        if self.reuniaoList.count > 0 {
            contadorReuniao.text = String(reuniaoObject.numeroReunioes())
            labelUltimasReunioes.isHidden = false
            viewReuniaoMini.isHidden = false
            contadorReuniao.isHidden = false
        }else {
            labelUltimasReunioes.isHidden = true
            viewReuniaoMini.isHidden = true
            contadorReuniao.isHidden = true
        }
    }
    
    func exibeLabelsCelula () {
        if self.celulaList.count > 0 {
            
            labelContCelula.isHidden = false
            viewCelulaMini.isHidden = false
            labelContCelula.text = String(celulaObject.numeroCelula())
        }else {
            labelContCelula.isHidden = true
            viewCelulaMini.isHidden = true
        }
    }
    
    func exibeLabelsParticipante() {
        if self.participantesList.count > 0 {
            labelContParticipantes.isHidden = false
            viewParticipantesMini.isHidden = false
            labelContParticipantes.text = String(partObject.numeroParticipante())
        }else {
            labelContParticipantes.isHidden = true
            viewParticipantesMini.isHidden = true
        }
    }
    
    
    

    
    @IBAction func chamaTelaCadastroCelula(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
              let controller = storyboard.instantiateViewController(identifier: "cadCelula") as! CadastroCelulaViewController
              navigationController?.pushViewController(controller, animated: true)
    }
}

extension HomeViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.collectionReuniao {
            return reuniaoList.count
        }else {
            return celulaList.count
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == self.collectionCelula {
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCelula", for: indexPath) as! ConfigCellCelula
            
            let celula = celulaList[indexPath.item]
            cellB.configuraCelula(celula: celula)
            return cellB
        } else {
            let cellA = collectionReuniao.dequeueReusableCell(withReuseIdentifier: "reuniaoCell", for: indexPath) as! ConfigCell
            
            let reuniao = reuniaoList[indexPath.item]
            let id = reuniao.value(forKey: "id") as! String
            self.participantesReuniao =  partObject.CarregaParticipantesReuniao(idReuniao: id, nomeCelula: "Celula Victor")
            cellA.configuraReuniao(reuniao: reuniao, participantes:  self.participantesReuniao )
            
            return cellA
        }
    }
    

}


