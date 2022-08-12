/**
*  Description     :  Inserts and updates the records on automobile sensors and avoid the duplicate records and send the mail
*                     of the users of successful record or unsuccessful records
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  08/12/2022
*
*  Revision Logs   :    V1.0 - Created - jay Chand Yadav
**/
public class OpportunityTriggerHandler {
    
    // Insertion and updation the record on the Automobiles objects
    public static void fillRecordOnAutomobilesObjects(List<Opportunity> newList) {
        
        // Retreive Automobile Sensor old record
        Map<String, Automobile_Sensor__c> oldMapSensor = new Map<String, Automobile_Sensor__c> ();
        List<Automobile_Sensor__c> listOfSensor = new List<Automobile_Sensor__c>([Select Id, Name, Account__c, Opportunity__c From Automobile_Sensor__c ]);
        for(Automobile_Sensor__c sensor : listOfSensor){
            oldMapSensor.put(sensor.Name, sensor);
        }
        // Retreive Automobile Presence Sensor old record
        Map<String, Automobile_Presence_Sensor__c> oldMapPresence = new Map<String, Automobile_Presence_Sensor__c>();
        List<Automobile_Presence_Sensor__c> listOfPresence = new List<Automobile_Presence_Sensor__c>([Select Id, Name, Account__c, Opportunity__c From Automobile_Presence_Sensor__c]);
        for(Automobile_Presence_Sensor__c Presence : listOfPresence){
            oldMapPresence.put(Presence.Name, Presence);
        }
        // Retreive Automobile TDU Sensor old record
        Map<String, Automobile_TDU__c> oldMapTDU = new Map<String, Automobile_TDU__c>();
        List<Automobile_TDU__c> listOfTDU = new List<Automobile_TDU__c>([Select Id, Name, Account__c, Opportunity__c From Automobile_TDU__c]);
        for(Automobile_TDU__c tdu : listOfTDU){
            oldMapTDU.put(tdu.Name, tdu);
        }
        // Retreive Automobile Tag Sensor old record
        Map<String, Automobile_Tag__c> oldMapTag = new Map<String, Automobile_Tag__c>();
        List<Automobile_Tag__c> listOfTag = new List<Automobile_Tag__c>([Select Id, Name, Account__c, Opportunity__c From Automobile_Tag__c]);
        for(Automobile_Tag__c tag : listOfTag){
            oldMapTag.put(tag.Name, tag);
        }
        // Maps Hold the new records
        Map<String, Automobile_Sensor__c> mapOfSensor = new Map<String, Automobile_Sensor__c>();
        Map<String, Automobile_Presence_Sensor__c> mapOfPresence = new Map<String, Automobile_Presence_Sensor__c>();
        Map<String, Automobile_TDU__c> mapOfTDU = new Map<String, Automobile_TDU__c>();
        Map<String, Automobile_Tag__c> mapOfTag = new Map<String, Automobile_Tag__c>();
        // Lists Hold the update records
        List<Automobile_Sensor__c> updateSensor = new List<Automobile_Sensor__c>();
        List<Automobile_Presence_Sensor__c> updatePresence = new List<Automobile_Presence_Sensor__c>();
        List<Automobile_TDU__c> updateTDU = new List<Automobile_TDU__c>();
        List<Automobile_Tag__c> updateTag = new List<Automobile_Tag__c>();
        Set<String> namesOfReturnHQ = new Set<String>();
        Set<String> invalidSensor = new Set<String>();
        Set<String> alreadyExistSensors = new Set<String>();
        for(Opportunity opp : newList){   
            // For Shipped To Customer Stage & Return to Customer Stage      
            if(opp.StageName == 'Shipped To Customer' || opp.StageName == 'Return to Customer'){
                Set<String> setOfTags = new Set<String>();
                if(opp.Automobile_Tag_Details_1__c != null){
                    for(String str : opp.Automobile_Tag_Details_1__c.split('\n')){
                        setOfTags.add(str.trim());
                    }
                }
                if(opp.Automobile_Tag_Details_2__c != null){
                    for(String str : opp.Automobile_Tag_Details_2__c.split('\n')){
                        setOfTags.add(str.trim());
                    }
                }
                if(opp.Automobile_Tag_Details_3__c != null){
                    for(String str : opp.Automobile_Tag_Details_3__c.split('\n')){
                        setOfTags.add(str.trim());
                    }
                }                
                if(setOfTags != null){
                    for(String str : setOfTags){
                        Automobile_Sensor__c sensorObj = new Automobile_Sensor__c();
            			Automobile_Presence_Sensor__c presenceObj = new Automobile_Presence_Sensor__c();
            			Automobile_TDU__c objOfTDU = new Automobile_TDU__c();
            			Automobile_Tag__c tagObj = new Automobile_Tag__c();
                        
                        if(str.length() > 18){
                            str = str.Substring(0,18);
						}                                               
                        if(str.startsWith('00:11:CE:00')){                            
                            sensorObj.Name = str;
                            sensorObj.Account__c = opp.AccountId;
                            sensorObj.Opportunity__c = opp.Id;        
                            //Insert the record on automobile sensor object if stage is Shipped To Customer OR Return to Customer                                            
                            if(!oldMapSensor.containsKey(sensorObj.Name)){
                                if(!mapOfSensor.containsKey(sensorObj.Name)){
                                    mapOfSensor.put(sensorObj.Name, sensorObj);
                                }
                            }
                            // Update the record of account on automobile sensor if stage is return to customer
                            else if(oldMapSensor.containsKey(sensorObj.Name) && opp.StageName == 'Return to Customer' && oldMapSensor.get(sensorObj.Name).Account__c == opp.Shipment_Account__c){
                                Automobile_Sensor__c  record = oldMapSensor.get(sensorObj.Name) ;
                                record.Name = sensorObj.Name;
                                record.Account__c = opp.AccountId;
                                record.Opportunity__c = opp.Id;
                                updateSensor.add(record);
                                
                            }  
                            else if(oldMapSensor.containsKey(sensorObj.Name)){
                                alreadyExistSensors.add(sensorObj.Name);
                            }
                        }
                        else if(str.startsWith('00:11:CE:D')){
                            presenceObj.Account__c = opp.AccountId;
                            presenceObj.Opportunity__c = opp.Id;
                            presenceObj.Name = str;
                            //Insert the record on automobile presence sensor object if stage is Shipped To Customer OR Return to Customer                           
                            if(!oldMapPresence.containsKey(presenceObj.Name)){
                                if(!mapOfPresence.containsKey(presenceObj.Name)){
                                    mapOfPresence.put(presenceObj.Name, presenceObj);
                                }
                            }
                            // Update the record of account on automobile presence sensor if stage is return to customer
                            else if(oldMapPresence.containsKey(presenceObj.Name) && opp.StageName == 'Return to Customer' && oldMapPresence.get(presenceObj.Name).Account__c == opp.Shipment_Account__c){
                                Automobile_Presence_Sensor__c  record = oldMapPresence.get(presenceObj.Name) ;
                                record.Name = presenceObj.Name;
                                record.Account__c = opp.AccountId;
                                record.Opportunity__c = opp.Id;
                                updatePresence.add(record);
                             
                            }   
                            else if(oldMapPresence.containsKey(presenceObj.Name)){
                                alreadyExistSensors.add(presenceObj.Name);
                            }
                        }
                        else if(str.startsWith('00:11:CE:E')){
                            objOfTDU.Name = str;
                            objOfTDU.Account__c = opp.AccountId;
                            objOfTDU.Opportunity__c = opp.Id;
                            //Insert the record on automobile tdu object if stage is Shipped To Customer OR Return to Customer 
                            if(!oldMapTDU.containsKey(objOfTDU.Name)){
                                if(!mapOfTDU.containsKey(objOfTDU.Name)){
                                    mapOfTDU.put(objOfTDU.Name, objOfTDU);
                                }
                            }
                            // Update the record of account on automobile TDU if stage is return to customer
                            else if(oldMapTDU.containsKey(objOfTDU.Name) && opp.StageName == 'Return to Customer' && oldMapTDU.get(objOfTDU.Name).Account__c == opp.Shipment_Account__c){
                                Automobile_TDU__c  record = oldMapTDU.get(objOfTDU.Name) ;
                                record.Name = objOfTDU.Name;
                                record.Account__c = opp.AccountId;
                                record.Opportunity__c = opp.Id;
                                updateTDU.add(record);
                              
                            }
                            else if(oldMapTDU.containsKey(objOfTDU.Name)){
                                alreadyExistSensors.add(objOfTDU.Name);
                            }                            
                        }
                        else{                                                                           
                            if(str.substring(0, 3).isNumeric()){                           
								tagObj.Name = str;
                                tagObj.Opportunity__c = opp.Id;
                                tagObj.Account__c = opp.AccountId;
                                //Insert the record on automobile tag object if stage is Shipped To Customer OR Return to Customer 
                                if(!oldMapTag.containsKey(tagObj.Name)){
                                    if(!mapOfTag.containsKey(tagObj.Name)){
                                        mapOfTag.put(tagObj.Name, tagObj);
                                    }
                                }
                                // Update the record of account on automobile Tag if stage is return to customer
                                else if(oldMapTag.containsKey(tagObj.Name) && opp.StageName == 'Return to Customer'  && opp.StageName == 'Return to Customer' && oldMapTag.get(tagObj.Name).Account__c == opp.Shipment_Account__c){
                                    Automobile_Tag__c  record = oldMapTag.get(tagObj.Name) ;
                                    record.Name = tagObj.Name;
                                    record.Account__c = opp.AccountId;
                                    record.Opportunity__c = opp.Id;
                                    updateTag.add(record);                                
                                }
                                else if(oldMapTag.containsKey(tagObj.Name)){
                                	alreadyExistSensors.add(tagObj.Name);
                            	}
                            }
                            else{
                                invalidSensor.add(str);
                            }
                        }
                    }
                }           
            }
           // Return to HQ
            else if(opp.StageName == 'Return to HQ'){           
               if(opp.Return_To_HQ__c != null){   
                    Set<String> setOfHQ = new Set<String>();                   
                    for(String str : opp.Return_To_HQ__c.split('\n')){
                        setOfHQ.add(str.trim());
                    }         
                    for(String str : setOfHQ){                        
                        if(str.length() > 18){                       
                            str = str.Substring(0,18);
						}                       
                        if(str.startsWith('00:11:CE:00')){                        
                            if(oldMapSensor.containsKey(str)){
                                Automobile_Sensor__c  record = oldMapSensor.get(str) ;
                                record.Name = str;
                                record.Account__c = opp.Shipment_Account__c;
                                record.Opportunity__c = opp.Id;
                                updateSensor.add(record);
                                namesOfReturnHQ.add(str);
                            }
                        }
                        else if(str.startsWith('00:11:CE:D')){                        
                            if(oldMapPresence.containsKey(str)){
                                Automobile_Presence_Sensor__c  record = oldMapPresence.get(str) ;
                                record.Name = str;
                                record.Account__c = opp.Shipment_Account__c;
                                record.Opportunity__c = opp.Id;
                                updatePresence.add(record);
                                namesOfReturnHQ.add(str);
                            } 
                        }
                        else if(str.startsWith('00:11:CE:E')){                       
                            if(oldMapTDU.containsKey(str)){
                                Automobile_TDU__c  record = oldMapTDU.get(str) ;
                                record.Name = str;
                                record.Account__c = opp.Shipment_Account__c;
                                record.Opportunity__c = opp.Id;
                                updateTDU.add(record);
                                namesOfReturnHQ.add(str);
                            }
                        }
                        else{                                                                           
                            if(str.substring(0, 3).isNumeric()){                           
                                if(oldMapTag.containsKey(str)){
                                    Automobile_Tag__c  record = oldMapTag.get(str) ;
                                    record.Name = str;
                                    record.Account__c = opp.Shipment_Account__c;
                                    record.Opportunity__c = opp.Id;
                                    updateTag.add(record);
                                    namesOfReturnHQ.add(str);
                                }
                            }
                        }
                    }
            	}
            }           
        }
        // Insert
        if(!mapOfSensor.values().isEmpty()){
            insert mapOfSensor.values();       
        }
        if(!mapOfPresence.values().isEmpty()){
            insert mapOfPresence.values();
        }
        if(!mapOfTDU.values().isEmpty()){
            insert mapOfTDU.values();
        }
        if(!mapOfTag.values().isEmpty()){
            insert mapOfTag.values();
        }
        // update
        if(!updateSensor.isEmpty()){
            update updateSensor;
        }
        if(!updatePresence.isEmpty()){
            update updatePresence;
        }
        if(!updateTDU.isEmpty()){
            update updateTDU;
        }
        if(!updateTag.isEmpty()){
            update updateTag;
        }  
        // Store all names of new record sensor, presence, tdu and tag
        Set<String> namesOfInsertTags = new Set<String>();
        
        if(!mapOfSensor.isEmpty()){
            namesOfInsertTags.addAll(mapOfSensor.keySet());
        } 
        if(!mapOfPresence.isEmpty()){
            namesOfInsertTags.addAll(mapOfPresence.keySet());
        } 
        if(!mapOfTDU.isEmpty()){
            namesOfInsertTags.addAll(mapOfTDU.keySet());
        } 
        if(!mapOfTag.isEmpty()){
            namesOfInsertTags.addAll(mapOfTag.keySet());
        } 
        // Update records fill on set
        Set<String> namesOfUpdateTags = new Set<String>();
        if(!updateSensor.isEmpty()){
            for(Automobile_Sensor__c sensor : updateSensor){
                namesOfUpdateTags.add(sensor.name);
            }
        }
        if(!updatePresence.isEmpty()){
            for(Automobile_Presence_Sensor__c presence : updatePresence){
                namesOfUpdateTags.add(presence.name);
            }
        }
        if(!updateTDU.isEmpty()){
            for(Automobile_TDU__c tdu : updateTDU){
                namesOfUpdateTags.add(tdu.name);
            }
        }
        if(!updateTag.isEmpty()){
            for(Automobile_Tag__c tag : updateTag){
                namesOfUpdateTags.add(tag.name);
            }
        }
        // Send the mail of the user with successful records and unsuccessful records.
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        List<String> sendTo = new List<String>();
        sendTo.add('jaychand.yadav@fexle.com');
        mail.setToAddresses(sendTo);
	Integer count = 0; 
        mail.setSubject(newList.get(count).name + ' ' + Date.today().format());
        String body = '';
        body = '<table border="1" style="border-collapse: collapse"><caption style="font-weight:bold;text-align: left;">Successful:<br/><br/></caption><tr><th>Automobile Type</th><th>Name</th><th>Message</th></tr>';                  
        Account nameOfInstallationAcc = new Account();
        Account nameOfShipmentAcc = new Account();
        if(newList.get(count).AccountId != null){
            nameOfInstallationAcc = [Select Name From Account Where Id =: newList.get(count).AccountId];
        }
        if(newList.get(count).Shipment_Account__c != null){
            nameOfShipmentAcc = [Select Name From Account Where Id =: newList.get(count).Shipment_Account__c];
        }
        if(!namesOfInsertTags.isEmpty()){
            for(String names : namesOfInsertTags){                   
                if(names.startsWith('00:11:CE:00')){
                    body += '<tr><td>'+ '&nbsp;' + 'Sensor' + '&nbsp;'  +'</td><td>' + '&nbsp;' + names + '&nbsp;' + '</td><td>' +  '&nbsp;&nbsp; Sensor inserted under installation account ' + nameOfInstallationAcc.name + '&nbsp;' +'</td></tr>';
                }
                else if(names.startsWith('00:11:CE:D')){
                    body += '<tr><td>'+ '&nbsp;' + 'Presence Sensor' + '&nbsp;'  +'</td><td>' + '&nbsp;'  + names + '&nbsp;' + '</td><td>' +  '&nbsp;&nbsp; Presence Sensor inserted under installation account ' + nameOfInstallationAcc.name + '&nbsp;' +'</td></tr>';
                }
                else if(names.startsWith('00:11:CE:E')){
                    body += '<tr><td>'+ '&nbsp;' + 'TDU' + '&nbsp;'  +'</td><td>'+ '&nbsp;' + names + '&nbsp;' + '</td><td>' +  '&nbsp;&nbsp; TUD inserted under installation account ' + nameOfInstallationAcc.name + '&nbsp;' +'</td></tr>';
                }
                else{
                    body += '<tr><td>'+ ' &nbsp;' + 'Tag' + '&nbsp;'  +'</td><td>' + '&nbsp;' + names + '&nbsp;' + '</td><td>' +  '&nbsp;&nbsp; Tag inserted under installation account ' + nameOfInstallationAcc.name + '&nbsp;'  +'</td></tr>';
                }           
            }
        }
        if(!namesOfUpdateTags.isEmpty()){
            for(String names : namesOfUpdateTags){ 
                if(!namesOfReturnHQ.contains(names)){
                    if(names.startsWith('00:11:CE:00')){
                        body += '<tr><td>'+ '&nbsp;' + 'Sensor' + '&nbsp;'  +'</td><td>' + '&nbsp; ' + names + '&nbsp;' + '</td><td>' +  '&nbsp;&nbsp; Sensor is moved from shipment account ' +  nameOfShipmentAcc.name +  ' to installation account ' + nameOfInstallationAcc.name + '&nbsp;' +'</td></tr>';
                    }
                    else if(names.startsWith('00:11:CE:D')){
                        body += '<tr><td>'+ '&nbsp;' + 'Presence Sensor' + '&nbsp;'  +'</td><td>' + '&nbsp;' + names + '&nbsp;' + '</td><td>' +  '&nbsp;&nbsp; Presence sensor is moved from shipment account ' +  nameOfShipmentAcc.name +  ' to installation account ' + nameOfInstallationAcc.name + '&nbsp;' +'</td></tr>';
                    }
                    else if(names.startsWith('00:11:CE:E')){
                        body += '<tr><td>'+ ' &nbsp;' + 'TDU' + ' &nbsp;'  +'</td><td>' + '&nbsp; ' + names + '&nbsp;' + '</td><td>' +  '&nbsp;&nbsp; TDU is moved from shipment account ' +  nameOfShipmentAcc.name +  ' to installation account ' + nameOfInstallationAcc.name + '&nbsp;' +'</td></tr>';
                    }
                    else{
                        body += '<tr><td>'+ '&nbsp;' + 'Tag' + '&nbsp;'  +'</td><td>' + '&nbsp;' + names + '&nbsp;' + '</td><td>' +  '&nbsp;&nbsp; Tag is moved from shipment account ' +  nameOfShipmentAcc.name +  ' to installation account ' + nameOfInstallationAcc.name + '&nbsp;' +'</td></tr>';
                    } 
                }
            }
    	}
        if(!namesOfReturnHQ.isEmpty()){
            for(String names : namesOfReturnHQ){             
                if(names.startsWith('00:11:CE:00')){
                    body += '<tr><td>'+ '&nbsp;' + 'Sensor' + '&nbsp;'  +'</td><td>' + '&nbsp;' + names +  '&nbsp;'  + '</td><td>' +  '&nbsp;&nbsp; Sensor is moved from installation account ' +  nameOfInstallationAcc.name +  ' to shipment account ' + '&nbsp;' + '</td></tr>';
                }
                else if(names.startsWith('00:11:CE:D')){
                    body += '<tr><td>'+ '&nbsp;' + 'Presence Sensor' + '&nbsp;'  +'</td><td>' + '&nbsp;' + names + '&nbsp;' + '</td><td>' +  '&nbsp;&nbsp; Presence sensor is moved from installation account ' +  nameOfInstallationAcc.name +  ' to shipment account ' + '&nbsp;' +'</td></tr>';
                }
                else if(names.startsWith('00:11:CE:E')){
                    body += '<tr><td>'+ ' &nbsp;' + 'TDU' + ' &nbsp;'  +'</td><td>' + '&nbsp;' + names + '&nbsp;' + '</td><td>' +  '&nbsp;&nbsp; TDU is moved from installation account ' +  nameOfInstallationAcc.name +  ' to shipment account' + '&nbsp;' +'</td></tr>';
                }
                else{
                    body += '<tr><td>'+ '&nbsp;' + 'Tag' + '&nbsp;'  +'</td><td>' + '&nbsp;' + names + '&nbsp;' + '</td><td>' +  '&nbsp;&nbsp; Tag is moved from installation account ' +  nameOfInstallationAcc.name +  ' to shipment account ' + '&nbsp;'  +'</td></tr>';
                }  
            }
        }
        body += '</table>';
        String body1 = '';
        body1 = '<br/><br/><br/><table border="1" style="border-collapse: collapse"><caption style="font-weight:bold;text-align: left;">Unsuccessful:<br/><br/></caption><tr><th>Automobile Type</th><th>Name</th><th>Message</th></tr>';  
        if(!invalidSensor.isEmpty()){
            for(String invalidNames : invalidSensor){
                body1 += '<tr><td>'+ '&nbsp;' + 'Sensor' + '&nbsp;'  +'</td><td>' + '&nbsp;' + invalidNames + '&nbsp;' + '</td><td>' +  '&nbsp;&nbsp; Invalid sensor  ' + '&nbsp;' +'</td></tr>';
            }
        }
        if(!alreadyExistSensors.isEmpty()){
            for(String names : alreadyExistSensors){
                if(names.startsWith('00:11:CE:00')){
                    body1 += '<tr><td>'+ '&nbsp;' + 'Sensor' + '&nbsp;'  +'</td><td>' + '&nbsp;' + names + ' &nbsp;' + '</td><td>' +  '&nbsp;&nbsp; Sensor can’t inserted under installation account '  +  nameOfInstallationAcc.name +  ' b/c it is already exists under the installation account. ' + nameOfShipmentAcc.name + '&nbsp; ' +'</td></tr>';
                }
                else if(names.startsWith('00:11:CE:D')){
                    body1 += '<tr><td>'+ '&nbsp; ' + 'Presence Sensor' + '&nbsp;'  +'</td><td>' + '&nbsp; ' + names + '&nbsp;' + '</td><td>' +  '&nbsp;&nbsp; Presence sensor can’t inserted under installation account ' +  nameOfInstallationAcc.name +  ' b/c it is already exists under the installation account. ' + nameOfShipmentAcc.name + '&nbsp;' +'</td></tr>';
                }
                else if(names.startsWith('00:11:CE:E')){
                    body1 += '<tr><td>'+ '&nbsp;' + 'TDU' + '&nbsp;'  +'</td><td>' + '&nbsp;' + names + '&nbsp;' + '</td><td>' +  '&nbsp;&nbsp; TDU can’t inserted under installation account ' +  nameOfInstallationAcc.name +  ' b/c it is already exists under the installation account. ' + nameOfShipmentAcc.name + '&nbsp;' +'</td></tr>';
                }
                else{
                    body1 += '<tr><td>'+ '&nbsp;' + 'Tag' + '&nbsp;'  +'</td><td>' + '&nbsp;' + names + '&nbsp;' + '</td><td>' +  '&nbsp; &nbsp; Tag can’t inserted under installation account ' +  nameOfInstallationAcc.name +  ' b/c it is already exists under the installation account. ' + nameOfShipmentAcc.name + '&nbsp;' +'</td></tr>';
                } 
            }
        }
        body +=  body1;
        mail.setHtmlBody(body);
        mails.add(mail);
        Messaging.sendEmail(mails);
    }
}