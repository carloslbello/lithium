function renderBattery(height, percentage, charging, low, lpm, color) {
    var radius = Math.round(height * 4 / 5) / 2,
        lineWidth = Math.floor(height / 20),
        size = radius * 2 + lineWidth,
        canvas = document.createElement("canvas"),
        context = canvas.getContext("2d"),
        colorString = color.join(),
        halfSize = size/2,
        fontHeight = radius,
        pi = Math.PI;
    if(percentage == 100) fontHeight = Math.round(height * 3 / 5) / 2;
    canvas.width = size;
    canvas.height = size;
    context.lineWidth = lineWidth;
    context.strokeStyle = "rgba(" + colorString + ",0.3)";
    if(low) context.strokeStyle = "rgba(255,59,48,0.3)";
    if(lpm) context.strokeStyle = "rgba(255,204,1,0.3)";
    if(charging) context.strokeStyle = "rgba(76,217,100,0.3)";
    context.arc(halfSize, halfSize, radius, 0, pi * 2);
    context.stroke();
    context.strokeStyle = "rgb(" + colorString + ")";
    if(low) context.strokeStyle = "#FF3B30";
    if(lpm) context.strokeStyle = "#FFCC01";
    if(charging) context.strokeStyle = "#4CD964";
    context.fillStyle = context.strokeStyle;
    context.beginPath();
    context.arc(halfSize, halfSize, radius, pi * (((100 - percentage) / 50) - 0.5), pi * 1.5);
    context.stroke();
    context.font = fontHeight + "pt Helvetica Neue";
    context.textAlign = "center";
    context.textBaseline = "middle";
    context.fillText(percentage, halfSize, halfSize);
    return canvas.toDataURL("image/png");
}
