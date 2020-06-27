//////////////////////////////// motor avion ////////////////////////////////
///////////------------- Start of the plane motor ----------------///////////
(
SynthDef.new(\plane, {
	arg dur = 10, time = 0.6;
	var envelope, drive, motor;
	envelope = Env.new([2, 25, 27, 23, 20, 15, 10, 0],[5, 12, 2, 3, 4, 1], curve: [4,0,-5, 5,0,-3,-3]);
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
(
MIDIClient.init;
MIDIClient.destinations;
m = MIDIOut.new(1); //manda notas a processing
p = MIDIOut.new(0); //manda a que suene el sequencer de la compu xD
)
///////////////////////////////////////////////////////////////////////

(
 Task({

  var dura, total_dur, tiempoMedio, high = 0;

	// AQUI ESTA PARADO A LA PAR DEL AVION Hablando
	5.do({
		m.noteOn(1,60,5);
		p.noteOn(0,40+rrand(0,5),40);
		"Nota enviada".postln;
		1.wait();
	});

	//El viejito se monta al avion
	m.noteOn(1,61,100);
	5.wait();

	// El avion se levanta 62 en nota midi -->nivel de piso
	// Max level --> nota 84
	a = Synth(\plane, [\dur: 20]);
	4.wait();
	12.do({
		1.wait();
		high = high + 2;
		m.noteOn(1,60 + high,5);
		p.noteOn(0,60 + high,rrand(60,100));
	});

	// Suena la alarma el avion cae
	5.do({
		1.2.wait();
		high = high - 6;
		m.noteOn(1,60 + high,5);
		p.noteOn(0,60 + high,rrand(60,100));
		[60+high].postln;
		1.wait();
		high = high + 2;
		Synth(\alarm, [repeats: 2]);
	});


	//Make explotion nota midi 10
	m.noteOn(1,10,10);
	Synth("explotion");
	a.free;
	3.wait();
	//p.stop;
}).play;
)


