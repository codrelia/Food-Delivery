import UIKit

class TabBarController: UITabBarController {

    // MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
    }
}

// MARK: - Private methods

private extension TabBarController {
    
    func configureTabBar() {
        viewControllers = [
            generateViewControllers(title: "Меню", image: Images.menuIconImage, view: MainModuleRouter().getView()),
            generateViewControllers(title: "Контакты", image: Images.contactsIconImage, view: UIViewController()),
            generateViewControllers(title: "Профиль", image: Images.profileIconImage, view: UIViewController()),
            generateViewControllers(title: "Корзина", image: Images.cartIconImage, view: UIViewController())
        ]
        
        tabBar.backgroundColor = .white
        tabBar.tintColor = Colors.activeIconColor
        tabBar.unselectedItemTintColor = Colors.iconColor
        
    }
    func generateViewControllers(title: String, image: UIImage, view: UIViewController) -> UIViewController {
        view.tabBarItem.title = title
        view.tabBarItem.image = image
        return UINavigationController(rootViewController: view)
    }
    
    func animationOfTabBarButton(_ view: UIView) {
        let timeInterval: TimeInterval = 0.2
        let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.9) {
            view.transform = CGAffineTransform.identity.scaledBy(x: 0.7, y: 0.7)
        }
        propertyAnimator.addAnimations({ view.transform = .identity }, delayFactor: CGFloat(timeInterval))
        propertyAnimator.startAnimation()

    }
}

// MARK: - UITabBarControllerDelegate

extension TabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        var view: UIView? = nil
        
        for i in tabBar.subviews {
            if i == item.value(forKey: "view") as? UIView {
                view = i
                break;
            }
        }
        
        guard let view = view else {
            return
        }
        
        animationOfTabBarButton(view)
    }
}
