//
//  HostingController.swift
//  WatchOSTestApp WatchKit Extension
//
//  Created by Shawn Roller on 6/5/19.
//  Copyright © 2019 Shawn Roller. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI
import CoreBluetooth

class HostingController : WKHostingController<LoginView> {//}, CBPeripheralDelegate, CBCentralManagerDelegate {
    
    let UI_TESTING = true
    
    var dataManager: DataManagerProtocol!
    
    // Bluetooth
    let scannerCBUUID = CBUUID(string: "0x1812")
    var centralManager: CBCentralManager!
    var scannerPeripheral: CBPeripheral!
    
    override func willActivate() {
        super.willActivate()
        
        self.dataManager = self.UI_TESTING ? MockDataManager() : DataManager()
        self.setupBluetooth()
    }
    
    override var body: LoginView {
        return LoginView(delegate: self)
    }
    
}

extension HostingController: LoginDelegate {
    func loginPressed(username: String, password: String, completion: @escaping (_ success: Bool, _ pick: PickModel?) -> Void) {
        let failureCompletion: () -> Void = { () in
            completion(false, nil)
        }
        
        let pickCompletion: (PickModel?) -> Void = { pick in
            if let pick = pick {
                completion(true, pick)
            } else {
                failureCompletion()
            }
        }
        
        let loginCompletion: (Bool) -> Void = { success in
            if success {
                self.dataManager.getNextPick { pick in
                    pickCompletion(pick)
                }
            } else {
                failureCompletion()
            }
        }
        
        self.dataManager.login(with: username, and: password, completion: loginCompletion)
    }
    
    func bluetoothScanPressed() {
        self.scanForPeripherals()
    }
}

// MARK: - Bluetooth
extension HostingController: CBCentralManagerDelegate {

    func setupBluetooth() {

        self.centralManager = CBCentralManager(delegate: self, queue: nil)

    }

    func scanForPeripherals() {

//        self.centralManager.scanForPeripherals(withServices: [self.scannerCBUUID])
        self.centralManager.scanForPeripherals(withServices: nil)

    }

    private func scan(from characteristic: CBCharacteristic) -> String {
        guard let characteristicData = characteristic.value else { return "" }
        let byteArray = [UInt8](characteristicData)

        let firstBitValue = byteArray[0] & 0x01
        if firstBitValue == 0 {
//            return byteArray[1]
        } else {
//            return byteArray[1] << 8 + byteArray[2]
        }
        return ""
    }

    private func onScanReceived(_ scan: String) {
        print("Scanned: \(scan)")
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {

        switch central.state {
            case .unknown:
                print("central.state is .unknown")
            case .resetting:
                print("central.state is .resetting")
            case .unsupported:
                print("central.state is .unsupported")
            case .unauthorized:
                print("central.state is .unauthorized")
            case .poweredOff:
                print("central.state is .poweredOff")
            case .poweredOn:
                print("central.state is .poweredOn")
//                self.scanForPeripherals()
            default:
                ()
        }

    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print(peripheral)
        print(peripheral.services)
        print(advertisementData)
        print(RSSI)
        self.scannerPeripheral = peripheral
        self.scannerPeripheral.delegate = self
        self.centralManager.stopScan()
        self.centralManager.connect(self.scannerPeripheral)
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("connected!")
        self.scannerPeripheral.discoverServices(nil)
    }

}

extension HostingController: CBPeripheralDelegate {

    @nonobjc func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        for service in services {
            print(service)
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }

    @nonobjc func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        for characteristic in characteristics {
            print(characteristic)

            if characteristic.properties.contains(.read) {
                print("\(characteristic.uuid) containes read")
                peripheral.readValue(for: characteristic)
            }
            if characteristic.properties.contains(.notify) {
                print("\(characteristic.uuid) containes notify")
                peripheral.setNotifyValue(true, for: characteristic)
            }
        }
    }

    @nonobjc func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        switch characteristic.uuid {
            case self.scannerCBUUID:
                let scan = self.scan(from: characteristic)
                self.onScanReceived(scan)
                print(characteristic.value ?? "no value")
            default:
                print("unhandled characteristic, UUID: \(characteristic.uuid)")
        }
    }

}
