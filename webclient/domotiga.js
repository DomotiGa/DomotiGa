// DomotiGa - an open source home automation program
// Copyright(C) 2008-2009 Ron Klinkien

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General PUBLIC License for more details.

// You should have received a copy of the GNU General PUBLIC License
// along with this program. If not, see <http://www.gnu.org/licenses/>.

var flashcolor = '#00CC00';
var flashtime = 2000;
var ie4=document.all;
var browser = navigator.appName;

function get_ajax_tags( ) {
   if (ie4 && browser != "Opera") {
      var elem = document.body.getElementsByTagName('div');
      var lookfor = 'className';
   } else {
      var elem = document.getElementsByTagName('div');
      var lookfor = 'class';
   }
      var arr = new Array();
      var iarr = 0;
      for(var i = 0; i < elem.length; i++) {
         var att = elem[i].getAttribute(lookfor);
         if(att == 'datacol' || att == 'datacollast') {
            arr[iarr] = elem[i];
            iarr++;
         }
      }
      return arr;
}

function reset_ajax_color(usecolor) {
   var elements = get_ajax_tags();
   var numelements = elements.length;
   for (var index=0;index!=numelements;index++) {
      var element = elements[index];
      element.style.color=usecolor;
   }
}

function startajax(view) {
   var req = null;

   // Reset the flash colors
   reset_ajax_color('');

   if (window.XMLHttpRequest) {
      req = new XMLHttpRequest();
      if (req.overrideMimeType) {
         req.overrideMimeType('text/txt');
      }
   } else if (window.ActiveXObject) {
      try {
         req = new ActiveXObject("Msxml2.XMLHTTP");
      } catch (e) {
         try {
            req = new ActiveXObject("Microsoft.XMLHTTP");
         } catch (e) {}
      }
   }

   req.onreadystatechange = function() {
      if(req.readyState == 4) {
         if(req.status == 200) {
            resp = eval( "(" + req.responseText + ")" );
            i=0;
            while (i < resp.total) {
               div = eval ("resp.change"+i+"['div']");
               val = eval ("resp.change"+i+"['val']");
               if (!document.getElementById(div)) {
                  document.location='index.php?reload=1';
               }
               document.getElementById(div).innerHTML = "&nbsp;" + val;
               document.getElementById(div).style.color = flashcolor;
               i+=1;
            }
         } else {
            document.write="Javascript Ajax Error: returned status code " + req.status + " " + req.statusText;
         }
      }
   };
   req.open("GET", "json.php?view="+view, true);
   req.send(null);
}

function clock()  {
   var months=new Array(" ","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");
   var digital = new Date();
   var hours = digital.getHours();
   var minutes = digital.getMinutes();
   var da = digital.getDate();
   var mo = months[digital.getMonth()+1];
   var ye = digital.getFullYear()

   if (minutes <= 9) minutes = "0" + minutes;
   dispTime = da + "-" + mo + "-" + ye + "  " + hours + ":" + minutes;
   document.getElementById('digitalclock').innerHTML = dispTime;
   setTimeout("clock()", 1000);
}
