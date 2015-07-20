function renderBattery(height, percentage, charging, low, color) {
    var emptyBarCanvas = document.createElement("canvas"),
        emptyBarContext = emptyBarCanvas.getContext("2d"),
        emptyBarData,
        fullBarCanvas = document.createElement("canvas"),
        fullBarContext = fullBarCanvas.getContext("2d"),
        fullBarData,
        finalCanvas = document.createElement("canvas"),
        finalContext = finalCanvas.getContext("2d"),
        barWidth = 2 + height / 4,
        barHeight = 2 + height / 2,
        radius = height / 8,
        horizontalPadding = Math.ceil(height / 16),
        totalWidth = barWidth * 5 + horizontalPadding * 4,
        colorString = "rgb(" + color.join() + ")",
        barData;
    finalCanvas.width = totalWidth;
    finalCanvas.height = barHeight;
    emptyBarCanvas.width = barWidth;
    emptyBarCanvas.height = barHeight;
    fullBarCanvas.width = barWidth;
    fullBarCanvas.height = barHeight;
    function drawPath(ctx) {
        ctx.beginPath();
        ctx.arc(barWidth / 2, barHeight - radius - 1, radius, 0, Math.PI);
        ctx.lineTo(1, radius + 1);
        ctx.arc(barWidth / 2, radius + 1, radius, Math.PI, 0);
        ctx.lineTo(barWidth - 1, barHeight - radius - 1);
        ctx.clip();
        ctx.lineWidth = Math.floor(height / 20);
        ctx.strokeStyle = colorString;
    }
    drawPath(emptyBarContext);
    emptyBarContext.stroke();
    emptyBarData = emptyBarContext.getImageData(0, 0, barWidth, barHeight);
    fullBarContext.fillStyle = colorString;
    if(low) fullBarContext.fillStyle = "#FF3B30";
    if(charging) fullBarContext.fillStyle = "#4CD964";
    drawPath(fullBarContext);
    fullBarContext.fill();
    fullBarContext.stroke();
    fullBarData = fullBarContext.getImageData(0, 0, barWidth, barHeight);
    for(var i = 0; i < 5; i++) {
        if(percentage <= 20 * i)
            barData = emptyBarData;
        else if(percentage >= 20 * (i+1) )
            barData = fullBarData;
        else {
            finalContext.putImageData(fullBarData, i * (barWidth + horizontalPadding), 0);
            barData = emptyBarContext.getImageData(0, 0, barWidth, (barHeight - 6) * (1 - (percentage - (20 * i)) / 20) + 3);
        }
        finalContext.putImageData(barData, i * (barWidth + horizontalPadding), 0);
    }
    return finalCanvas.toDataURL("image/png");
}
