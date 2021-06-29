

import UIKit
import AlamofireImage
class HeroTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var heroStatusLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var heroLocationLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    func setup(with character: Hero){
        heroNameLabel.text=character.name
        heroStatusLabel.text=character.status + " - " + character.species
        heroLocationLabel.text=character.location?.name
        if let imageURL = URL(string: character.image)
        {
            heroImageView.af.setImage(withURL: imageURL)
        }
        backView.layer.cornerRadius=10
        backView.clipsToBounds=true
        statusView.layer.cornerRadius=4
        statusView.clipsToBounds=true
        switch character.status {
        case "Alive":
            statusView.backgroundColor=UIColor.green
        case "Dead":
            statusView.backgroundColor=UIColor.red
        default:
            statusView.backgroundColor=UIColor.gray
        }
    }


}
