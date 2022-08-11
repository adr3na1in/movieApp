

import SnapKit

final class CUIimageView: UIImageView
{
    var tapHandler: (() -> Void)? {
        didSet {
            if tapHandler != nil {
                self.addRecognizer()
            }
            else {
                self.removeRecognizer()
            }
        }
    }
}

private extension CUIimageView
{
    func addRecognizer() {
        isUserInteractionEnabled = true
        let recognizerPressed = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressed(_:)))
        recognizerPressed.minimumPressDuration = 0
        self.addGestureRecognizer(recognizerPressed)

    }
    
    func removeRecognizer() {
        isUserInteractionEnabled = false
        let recognizers = self.gestureRecognizers
        recognizers?.forEach { self.removeGestureRecognizer($0) }

    }
    
    @objc func  longPressed(_ recognizer: UILongPressGestureRecognizer) {
        
        }
    }

