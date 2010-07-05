Drawing = {
    init: function(elements) {
        $(elements).each(function(index, canvas) {
           if(canvas.getContext !== null) {
               canvas.drawing = false;
               var ctx = canvas.getContext('2d');

               var getxy = function(e) {
                   var result = {};
                   
                   // result.x = e.offsetX;
                   // result.y = e.offsetY;
                   // debugger;
                   
                   if (e.layerX !== undefined) {
                       result.x = e.layerX - canvas.offsetLeft;
                       result.y = e.layerY - canvas.offsetTop;
                   } else if (e.offsetX !== undefined) {
                        result.x = e.offsetX;
                        result.y = e.offsetY;
                   }
                   
                   // debugger

                   return result;
               };

               canvas.on_mousedown = function(e) {
                 ctx.beginPath();
                 ctx.moveTo(getxy(e).x, getxy(e).y);
                 canvas.drawing = true;
               };
               canvas.on_mousemove = function(e) {
                   if(canvas.drawing) {
                       ctx.lineTo(getxy(e).x, getxy(e).y);
                       ctx.stroke();
                   }
               };
               canvas.on_mouseup = function(e) {
                   canvas.drawing = false;
               };
               canvas.addEventListener('mousedown', canvas.on_mousedown, false);
               canvas.addEventListener('mousemove', canvas.on_mousemove, false);
               canvas.addEventListener('mouseup', canvas.on_mouseup, false);
           }
            
        });
        
    },
};

