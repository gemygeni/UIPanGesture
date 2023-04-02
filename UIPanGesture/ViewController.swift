
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fileImageView: UIImageView!
    @IBOutlet weak var trashImageView: UIImageView!
    
    var fileViewOrigin: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bringSubviewToFront(fileImageView)
        fileViewOrigin = fileImageView.frame.origin
        addPanGesture(view: fileImageView)
    }
    
    func addPanGesture(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    // Refactor
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        let fileView = sender.view
        
        switch sender.state{
        case  .changed : moveViewWithPan(view: fileView!, sender: sender)
        case .ended : deleteView(view: fileView!)
           
        default : break
        }
        
    }
    
    
    func moveViewWithPan(view: UIView, sender: UIPanGestureRecognizer) {
       
        let translation = sender.translation(in: view)
        view.center = CGPoint(x: view.center.x + translation.x , y:  view.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: view)

    }
    
    
    func returnViewToOrigin(view: UIView) {
        UIView.animate(withDuration: 0.3, delay: 0.0) {
            self.fileImageView.frame.origin = self.fileViewOrigin
        }
    }
    
    
    func deleteView(view: UIView) {
        if fileImageView.frame.intersects(trashImageView.frame) {
        UIView.animate(withDuration: 0.3, delay: 0) {
            view.alpha = 0.0
        }
        
    }else{
        returnViewToOrigin(view: view)
    }
    }
}

