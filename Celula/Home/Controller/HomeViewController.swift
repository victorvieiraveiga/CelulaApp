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
    //@IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var contadorReuniao: UILabel!
 
    @IBOutlet weak var viewPrincipal: UIView!
    @IBOutlet weak var viewSemCelula: UIView!
    
    var reuniaoList : [NSManagedObject] = []
    var participantesReuniao : [NSManagedObject] = []
    var celulaList : [NSManagedObject] = []
    let reuniaoObject = FormataReuniao()
    let celulaObject = FormataCelula()
    let partObject = FormataParticipantes()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inicio()
        self.reuniaoList = reuniaoObject.CarregaReuniao(numero_registros: 10)
        contadorReuniao.text = String(reuniaoObject.numeroReunioes())
        self.celulaList = celulaObject.CarregaCelula()
        collectionReuniao.delegate = self
        collectionReuniao.dataSource = self
        collectionCelula.delegate = self
        collectionCelula.dataSource = self


        collectionReuniao.heightAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
        //collectionCelula.heightAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
        
//        if let flowLayoutA = collectionCelula.collectionViewLayout as? UICollectionViewFlowLayout {
//               flowLayoutA.scrollDirection = .horizontal
//           }
         if let flowLayoutB = collectionReuniao.collectionViewLayout as? UICollectionViewFlowLayout {
                     flowLayoutB.scrollDirection = .horizontal
           }
//

   //     collectionCelula.reloadData()
    //    collectionReuniao.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
         inicio()
        self.reuniaoList = reuniaoObject.CarregaReuniao(numero_registros: 10)
        self.celulaList = celulaObject.CarregaCelula()
        contadorReuniao.text = String(reuniaoObject.numeroReunioes())
        collectionCelula.reloadData()
        collectionReuniao.reloadData()

    }
    
    func inicio () {
        if celulaObject.existeCelula() == true {
            viewSemCelula.isHidden = true
            viewPrincipal.isHidden = false

           self.reuniaoList = reuniaoObject.CarregaReuniao(numero_registros: 10)
            contadorReuniao.text = String(reuniaoObject.numeroReunioes())
            self.celulaList = celulaObject.CarregaCelula()

        }
        else {
            viewSemCelula.isHidden = false
            viewPrincipal.isHidden = true
        }
    }
    
    @IBAction func chamaTelaCadastroCelula(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
              let controller = storyboard.instantiateViewController(identifier: "cadCelula") as! CadastroCelulaViewController
              navigationController?.pushViewController(controller, animated: true)
    }
}

extension HomeViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        if collectionView == self.collectionCelula {
//            return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
//        }else {
//            return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
//        }
//    }
    

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
        
        
        
//        if collectionView == self.collectionReuniao {
//            let cellA = collectionReuniao.dequeueReusableCell(withReuseIdentifier: "reuniaoCell", for: indexPath) as! ConfigCell
//
//            let reuniao = reuniaoList[indexPath.item]
//            let id = reuniao.value(forKey: "id") as! String
//            self.participantesReuniao =  partObject.CarregaParticipantesReuniao(idReuniao: id, nomeCelula: "Celula Victor")
//            cellA.configuraReuniao(reuniao: reuniao, participantes:  self.participantesReuniao )
//
//            return cellA
//        }else {
//            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCelula", for: indexPath) as! ConfigCellCelula
//
//            let celula = celulaList[indexPath.item]
//            cellB.configuraCelula(celula: celula)
//            return cellB
//        }
    }
    

}


