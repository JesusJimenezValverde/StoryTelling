//////////////////////////////// motor avion ////////////////////////////////
///////////------------- Start of the plane motor ----------------///////////
(
SynthDef.new(\plane, {
	arg dur = 10, time = 0.6;
	var envelope, drive, motor;
	envelope = Env.new([2, 25, 25, 20, 23, 15, 10, 0],[10, 4, 1, 2, 1, 1], curve: [4,0,-5, 5,0,-3,-3]);
	drive = LFSaw.ar(EnvGen.kr(envelope), 1, 0.5, 0.5);
	motor = ((
	SinOsc.ar(EnvGen.kr(envelope), mul:20) +
	SinOsc.ar(EnvGen.kr(envelope))
) + (SinOsc.ar(6, mul: 10) * PinkNoise.ar(0.03)));
	motor = (GVerb.ar(motor,2,2) + motor +
		((BPF.ar(WhiteNoise.ar, 4000, 1.reciprocal) * 0.9) + (0.6 * 0.2)) * drive.pow(2)) * 0.3;

	Out.ar(0, motor);
}).add;
)

(
SynthDef(\alarm, {
	arg length=0.05, freqs=#[800,0,0,400], repeats=inf;
	var freq, out, operations;
	freq = Duty.ar(length, 0, Dseq(freqs, repeats), doneAction: 2);
	out = LeakDC.ar(SinOsc.ar(freq));
	out = 0.4 * (Select.ar(1, [out, (out * pi).sin, (out * pi).cos, ((out+0.25) * pi).cos]));
	Out.ar(0, Pan2.ar(out, FSinOsc.kr(2)))
}).add;
)

(
SynthDef(\explotion, {
	var explotion, envelope, out;
	envelope = Env.perc(0, 2, curve: 0);//Por default es linear entonces todo bien
	explotion = Mix.ar([LPF.ar(WhiteNoise.ar(EnvGen.kr(envelope)), 60) * 100

	]);
	out = explotion; //Volume Control
	Out.ar(0, Pan2.ar(out, [10000|0]));
}).add;
)

Synth("explotion");

(
 p = Pbind(
	\amp, 0.6,
	\freq, Pseq([60, 64, 66, 69, 71, 69, 66, 64].midicps,inf),
	\dur, 0.4,
	\releaseTime, 0.6
);
)

///////////////////////////////////////////////////////////////////////
(
 Task({

  var dura, total_dur, tiempoMedio;

	//p.play;

	a = Synth(\plane, [\dur: 15]);
	12.wait(); //Da chance a la avioneta de levantarse
	// Play the alarm
	4.do({
		Synth(\alarm, [repeats: 2]);
		2.wait();
	});
	//Make explotion
	Synth("explotion");
	a.free;
	3.wait();
	//p.stop;
}).play;
)


