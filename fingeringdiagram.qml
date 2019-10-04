//=============================================================================
//  Fingering Diagram Plugin
//
//  Adds instrument fingering diagram into the score
//
//  Copyright (c) 2019 Eduardo Rodrigues
//=============================================================================
import QtQuick 2.9
import MuseScore 3.0

MuseScore {
	menuPath: 'Plugins.Fingering Diagram'
	version: '1.1'
	description: 'Adds instrument fingering diagram into the score'
	requiresScore: true

	/**
	* Fingering is a dictionary mapping from notes pitch
	* to character sequence in the font.
	*/
	property variant fingerings : [
		{ // Flute
			range: {
				begin: 59, // B3 - For B foot flute
				end: 105, // A7
			},
			base: '\uEC40\uEC41\uEC42\uEC43\uEC44',
			mapping: [
				// 1st Octave (B3-B4)
				'\uEC46\uEC47\uEC48\uEC49\uEC4D\uEC4F\uEC51\uEC54\uEC55\uEC53','\uEC46\uEC47\uEC48\uEC49\uEC4D\uEC4F\uEC51\uEC55\uEC53','\uEC46\uEC47\uEC48\uEC49\uEC4D\uEC4F\uEC51\uEC53','\uEC46\uEC47\uEC48\uEC49\uEC4D\uEC4F\uEC51','\uEC46\uEC47\uEC48\uEC49\uEC4D\uEC4F\uEC51\uEC52','\uEC46\uEC47\uEC48\uEC49\uEC4D\uEC4F\uEC52','\uEC46\uEC47\uEC48\uEC49\uEC4D\uEC52','\uEC46\uEC47\uEC48\uEC49\uEC51\uEC52','\uEC46\uEC47\uEC48\uEC49\uEC52','\uEC46\uEC47\uEC48\uEC49\uEC4A\uEC52','\uEC46\uEC47\uEC48\uEC52','\uEC46\uEC47\uEC4D\uEC52','\uEC46\uEC47\uEC52',
				// 2nd Octave (C5-B5)
				'\uEC47\uEC52','\uEC52','\uEC46\uEC48\uEC49\uEC4D\uEC4F\uEC51','\uEC46\uEC48\uEC49\uEC4D\uEC4F\uEC51\uEC52','\uEC46\uEC47\uEC48\uEC49\uEC4D\uEC4F\uEC52','\uEC46\uEC47\uEC48\uEC49\uEC4D\uEC52','\uEC46\uEC47\uEC48\uEC49\uEC51\uEC52','\uEC46\uEC47\uEC48\uEC49\uEC52','\uEC46\uEC47\uEC48\uEC49\uEC4A\uEC52','\uEC46\uEC47\uEC48\uEC52','\uEC46\uEC47\uEC4D\uEC52','\uEC46\uEC47\uEC52',
				// 3nd Octave (C6-B6)
				'\uEC47\uEC52','\uEC52','\uEC46\uEC48\uEC49\uEC52','\uEC46\uEC47\uEC48\uEC49\uEC4A\uEC4D\uEC4F\uEC51\uEC52','\uEC46\uEC47\uEC48\uEC4D\uEC4F\uEC52','\uEC46\uEC47\uEC49\uEC4D\uEC52','\uEC46\uEC47\uEC49\uEC51\uEC52','\uEC47\uEC48\uEC49\uEC52','\uEC48\uEC49\uEC4A\uEC52','\uEC46\uEC48\uEC4D\uEC52','\uEC46\uEC4E\uEC4D','\uEC46\uEC47\uEC49\uEC50',
				// 4th Octave (C7-A7)
				'\uEC47\uEC48\uEC49\uEC4A\uEC4D','\uEC48\uEC4D\uEC51\uEC55\uEC53','\uEC46\uEC48\uEC49\uEC4D\uEC4F\uEC55','\uEC46\uEC49\uEC4E\uEC4D\uEC55\uEC53','\uEC46\uEC48\uEC49\uEC4A\uEC4E\uEC50\uEC51\uEC54\uEC55','\uEC48\uEC50\uEC51\uEC52\uEC53','\uEC46\uEC4A\uEC4D\uEC51\uEC52\uEC53','\uEC46\uEC48\uEC49\uEC4A\uEC4E\uEC4F','\uEC46\uEC48\uEC49\uEC4A\uEC4E\uEC4F\uEC51\uEC54\uEC55\uEC53','\uEC46\uEC48\uEC49\uEC4A\uEC4E\uEC59\uEC4F\uEC51\uEC54\uEC55\uEC53',
			],
		},
		{ // Piccolo
			range: {
				begin: 74, // D5
				end: 108, // C8
			},
			base: '\uEC40',
			mapping: [
				// 1st Octave (D5-B5)
				'\uEC46\uEC47\uEC48\uEC49\uEC4D\uEC4F\uEC51\uEC54\uEC55\uEC53','\uEC46\uEC47\uEC48\uEC49\uEC4D\uEC4F\uEC51\uEC55\uEC53','\uEC46\uEC47\uEC48\uEC49\uEC4D\uEC4F\uEC51\uEC53','\uEC46\uEC47\uEC48\uEC49\uEC4D\uEC4F\uEC51','\uEC46\uEC47\uEC48\uEC49\uEC4D\uEC4F\uEC51\uEC52','\uEC46\uEC47\uEC48\uEC49\uEC4D\uEC4F\uEC52','\uEC46\uEC47\uEC48\uEC49\uEC4D\uEC52','\uEC46\uEC47\uEC48\uEC49\uEC51\uEC52','\uEC46\uEC47\uEC48\uEC49\uEC52','\uEC46\uEC47\uEC48\uEC49\uEC4A\uEC52','\uEC46\uEC47\uEC48\uEC52','\uEC46\uEC47\uEC4D\uEC52','\uEC46\uEC47\uEC52',
				// 2nd Octave (C6-B6)
				'\uEC47\uEC52','\uEC52','\uEC46\uEC48\uEC49\uEC4D\uEC4F\uEC51','\uEC46\uEC48\uEC49\uEC4D\uEC4F\uEC51\uEC52','\uEC46\uEC47\uEC48\uEC49\uEC4D\uEC4F\uEC52','\uEC46\uEC47\uEC48\uEC49\uEC4D\uEC52','\uEC46\uEC47\uEC48\uEC49\uEC51\uEC52','\uEC46\uEC47\uEC48\uEC49\uEC52','\uEC46\uEC47\uEC48\uEC49\uEC4A\uEC52','\uEC46\uEC47\uEC48\uEC52','\uEC46\uEC47\uEC4D\uEC52','\uEC46\uEC47\uEC52',
				// 3nd Octave (C7-B7)
				'\uEC47\uEC52','\uEC52','\uEC46\uEC48\uEC49\uEC52','\uEC46\uEC47\uEC48\uEC49\uEC4A\uEC4D\uEC4F\uEC51\uEC52','\uEC46\uEC47\uEC48\uEC4D\uEC4F\uEC52','\uEC46\uEC47\uEC49\uEC4D\uEC52','\uEC46\uEC47\uEC49\uEC51\uEC52','\uEC47\uEC48\uEC49\uEC52','\uEC48\uEC49\uEC4A\uEC52','\uEC46\uEC48\uEC4D\uEC52','\uEC46\uEC4E\uEC4D','\uEC46\uEC47\uEC49\uEC50',
				// 4th Octave (C8)
				'\uEC47\uEC48\uEC49\uEC4A\uEC4D',
			],
		},
		{ // Soprano Recorder (Baroque/English)
			range: {
				begin: 72, // C5
				end: 105, // A7
			},
			base: '\uEF60',
			mapping: [
				// 1st Octave (C5-B5)
				'\uEF61\uEF62\uEF63\uEF64\uEF65\uEF66\uEF67\uEF68\uEF69\uEF6A','\uEF61\uEF62\uEF63\uEF64\uEF65\uEF66\uEF67\uEF68\uEF69','\uEF61\uEF62\uEF63\uEF64\uEF65\uEF66\uEF67\uEF68','\uEF61\uEF62\uEF63\uEF64\uEF65\uEF66\uEF67','\uEF61\uEF62\uEF63\uEF64\uEF65\uEF66','\uEF61\uEF62\uEF63\uEF64\uEF65\uEF67\uEF68\uEF69\uEF6A','\uEF61\uEF62\uEF63\uEF64\uEF66\uEF67\uEF68','\uEF61\uEF62\uEF63\uEF64','\uEF61\uEF62\uEF63\uEF65\uEF66\uEF67','\uEF61\uEF62\uEF63','\uEF61\uEF62\uEF64\uEF65','\uEF61\uEF62',
				// 2nd Octave (C6-B6)
				'\uEF61\uEF63','\uEF62\uEF63','\uEF63','\uEF63\uEF64\uEF65\uEF66\uEF67\uEF68','\uEF6B\uEF62\uEF63\uEF64\uEF65\uEF66','\uEF6B\uEF62\uEF63\uEF64\uEF65\uEF67\uEF68','\uEF6B\uEF62\uEF63\uEF64\uEF66','\uEF6B\uEF62\uEF63\uEF64','\uEF6B\uEF62\uEF63\uEF65','\uEF6B\uEF62\uEF63','\uEF6B\uEF62\uEF63\uEF66\uEF67\uEF68','\uEF6B\uEF62\uEF63\uEF65\uEF66',
				// 3nd Octave (C7-A7)
				'\uEF6B\uEF62\uEF65\uEF66','\uEF6B\uEF62\uEF64\uEF65\uEF67\uEF68\uEF9D','\uEF6B\uEF62\uEF64\uEF65\uEF67\uEF68','\uEF6B\uEF63\uEF64\uEF66\uEF67\uEF68','\uEF6B\uEF63\uEF64\uEF66\uEF67\uEF68\uEF9D','\uEF6B\uEF62\uEF63\uEF65\uEF66\uEF9D','\uEF6B\uEF62\uEF63\uEF65\uEF66','\uEF6B\uEF62\uEF65','\uEF6B\uEF62\uEF64\uEF67\uEF68\uEF69\uEF6A\uEF9D','\uEF6B\uEF62\uEF64\uEF66\uEF67\uEF68',
			],
		},
	];
	property variant offsetY : 0;
	property variant offsetX : 0.5;
	property variant fontSize : 40;

	function addFingering(pitch, instrument) {
		var txt = null;
		if (pitch == null || pitch < instrument.range.begin) {
			console.log('Skipped note as it was too low. Pitch: ' + pitch);
			return txt;
		}
		if (pitch > instrument.range.end) {
			console.log('Skipped note as it was too high. Pitch: ' + pitch);
			return txt;
		}
		var index = pitch - instrument.range.begin;
		var mapping = instrument.mapping[index];
		if (mapping == null) {
			console.log('Note fingering not found. Index: ' + index);
			return txt;
		}
		txt = instrument.base + mapping;
		return txt;
	}

	function addElement(fingering, curScore) {
		// TODO: Replaces this with Element.FINGERING when cursor.add bug has been fixed.
		var element = newElement(Element.STAFF_TEXT);

		element.text = fingering;
		element.fontFace = 'Fiati';
		// LEFT = 0, RIGHT = 1, HCENTER = 2, TOP = 0, BOTTOM = 4, VCENTER = 8, BASELINE = 16
		element.align = 2; // HCenter and top
		// Set text to below the staff
		element.placement = Placement.BELOW;
		// Turn on note relative placement
		element.autoplace = true;

		return element;
	}

	onRun: {
		var mapping = fingerings[0];
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
		} else {
			startStaff = cursor.staffIdx;
			cursor.rewind(2); // Find end of selection
			if (cursor.tick == 0) {
				endTick = curScore.lastSegment.tick + 1;
			} else {
				endTick = cursor.tick;
			}
			endStaff = cursor.staffIdx;
			console.log('Selected staves ' + startStaff + ' - ' + endStaff + ' - ' + endTick);
		}

		// Loop over the selection
		for (var staff = startStaff; staff <= endStaff; staff++) {
			// Check for flute instrument parts
			var instrument = curScore.parts[staff].instrumentId || '';
			if (instrument === 'wind.flutes.flute' || instrument === 'wind.flutes.flute.alto') {
				mapping = fingerings[0];
			} else if (instrument === 'wind.flutes.flute.piccolo') {
				mapping = fingerings[1];
			} else if (instrument === 'wind.flutes.recorder') {
				mapping = fingerings[2];
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
					var graceChords = cursor.element.graceNotes;
					for (var j = 0; j < graceChords.length; j++) {
						// Iterate through all grace chords
						var notes = graceChords[j].notes;
						for (var i = 0; i < notes.length; i++) {
							var text = addFingering(notes[i].pitch, mapping);
							if (text != null) {
								var el = addElement(text, curScore);
								el.fontSize = fontSize * 0.75;
								el.offsetY = offsetY;
								// There seems to be no way of knowing the exact horizontal position
								// of a grace note, so we have to guess.
								el.offsetX = offsetX - 2.5 * (graceChords.length - j);
								cursor.add(el);
							}
						}
					}

					var notes = cursor.element.notes;
					for (var i = 0; i < notes.length; i++) {
						var text = addFingering(notes[i].pitch, mapping);
						if (text != null) {
							var el = addElement(text, curScore);
							el.fontSize = fontSize;
							cursor.add(el);
							el.offsetY = offsetY;
							el.offsetX = offsetX;
						}
					}
				} // end if CHORD
				cursor.next();
			} // end while segment
		} // end for staff

		Qt.quit();
	}
}
