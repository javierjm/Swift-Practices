## Power Up Your Animations Keys

 

**DIY \#1 Key**

Inside the completion closure of `cancelAnimationChain` insert:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
UIView.animateAndChainWithDuration(0.33, delay: 0, options: nil, animations: {
    self.btnLogin.transform = CGAffineTransformMakeScale(0.01, 0.01)
}, completion: nil)

.animateWithDuration(0.25, delay: 0, options: .CurveEaseIn, animations: {
    self.fldUsername.center.x -= self.view.bounds.width
}, completion: nil)

.animateWithDuration(0.25, delay: 0, options: .CurveEaseIn, animations: {
    self.fldPassword.center.x -= self.view.bounds.width
}, completion: {_ in
    //push next screen
    actionShowOnboarding()
})
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

**DIY \#3 Key**

This is the key to the first example:

Replace this code:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
toVC.view.transform = CGAffineTransformMakeTranslation(width, 0.0)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

with:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
toVC.view.alpha = 0.0
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Then replace this code in the 3rd animation in the sequence:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
toVC.view.transform = CGAffineTransformIdentity
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

with:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
toVC.view.alpha = 1.0
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

**DIY \#4 Key**

To add another meter layer append to `setupMeter`:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//right channel
var rightMeter = createMeter()
rightMeter.frame.origin.x = view.bounds.size.width * 0.51
displayView.layer.addSublayer(rightMeter)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To animate the second meter add inside the `levelsHandler` closure:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let rightBarCount = max(0, Int(right) + 45)
rightMeter.instanceCount = rightBarCount
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
