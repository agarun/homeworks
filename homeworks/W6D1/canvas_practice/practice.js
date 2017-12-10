document.addEventListener("DOMContentLoaded", function () {

});

const canvas = document.getElementById('mycanvas');

canvas.width = 500;
canvas.height = 500;

const ctx = canvas.getContext('2d');

ctx.fillStyle = 'rgb(49, 115, 72)';

ctx.fillRect(0, 0, 500, 500);

ctx.beginPath();

// arc(x, y, radius, startAngle, endAngle, anticlockwise)
ctx.arc(250, 250, 180, 0, 2 * Math.PI);

ctx.lineWidth = 40;

ctx.strokeStyle = 'rgb(189, 176, 140)';
ctx.stroke();

ctx.fillStyle = 'rgb(238, 238, 238)';
ctx.fill();

const canvas2 = document.getElementById('mycanvas2');

canvas2.width = 500;
canvas2.height = 500;

const ctx2 = canvas2.getContext('2d');


ctx2.fillStyle = 'rgb(255, 207, 99)';
ctx2.beginPath();
ctx2.moveTo(200, 200);
ctx2.lineTo(100, 200);
ctx2.lineTo(50, 100);
ctx2.lineTo(250, 100);
ctx2.fill();
ctx2.closePath();

ctx2.fillStyle = 'rgb(255, 255, 255)';
ctx2.beginPath();
ctx2.moveTo(250, 100);
ctx2.lineTo(175, 100);
ctx2.lineTo(200, 125);
ctx2.fill();
ctx2.closePath();

ctx2.beginPath();
ctx2.moveTo(175, 100);
ctx2.lineTo(125, 100);
ctx2.lineTo(150, 125);
ctx2.fill();
ctx2.closePath();

ctx2.beginPath();
ctx2.moveTo(50, 100);
ctx2.lineTo(100, 125);
ctx2.lineTo(125, 100);
ctx2.fill();
ctx2.closePath();
