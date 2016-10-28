//
//  ParticipationMovieProtocol.swift
//  Mooviest
//
//  Created by Antonio RG on 26/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit
import Kingfisher

protocol ParticipationMovieProtocol {
}

extension ParticipationMovieProtocol {
    func loadParticipationToView (ParticipationCollectionViewCell pv: ParticipationCollectionViewCell, participation p: Participation )-> ParticipationCollectionViewCell {
        pv.faceImageView.kf_setImage(with:  URL(string: p.image),placeholder: UIImage(named:  "noimageprofile"))
        pv.nameLabel.text = p.name
        pv.roleLabel.text = p.role
        
        return pv
    }
}
