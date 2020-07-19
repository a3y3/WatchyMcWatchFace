using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;

class WatchyMcWatchFaceView extends WatchUi.WatchFace {
	
	const PEN_WIDTH = 1;
	
	var center_x;
	var center_y;
	var radius;
    const PI = Math.PI;

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        var width = dc.getWidth();
        var height = dc.getHeight();
        center_x = width / 2;
        center_y = height / 2;
        radius = width / 2;
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        var clockTime = Sys.getClockTime();
		var minutes = clockTime.min;
		clearScreen(dc);
        
        updateMinuteHand(dc, minutes);
    }
    
    function updateMinuteHand(dc, minutes){
    	var angle_degrees = ((minutes * 6) - 90);
    	var angle_radians = angle_degrees * PI / 180;
    	var x2 = center_x + radius * Math.cos(angle_radians); // parametric circle equation
    	var y2 = center_y + radius * Math.sin(angle_radians);
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

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}
