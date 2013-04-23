var pathName = window.location.href;

$(window).load(function () {
/*
        // Conditions for activating menu
	if(pathName.indexOf("weather") != -1){
		$("#menuUL > li:eq(0)").addClass("active");
	}
        else if(pathName.indexOf("graphs") != -1){
		$("#menuUL > li:eq(1)").addClass("active");
	}
        else if(pathName.indexOf("heatings") != -1){
		$("#menuUL > li:eq(2)").addClass("active");
	}
        else if(pathName.indexOf("events") != -1){
		$("#menuUL > li:eq(3)").addClass("active");
	}
        else if(pathName.indexOf("home") != -1){
		$("#navUL > li:eq(0) > a > h5").addClass("active");
	}
        else if(pathName.indexOf("location") != -1){
		$("#navUL > li:eq(1) > a > h5").addClass("active");
	}
        else if(pathName.indexOf("devices") != -1){
		$("#navUL > li:eq(2) > a > h5").addClass("active");
	}
        else if(pathName.indexOf("filter") != -1){
		$("#navUL > li:eq(3) > a > h5").addClass("active");
	}
*/
});

$(function() {
    $("#buttonBack").hover(function () {
        if($("#popBack").hasClass("showPop")){
            $("#popBack").removeClass("showPop");
            $("#popBack").addClass("hidePop");
        }
        else{
            $("#popBack").addClass("showPop");
            $("#popBack").removeClass("hidePop");
        }
    });
});
$(function() {
    $("#buttonEquipment").hover(function () {
        if($("#popEquipment").hasClass("showPop")){
            $("#popEquipment").removeClass("showPop");
            $("#popEquipment").addClass("hidePop");
        }
        else{
            $("#popEquipment").addClass("showPop");
            $("#popEquipment").removeClass("hidePop");
        }
    });
});
$(function() {
    $("#buttonEvent").hover(function () {
        if($("#popEvent").hasClass("showPop")){
            $("#popEvent").removeClass("showPop");
            $("#popEvent").addClass("hidePop");
        }
        else{
            $("#popEvent").addClass("showPop");
            $("#popEvent").removeClass("hidePop");
        }
    });
});
$(function() {
    $("#buttonMeteo").hover(function () {
        if($("#popMeteo").hasClass("showPop")){
            $("#popMeteo").removeClass("showPop");
            $("#popMeteo").addClass("hidePop");
        }
        else{
            $("#popMeteo").addClass("showPop");
            $("#popMeteo").removeClass("hidePop");
        }
    });
});
$(function() {
    $("#buttonGraphs").hover(function () {
        if($("#popGraphs").hasClass("showPop")){
            $("#popGraphs").removeClass("showPop");
            $("#popGraphs").addClass("hidePop");
        }
        else{
            $("#popGraphs").addClass("showPop");
            $("#popGraphs").removeClass("hidePop");
        }
    });
});
$(function() {
    $("#buttonHeating").hover(function () {
        if($("#popHeating").hasClass("showPop")){
            $("#popHeating").removeClass("showPop");
            $("#popHeating").addClass("hidePop");
        }
        else{
            $("#popHeating").addClass("showPop");
            $("#popHeating").removeClass("hidePop");
        }
    });
});
$(function() {
    $("#buttontuileHeating").hover(function () {
        if($("#poptuileHeating").hasClass("showPop")){
            $("#poptuileHeating").removeClass("showPop");
            $("#poptuileHeating").addClass("hidePop");
        }
        else{
            $("#poptuileHeating").addClass("showPop");
            $("#poptuileHeating").removeClass("hidePop");
        }
    });
});
$(function() {
    $("#buttontuileEvent").hover(function () {
        if($("#poptuileEvent").hasClass("showPop")){
            $("#poptuileEvent").removeClass("showPop");
            $("#poptuileEvent").addClass("hidePop");
        }
        else{
            $("#poptuileEvent").addClass("showPop");
            $("#poptuileEvent").removeClass("hidePop");
        }
    });
});
$(function() {
    $("#buttontuileEquipment").hover(function () {
        if($("#poptuileEquipment").hasClass("showPop")){
            $("#poptuileEquipment").removeClass("showPop");
            $("#poptuileEquipment").addClass("hidePop");
        }
        else{
            $("#poptuileEquipment").addClass("showPop");
            $("#poptuileEquipment").removeClass("hidePop");
        }
    });
});

// Devices
function verifyToggle(it){
    if($(it).hasClass('on')){
        $(it).removeClass('on').html('OFF');
       currentToggle = $(it).attr('id');

if ((isNaN(currentToggle) == true) && (currentToggle.lastIndexOf(";;")!=-1 ) )
{
	currentToggle = currentToggle.substring(0,currentToggle.lastIndexOf(";;"));	
	window.location.href ='set_thermostatscenario.php?namethermo='+currentToggle;
} 
else if(isNaN(currentToggle) == true)
{
       window.location.href ='set_device.php?name='+currentToggle+'&action=Off';
} 
else 
{
	window.location.href ='set_eventstate.php?name='+currentToggle+'&action=F';
}
    }
    else{
        $(it).addClass('on').html('ON');
       currentToggle = $(it).attr('id');
 
if ((isNaN(currentToggle) == true) && (currentToggle.lastIndexOf(";;")!=-1 ) )
{
	currentToggle = currentToggle.substring(0,currentToggle.lastIndexOf(";;"));	
	window.location.href ='set_thermostatscenario.php?namethermo='+currentToggle;
}
else if(isNaN(currentToggle) == true)
{
       window.location.href ='set_device.php?name='+currentToggle+'&action=On';
} 
else
{
	window.location.href ='set_eventstate.php?name='+currentToggle+'&action=T';
}
    }
}

$( ".slider" ).slider({
		animate: true,
                range: "min",
                value: 50,
                min: 0,
                max: 100,
		step: 10,
                
		// This gets a live reading of the value and prints it on the page
                slide: function( event, ui ) {
     		  currentToggle = $(this).attr('name');
                    $( "#slider-result"+currentToggle ).html( ui.value );
                },

		// This updates the hidden form field so we can submit the data using a form
                change: function(event, ui) { 
                $('#hidden').attr('value', ui.value);
                }
			
});

$('.slider-button').toggle(function(){  
    verifyToggle(this);
},function(){  
    verifyToggle(this);
});

$('#imgListTiles').change(function(){  
    var second = $("select option:selected").attr('value');
    $("#imgPrev").attr("src","img/tiles/"+second+".png");
});

$('#imgListTabs').change(function(){  
    var second = $("select option:selected").attr('value');
    $("#imgPrev").attr("src","img/tabs/"+second+".png");
});

function setCookie(c_name,value,exdays)
{
    var exdate=new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var c_value=escape(value) + ((exdays==null) ? "" : "; expires="+exdate.toUTCString());
    document.cookie=c_name + "=" + c_value;
}

$('#tilesList').change(function(){
    $("#hiddenbuttonW").show();
    setCookie("tile", $("#tilesList option:selected").attr('value'),1);
});

$('#tabsList').change(function(){
    $("#hiddenbuttonT").show();
    setCookie("tab", $("#tabsList option:selected").attr('value'),1);
});
