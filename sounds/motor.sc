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
	var total_dur, tiempoMedio, high = 0, goDown, goUp, bySide, crash;
	//-------- Instrucciones MIDI y sonidos para hacer el avion caer --------\\
	goDown = {
		m.noteOn(3,0,0);
		high = 24;
		5.do({
			Synth(\alarm, [repeats: 2]);
			1.2.wait();
			high = high - 6;
			m.noteOn(2,60 + high,5);
			p.noteOn(0,60 + high,rrand(60,100));
			high = high + 2;
		});
	};
	//-------- Instrucciones MIDI y sonidos para hacer el avion elevarse --------\\
	goUp = {
		m.noteOn(1,61,100);//El viejito se monta al avion
		m.noteOn(3,1,0); //El rotor del avion enciende
		// Min level:0 --> N62
		// Max level:200 --> N84
		a = Synth("plane");
		4.wait();
		m.noteOn(1,62,100);
		12.do({
			1.wait();
			high = high + 2;
			m.noteOn(2,60 + high,5);
			p.noteOn(0,60 + high,rrand(60,100));
		});
	};
	//-------- Instrucciones MIDI y sonidos para escena 1 --------\\
	bySide = {
		m.noteOn(1,60,5);
		5.do({
			p.noteOn(0,40+rrand(0,5),40);
			1.wait();
		});
	};
	//-------- Instrucciones MIDI y sonidos para el choque --------\\
	crash = {
		0.3.wait();
		m.noteOn(1,10,10); //Crash --> N10
		Synth("explotion");
		a.free;
		3.wait();
	};

	//////////////////////////// THE SEQUENCE /////////////////////////
	bySide.play; //SCENE 1

	//goUp.play;   //Plane GO UP

	goDown.play; //Plane GO DOWN

	goUp.play;   //Plane GO UP

	crash.play; //Explode

}).play;
)


