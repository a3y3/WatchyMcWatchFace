using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Time.Gregorian as Date;


class WatchyMcWatchFaceView extends WatchUi.WatchFace {
    
    const PEN_WIDTH = 1;
    const PI = Math.PI;

    var center_x;
    var center_y;
    var radius;

    function initialize() {
        WatchFace.initialize();
    }

    function onLayout(dc) {
        var width = dc.getWidth();
        var height = dc.getHeight();
        center_x = width / 2;
        center_y = height / 2;
        radius = width / 2;
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    function onUpdate(dc) {
        var clockTime = Sys.getClockTime();
        var minutes = clockTime.min;
        var hours = clockTime.hour;
        
//        clearScreen(dc);
        
        updateMinuteHand(dc, minutes);
        updateHourHand(dc, hours);
        setDateDisplay();
    }
    
    function updateMinuteHand(dc, minutes){
        var angle_degrees = ((minutes * 6) - 90);
        var angle_radians = angle_degrees * PI / 180;
        var x2 = center_x + radius * Math.cos(angle_radians); // parametric circle equation
        var y2 = center_y + radius * Math.sin(angle_radians);
        drawGenericLine(dc, center_x, center_y, x2, y2);
    }
    
    function updateHourHand(dc, hours){
        var angle_degrees = ((hours * 30) - 90);
        var angle_radians = angle_degrees * PI / 180;
        var x2 = center_x + (radius / 2) * Math.cos(angle_radians);
        var y2 = center_y + (radius / 2) * Math.sin(angle_radians);
        drawGenericLine(dc, center_x, center_y, x2, y2);
    }
    
    function drawGenericLine(dc, x1, y1, x2, y2){
        dc.setPenWidth(PEN_WIDTH);
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_WHITE);
        dc.drawLine(x1, y1, x2, y2);
    }
    
    function clearScreen(dc){
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_WHITE);
        dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());
    }
    
    function setDateDisplay() {
        var now = Time.now();
	    var date = Date.info(now, Time.FORMAT_LONG);
	    var dateString = Lang.format("$1$ $2$, $3$", [date.month, date.day, date.year]);
	    var dateDisplay = View.findDrawableById("DateDisplay");
	    dateDisplay.setText(dateString);
    }
}
