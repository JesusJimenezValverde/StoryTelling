//////////////////////////////// motor avion ////////////////////////////////
///////////------------- Start of the plane motor ----------------///////////

(
SynthDef.new(\camion, {
	arg dur = 10, time = 0.6;
	var motor = ((
	SinOsc.ar(Line.kr(2, 15, dur, doneAction: 2), mul:20) +
	SinOsc.ar(Line.kr(1, 20, dur, doneAction: 2))
) + (SinOsc.ar(6, mul: 10) * PinkNoise.ar(0.03)));
	Out.ar(0, motor);
}).add;
)

(
 Task({

  var dura, total_dur, tiempoMedio;

  dura = 10; //Duracion de la desaceleracion
  total_dur = 0;
	//Synth("motorBase");
	Synth(\camion, [\dur: dura]);

}).play;
)

