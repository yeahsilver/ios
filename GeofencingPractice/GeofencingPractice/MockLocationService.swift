import Foundation
import CoreLocation
import NotificationCenter
import CoreData
import MapKit

class MockLocationService: NSObject {
    static let shared = MockLocationService()
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var container = appDelegate.persistentContainer
    var locationManager: CLLocationManager
    
    private override init() {
        locationManager = CLLocationManager()
        
        super.init()
        
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
    }
}

extension MockLocationService {
    func notification(_ title: String = "Wolley 테스트", body: String) {
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.getNotificationSettings() { settings in
            if settings.alertSetting == .enabled {
                let content = UNMutableNotificationContent()
                content.title = title
                content.body = body
                
                let uuidString = UUID().uuidString
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                let request = UNNotificationRequest(identifier: "Test=\(uuidString)", content: content, trigger: trigger)
                
                notificationCenter.add(request) { error in
                    if error != nil {
                        
                    }
                }
            }
        }
    }
}

extension MockLocationService {
    func startMonitoringLocation() {
        let latitude = (locationManager.location?.coordinate.latitude)!
        let longitude = (locationManager.location?.coordinate.longitude)!
        
        let location  = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let region = CLCircularRegion(center: location, radius: 1, identifier: "location")
        region.notifyOnEntry = false
        region.notifyOnExit = true
        
        locationManager.startMonitoring(for: region)
        locationManager.startUpdatingLocation()
        
    }
        
    func stopMonitoringLocation() {
        let monitoredRegions = locationManager.monitoredRegions
        
        for region in monitoredRegions {
            locationManager.stopMonitoring(for: region)
        }
        
    }
    
    func saveLocation() {
        let entity = NSEntityDescription.entity(forEntityName: "Location", in: self.container.viewContext)!
        
        let latitude = String((locationManager.location?.coordinate.latitude) ?? 0.0)
        let longitude = String((locationManager.location?.coordinate.longitude) ?? 0.0)
        let speed = String((locationManager.location?.speed) ?? 0)
        
        let location = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
        location.setValue("\(getCurrentTime())", forKey: "time")
        location.setValue([latitude, longitude], forKey: "coordinate")
        location.setValue(speed, forKey: "speed")
        
        do {
            try self.container.viewContext.save()
            
        } catch {
        }
        
    }
    
    func getCurrentTime() -> String {
        let now = NSDate()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.string(from: now as Date)
    }
}

extension MockLocationService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = locationManager.authorizationStatus
        
        switch status {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .restricted:
            break
        case .denied:
            break
        case .authorizedAlways:
            locationManager.requestAlwaysAuthorization()
            
        case .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("didStartMonitoringFor \(region)")
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        switch state {
        case .inside:
            break
            
        case .outside:
            let latitude = locationManager.location?.coordinate.latitude
            let longitude = locationManager.location?.coordinate.longitude
            print("밖으로 나갔습니다: \(latitude), \(longitude)")
            notification(body: "밖으로 나갔습니다.")
            
            stopMonitoringLocation()
            startMonitoringLocation()
            saveLocation()
            
        case .unknown:
            break
        }
    }
    
    func render(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
    }
}

