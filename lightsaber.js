state = 0

$(document).ready(function(){
	let actionContainer = $("#container");

	window.addEventListener('message',function(event){

		fuel = event.data.fuel
		let item = event.data;
		let amount = event.data.amount;
		let price = event.data.price;
		let tax = event.data.tax;
		let done = event.data.done;
		$('.bar').css('width',(fuel*249)/66);
		switch(item.action){
			case 'showMenu':
				actionContainer.fadeIn(500);
				$('.bar').css('width',(fuel*249)/66);
				$(".price").html('<span>'+price+'</span>');
				$('.visor2').html('<span class="unique">0.00</span>');
				$('.visor1').html('<span class="unique">0.00</span>');
				$('#posto').css('display', 'block');
				$('#frontman').css('display', 'none');
				$('.abastecer').html(`<p>Abastecer<b>`)
			break;

			case 'hideMenu':
				actionContainer.fadeOut(500);
			break;

			case 'frontman':
				actionContainer.fadeIn(500);
				showFrontman(fuel);
			break;

			case 'updateVisor':
				if (!done) {
					$('.abastecer').children().html(`<p>Parar<b>`)
				} else {
					state = 0
					$('.abastecer').children().html(`<p>Abastecer<b>`)
				}
		
				$('.visor2').children().html('<span class="unique">'+(amount/tax).toFixed(2)+'</span>');
				$('.visor1').children().html('<span class="unique">'+amount.toFixed(2)+'</span>');
				$('.bar').css('width',(fuel*249)/66); 
				
			break;
		}
	});

	document.onkeyup = function(data){
		if (data.which == 27){
			sendData("ButtonClick","exit")
			state = 0
			setTimeout(() => {  $('#frontman').css('display', 'none'),$('#posto').css('display', 'none') }, 500);
		}
	};
	function FluidMeter() {
		var context;
		var targetContainer;
	  
		var time = null;
		var dt = null;
	  
		var options = {
		  drawShadow: true,
		  drawText: true,
		  drawPercentageSign: true,
		  drawBubbles: true,
		  fontSize: "35px",
		  fontFillStyle: "white",
		  size: 300,
		  borderWidth: 25,
		  backgroundColor: "#e2e2e2",
		  foregroundColor: "#fafafa"
		};
	  
		var currentFillPercentage = 0;
		var fillPercentage = 0;
	  
		//#region fluid context values
		var foregroundFluidLayer = {
		  fillStyle: "purple",
		  angle: 0,
		  horizontalPosition: 0,
		  angularSpeed: 0,
		  maxAmplitude: 9,
		  frequency: 30,
		  horizontalSpeed: -150,
		  initialHeight: 0
		};
	  
		var backgroundFluidLayer = {
		  fillStyle: "pink",
		  angle: 0,
		  horizontalPosition: 0,
		  angularSpeed: 140,
		  maxAmplitude: 12,
		  frequency: 40,
		  horizontalSpeed: 150,
		  initialHeight: 0
		};
	  
		var bubblesLayer = {
		  bubbles: [],
		  amount: 12,
		  speed: 20,
		  current: 0,
		  swing: 0,
		  size: 2,
		  reset: function (bubble) {
			// calculate the area where to spawn the bubble based on the fluid area
			var meterBottom = (options.size - (options.size - getMeterRadius()) / 2) - options.borderWidth;
			var fluidAmount = currentFillPercentage * (getMeterRadius() - options.borderWidth * 2) / 100;
	  
			bubble.r = random(this.size, this.size * 2) / 2;
			bubble.x = random(0, options.size);
			bubble.y = random(meterBottom, meterBottom - fluidAmount);
			bubble.velX = 0;
			bubble.velY = random(this.speed, this.speed * 2);
			bubble.swing = random(0, 2 * Math.PI);
		  },
		  init() {
			for (var i = 0; i < this.amount; i++) {
	  
			  var meterBottom = (options.size - (options.size - getMeterRadius()) / 2) - options.borderWidth;
			  var fluidAmount = currentFillPercentage * (getMeterRadius() - options.borderWidth * 2) / 100;
			  this.bubbles.push({
				x: random(0, options.size),
				y: random(meterBottom, meterBottom - fluidAmount),
				r: random(this.size, this.size * 2) / 2,
				velX: 0,
				velY: random(this.speed, this.speed * 2)
			  });
			}
		  }
		}
		//#endregion
	  
		/**
		 * initializes and mount the canvas element on the document
		 */
		function setupCanvas() {
		  var canvas = document.createElement('canvas');
		  canvas.width = options.size;
		  canvas.height = options.size;
		  canvas.imageSmoothingEnabled = true;
		  context = canvas.getContext("2d");
		  targetContainer.appendChild(canvas);
	  
		  // shadow is not required  to be on the draw loop
		  //#region shadow
		  if (options.drawShadow) {
			context.save();
			context.beginPath();
			context.filter = "drop-shadow(0px 4px 6px rgba(0,0,0,0.1))";
			context.arc(options.size / 2, options.size / 2, getMeterRadius() / 2, 0, 2 * Math.PI);
			context.closePath();
			context.fill();
			context.restore();
		  }
		  //#endregion
		}
	  
		/**
		 * draw cycle
		 */
		function draw() {
		  var now = new Date().getTime();
		  dt = (now - (time || now)) / 1000;
		  time = now;
	  
		  requestAnimationFrame(draw);
		  context.clearRect(0, 0, options.width, options.height);
		  drawMeterBackground();
		  drawFluid(dt);
		  if (options.drawText) {
			drawText();
		  }
		  drawMeterForeground();
		}
	  
		function drawMeterBackground() {
		  context.save();
		  context.fillStyle = options.backgroundColor;
		  context.beginPath();
		  context.arc(options.size / 2, options.size / 2, getMeterRadius() / 2 - options.borderWidth, 0, 2 * Math.PI);
		  context.closePath();
		  context.fill();
		  context.restore();
		}
	  
		function drawMeterForeground() {
		  context.save();
		  context.lineWidth = options.borderWidth;
		  context.strokeStyle = options.foregroundColor;
		  context.beginPath();
		  context.arc(options.size / 2, options.size / 2, getMeterRadius() / 2 - options.borderWidth / 2, 0, 2 * Math.PI);
		  context.closePath();
		  context.stroke();
		  context.restore();
		}
		/**
		 * draws the fluid contents of the meter
		 * @param  {} dt elapsed time since last frame
		 */
		function drawFluid(dt) {
		  context.save();
		  context.arc(options.size / 2, options.size / 2, getMeterRadius() / 2 - options.borderWidth, 0, Math.PI * 2);
		  context.clip();
		  drawFluidLayer(backgroundFluidLayer, dt);
		  drawFluidLayer(foregroundFluidLayer, dt);
		  if (options.drawBubbles) {
			drawFluidMask(foregroundFluidLayer, dt);
			drawBubblesLayer(dt);
		  }
		  context.restore();
		}
	  
	  
		/**
		 * draws the foreground fluid layer
		 * @param  {} dt elapsed time since last frame
		 */
		function drawFluidLayer(layer, dt) {
		  // calculate wave angle
		  if (layer.angularSpeed > 0) {
			layer.angle += layer.angularSpeed * dt;
			layer.angle = layer.angle < 0 ? layer.angle + 360 : layer.angle;
		  }
	  
		  // calculate horizontal position
		  layer.horizontalPosition += layer.horizontalSpeed * dt;
		  if (layer.horizontalSpeed > 0) {
			layer.horizontalPosition > Math.pow(2, 53) ? 0 : layer.horizontalPosition;
		  }
		  else if (layer.horizontalPosition < 0) {
			layer.horizontalPosition < -1 * Math.pow(2, 53) ? 0 : layer.horizontalPosition;
		  }
	  
		  var x = 0;
		  var y = 0;
		  var amplitude = layer.maxAmplitude * Math.sin(layer.angle * Math.PI / 180);
	  
		  var meterBottom = (options.size - (options.size - getMeterRadius()) / 2) - options.borderWidth;
		  var fluidAmount = currentFillPercentage * (getMeterRadius() - options.borderWidth * 2) / 100;
	  
		  if (currentFillPercentage < fillPercentage) {
			currentFillPercentage += 15 * dt;
		  } else if (currentFillPercentage > fillPercentage) {
			currentFillPercentage -= 15 * dt;
		  }
	  
		  layer.initialHeight = meterBottom - fluidAmount;
	  
		  context.save();
		  context.beginPath();
	  
		  context.lineTo(0, layer.initialHeight);
	  
		  while (x < options.size) {
			y = layer.initialHeight + amplitude * Math.sin((x + layer.horizontalPosition) / layer.frequency);
			context.lineTo(x, y);
			x++;
		  }
	  
		  context.lineTo(x, options.size);
		  context.lineTo(0, options.size);
		  context.closePath();
	  
		  context.fillStyle = layer.fillStyle;
		  context.fill();
		  context.restore();
		}
	  
		/**
		 * clipping mask for objects within the fluid constrains
		 * @param {Object} layer layer to be used as a mask
		 */
		function drawFluidMask(layer) {
		  var x = 0;
		  var y = 0;
		  var amplitude = layer.maxAmplitude * Math.sin(layer.angle * Math.PI / 180);
	  
		  context.beginPath();
	  
		  context.lineTo(0, layer.initialHeight);
	  
		  while (x < options.size) {
			y = layer.initialHeight + amplitude * Math.sin((x + layer.horizontalPosition) / layer.frequency);
			context.lineTo(x, y);
			x++;
		  }
		  context.lineTo(x, options.size);
		  context.lineTo(0, options.size);
		  context.closePath();
		  context.clip();
		}
	  
		function drawBubblesLayer(dt) {
		  context.save();
		  for (var i = 0; i < bubblesLayer.bubbles.length; i++) {
			var bubble = bubblesLayer.bubbles[i];
	  
			context.beginPath();
			context.strokeStyle = 'white';
			context.arc(bubble.x, bubble.y, bubble.r, 2 * Math.PI, false);
			context.stroke();
			context.closePath();
	  
			var currentSpeed = bubblesLayer.current * dt;
	  
			bubble.velX = Math.abs(bubble.velX) < Math.abs(bubblesLayer.current) ? bubble.velX + currentSpeed : bubblesLayer.current;
			bubble.y = bubble.y - bubble.velY * dt;
			bubble.x = bubble.x + (bubblesLayer.swing ? 0.4 * Math.cos(bubblesLayer.swing += 0.03) * bubblesLayer.swing : 0) + bubble.velX * 0.5;
	  
			// determine if current bubble is outside the safe area
			var meterBottom = (options.size - (options.size - getMeterRadius()) / 2) - options.borderWidth;
			var fluidAmount = currentFillPercentage * (getMeterRadius() - options.borderWidth * 2) / 100;
	  
			if (bubble.y <= meterBottom - fluidAmount) {
			  bubblesLayer.reset(bubble);
			}
	  
		  }
		  context.restore();
		}
	  
		function drawText() {
	  
		  var text = options.drawPercentageSign ?
			currentFillPercentage.toFixed(0) + "%" : currentFillPercentage.toFixed(0);
	  
		  context.save();
		  context.font = getFontSize();
		  context.fillStyle = options.fontFillStyle;
		  context.textAlign = "center";
		  context.textBaseline = 'middle';
		  context.filter = "drop-shadow(0px 0px 5px rgba(0,0,0,0.4))"
		  context.fillText(text, options.size / 2, options.size / 2);
		  context.restore();
		}
	  
		//#region helper methods
		function clamp(number, min, max) {
		  return Math.min(Math.max(number, min), max);
		};
		function getMeterRadius() {
		  return options.size * 0.9;
		}
	  
		function random(min, max) {
		  var delta = max - min;
		  return max === min ? min : Math.random() * delta + min;
		}
	  
		function getFontSize() {
		  return options.fontSize + " " + options.fontFamily;
		}
		//#endregion
	  
		return {
		  init: function (env) {
			if (!env.targetContainer)
			  throw "empty or invalid container";
	  
			targetContainer = env.targetContainer;
			fillPercentage = clamp(env.fillPercentage, 0, 100);
	  
			if (env.options) {
			  options.drawShadow = env.options.drawShadow === false ? false : true;
			  options.size = env.options.size;
			  options.drawBubbles = env.options.drawBubbles === false ? false : true;
			  options.borderWidth = env.options.borderWidth || options.borderWidth;
			  options.foregroundFluidColor = env.options.foregroundFluidColor || options.foregroundFluidColor;
			  options.backgroundFluidColor = env.options.backgroundFluidColor || options.backgroundFluidColor;
			  options.backgroundColor = env.options.backgroundColor || options.backgroundColor;
			  options.foregroundColor = env.options.foregroundColor || options.foregroundColor;
	  
			  options.drawText = env.options.drawText === false ? false : true;
			  options.drawPercentageSign = env.options.drawPercentageSign === false ? false : true;
			  options.fontSize = env.options.fontSize || options.fontSize;
			  options.fontFamily = env.options.fontFamily || options.fontFamily;
			  options.fontFillStyle = env.options.fontFillStyle || options.fontFillStyle;
			  // fluid settings
	  
			  if (env.options.foregroundFluidLayer) {
				foregroundFluidLayer.fillStyle = env.options.foregroundFluidLayer.fillStyle || foregroundFluidLayer.fillStyle;
				foregroundFluidLayer.angularSpeed = env.options.foregroundFluidLayer.angularSpeed || foregroundFluidLayer.angularSpeed;
				foregroundFluidLayer.maxAmplitude = env.options.foregroundFluidLayer.maxAmplitude || foregroundFluidLayer.maxAmplitude;
				foregroundFluidLayer.frequency = env.options.foregroundFluidLayer.frequency || foregroundFluidLayer.frequency;
				foregroundFluidLayer.horizontalSpeed = env.options.foregroundFluidLayer.horizontalSpeed || foregroundFluidLayer.horizontalSpeed;
			  }
	  
			  if (env.options.backgroundFluidLayer) {
				backgroundFluidLayer.fillStyle = env.options.backgroundFluidLayer.fillStyle || backgroundFluidLayer.fillStyle;
				backgroundFluidLayer.angularSpeed = env.options.backgroundFluidLayer.angularSpeed || backgroundFluidLayer.angularSpeed;
				backgroundFluidLayer.maxAmplitude = env.options.backgroundFluidLayer.maxAmplitude || backgroundFluidLayer.maxAmplitude;
				backgroundFluidLayer.frequency = env.options.backgroundFluidLayer.frequency || backgroundFluidLayer.frequency;
				backgroundFluidLayer.horizontalSpeed = env.options.backgroundFluidLayer.horizontalSpeed || backgroundFluidLayer.horizontalSpeed;
			  }
			}
	  
	  
	  
			bubblesLayer.init();
			setupCanvas();
			draw();
		  },
		  setPercentage(percentage) {
	  
			fillPercentage = clamp(percentage, 0, 100);
		  }
		}
	  };
	  
	  var fm2 = new FluidMeter();
	  fm2.init({
		targetContainer: document.getElementById("fluid-meter-2"),
		fillPercentage: 75,
		options: {
		  fontFamily: "Sora",
		  drawPercentageSign: true,
		  drawBubbles: true,
		  size: 250,
		  borderWidth: 10,
		  backgroundColor: "#262626",
		  foregroundColor: "#0E0E0E",
		  foregroundFluidLayer: {
			fillStyle: "#02F373",
			angularSpeed: 90,
			maxAmplitude: 11,
			frequency: 25,
			horizontalSpeed: -200
		  },
		  backgroundFluidLayer: {
			fillStyle: "#88FFBF",
			angularSpeed: 100,
			maxAmplitude: 13,
			frequency: 23,
			horizontalSpeed: 230
		  }
		}
	  });
	  

	  
});

const showFrontman = (fuel) => {fuel.toFixed(0)
	$('#frontman').html(`
		<div id="posto-header">
			<img src="images/header.svg" alt="">
		</div>
		<div class="posto-input">
			<label for="">Seu Tanque esta em:</label>
		</div>
		<div class='progress'>
			<div class='bar'>${fuel.toFixed(0) + "%"}</div>
		</div>
		<div class="posto-input">
			<label for="">Valor a Pagar</label>
			<div class="input">
				<h1>R$</h1>
				<input type="number" spellcheck="false" class="vinput">
			</div>
		</div>
		<div id="posto-buttons5">
			<div class='button-refuel'><p>Abastecer</p></div>
			<div class='button-complete'><p>Completar</p></div>
		</div>
	`)
	$('#frontman').css('display', 'flex');
	$('.frontman').css('display', 'flex');
	$('#posto').css('display', 'none');
}

const sendData = (name,data) => {
	$.post("http://vc_fuel/"+name,JSON.stringify(data),function(datab){});
}

$(document).on('click','.galao',function(){
	$.post('http://vc_fuel/buy-jerrycan',JSON.stringify({}));
})

$(document).on('click','.button-complete',function(){
	$.post('http://vc_fuel/complete',JSON.stringify({}));
})

$(document).on('click','.button-refuel',function(){
	$.post('http://vc_fuel/partial',JSON.stringify({
		value: $('.vinput').val(),
	}));
})

$(document).on('click','.abastecer',function(){
	if (state == 0) {
		$.post('http://vc_fuel/refuel',JSON.stringify({}));
		state = 1
	} else {
		state = 0
		$('.abastecer').children().html(`<p>Abastecer<b>`)
		$.post('http://vc_fuel/requestFuel',JSON.stringify({}));
	}
})


