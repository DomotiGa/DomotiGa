/*** DomotiGa ZAutomation module *********************************************

DomotiGa - an open source home automation program
Copyright (C) Ron Klinkien, The Netherlands.

******************************************************************************/

var cbk = function(type, arg) {
try {
    //console.log("JSON trigger script executed!");
    system("/opt/z-way-server/domotiga-trigger.sh");
  } catch(err) {
    debugPrint("Failed to execute script system call: " + err);
  }
};

function attachToDataHolder(element) {
  element.bind(cbk);
  for (var key in element) {
    if (element[key] && element[key].name !== undefined) {
      // this is a child element - descend inside
      attachToDataHolder(element[key]);
    }
  }
}

//console.log("DomotiGa custom.js script executed!");

for (var devId in zway.devices) {
  var dev = zway.devices[devId];
  attachToDataHolder(dev.data);
  for (var instId in dev.instances) {
    var inst = dev.instances[instId];
    attachToDataHolder(inst.data);
    for (var ccId in inst.commandClasses) {
      var cc = inst.commandClasses[ccId];
      attachToDataHolder(cc.data);
    }
  }
}
