//=============================================================================
//  Flute Fingering Plugin
//
//  Adds fingering for Concert Flute to the score
//
//  Copyright (c) 2019 Eduardo Rodrigues
//=============================================================================
import QtQuick 2.9
import MuseScore 3.0

MuseScore {
	menuPath: 'Plugins.Flute Fingering'
	version: '1.0'
	description: 'Adds fingering for Concert Flute to the score'
	requiresScore: true

    function addFingering(pitch, basePitch) {
		var fingerings = [ 
			'O','P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i',
			'j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
			'\u0C64','\u183C','\u144A','\u21F4','\u0D44','\u12E5', '\u1CF2','\u2221','\u29D4'
		]

		var txt = '';
		var index = pitch - basePitch;
		if (index < 0) {
			console.log('Skipped note as it was too low : ' + pitch);
			return txt;
		}
		if (index > 47) {
			console.log('Skipped note as it was too high, index : ' + pitch);
			return txt;
		}
		txt = fingerings[index];
		return txt;
	}

	function setFont(text, size) {
		text.fontFace = 'Concert Flute Fingering';
		text.fontSize = size;
		// LEFT = 0, RIGHT = 1, HCENTER = 2, TOP = 0, BOTTOM = 4, VCENTER = 8, BASELINE = 16
		text.align = 2; // HCenter and top
		// Set text to below the staff
		text.placement = Placement.BELOW;
		// Turn off note relative placement
		text.autoplace = true;
	}

	onRun: {
		var offsetY = -0.4;
		var offsetX = 0.2;
		var fontSize = 48;
		var basePitch = 59; // For B foot flute (B3);
		var startStaff;
		var endStaff;
		var endTick;
		var fullScore = false;

		// Find out range to apply to, either selection or full score
		var cursor = curScore.newCursor();
		cursor.rewind(1); // start of selection
		if (!cursor.segment) { // no selection
			fullScore  = true;
			startStaff = 0; // start with 1st staff
			endStaff   = curScore.nstaves - 1; // and end with last
			console.log('Full score staves ' + startStaff + ' - ' + endStaff);
		}
		else {
			startStaff = cursor.staffIdx;
			cursor.rewind(2); // Find end of selection
			if (cursor.tick == 0) {
				endTick = curScore.lastSegment.tick + 1;
			}
			else {
				endTick = cursor.tick;
			}
			endStaff = cursor.staffIdx;
		}
		console.log('Selected staves ' + startStaff + ' - ' + endStaff + ' - ' + endTick);

		// Loop over the selection
		for (var staff = startStaff; staff <= endStaff; staff++) {
			// Check for flute instrument parts
			var instrument = curScore.parts[staff].instrumentId || '';
			if (instrument === 'wind.flutes.flute' || instrument === 'wind.flutes.flute.piccolo' || instrument === 'wind.flutes.flute.alto') {
				basePitch = 59;
			} else {
				console.log('Skipped staff ' + staff + ' for instrument: ' + instrument);
				continue;
			}
			console.log('Staff ' + staff + ' instrument: ' + instrument);

			if (curScore.hasLyrics) {
				offsetY += 2   // try not to clash with any lyrics
			}
			cursor.voice = 0
			cursor.rewind(1); // beginning of selection
			cursor.staffIdx = staff;

			if (fullScore) { // no selection
				cursor.rewind(0); // beginning of score
			}

			while (cursor.segment && (fullScore || cursor.tick < endTick)) {
				if (cursor.element && cursor.element.type == Element.CHORD) {
					var text = newElement(Element.STAFF_TEXT);

					var notes = cursor.element.notes;
					for (var i = 0; i < notes.length; i++) {
						var pitch = notes[i].pitch;
						if (pitch != null) {
							text.text = addFingering(pitch, basePitch);
							cursor.add(text);
							setFont(text, fontSize);
							text.offsetY = offsetY;
							text.offsetX = offsetX;
						} else {
							console.log('Unable to retrieve pitch for note ' + i);
						}
					}
				} // end if CHORD
				cursor.next();
			} // end while segment
		} // end for staff

		Qt.quit();
	}
}
