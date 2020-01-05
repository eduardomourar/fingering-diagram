//=============================================================================
//  Fingering Diagram Plugin
//
//  Add instrument fingering diagrams to the score
//
//  Requires Fiati music font that can found here:
//     https://github.com/eduardomourar/fiati
//
//  Copyright (c) 2019 Eduardo Rodrigues
//=============================================================================
import QtQuick 2.9
import QtQuick.Dialogs 1.1
import MuseScore 3.0

MuseScore {
	menuPath: 'Plugins.Fingering Diagram'
	version: '1.1'
	description: 'Add instrument fingering diagrams to the score'
	requiresScore: true

	/**
	* Fingering is a dictionary mapping from notes pitch
	* to character sequence in the font.
	*/
	property variant fingerings : [
		{ // Flute
			range: {
				minPitch: 59, // B3 - For B foot flute
				maxPitch: 105, // A7
			},
			base: '\uE000\uE001\uE002\uE003', // To add open holes (\uE004)
			mapping: [
				// 1st Octave (B3-B4)
				'\uE007\uE008\uE009\uE00A\uE00E\uE010\uE012\uE014\uE015\uE016','\uE007\uE008\uE009\uE00A\uE00E\uE010\uE012\uE014\uE015','\uE007\uE008\uE009\uE00A\uE00E\uE010\uE012\uE014','\uE007\uE008\uE009\uE00A\uE00E\uE010\uE012','\uE007\uE008\uE009\uE00A\uE00E\uE010\uE012\uE013','\uE007\uE008\uE009\uE00A\uE00E\uE010\uE013','\uE007\uE008\uE009\uE00A\uE00E\uE013','\uE007\uE008\uE009\uE00A\uE012\uE013','\uE007\uE008\uE009\uE00A\uE013','\uE007\uE008\uE009\uE00A\uE00B\uE013','\uE007\uE008\uE009\uE013','\uE007\uE008\uE00E\uE013','\uE007\uE008\uE013',
				// 2nd Octave (C5-B5)
				'\uE008\uE013','\uE013','\uE007\uE009\uE00A\uE00E\uE010\uE012','\uE007\uE009\uE00A\uE00E\uE010\uE012\uE013','\uE007\uE008\uE009\uE00A\uE00E\uE010\uE013','\uE007\uE008\uE009\uE00A\uE00E\uE013','\uE007\uE008\uE009\uE00A\uE012\uE013','\uE007\uE008\uE009\uE00A\uE013','\uE007\uE008\uE009\uE00A\uE00B\uE013','\uE007\uE008\uE009\uE013','\uE007\uE008\uE00E\uE013','\uE007\uE008\uE013',
				// 3nd Octave (C6-B6)
				'\uE008\uE013','\uE013','\uE007\uE009\uE00A\uE013','\uE007\uE008\uE009\uE00A\uE00B\uE00E\uE010\uE012\uE013','\uE007\uE008\uE009\uE00E\uE010\uE013','\uE007\uE008\uE00A\uE00E\uE013','\uE007\uE008\uE00A\uE012\uE013','\uE008\uE009\uE00A\uE013','\uE009\uE00A\uE00B\uE013','\uE007\uE009\uE00E\uE013','\uE007\uE00F\uE00E','\uE007\uE008\uE00A\uE011',
				// 4th Octave (C7-A7)
				'\uE008\uE009\uE00A\uE00B\uE00E','\uE009\uE00E\uE012\uE014\uE015','\uE007\uE009\uE00A\uE00E\uE010\uE015','\uE007\uE00A\uE00F\uE00E\uE014\uE015','\uE007\uE009\uE00A\uE00B\uE00F\uE011\uE012\uE015\uE016','\uE009\uE011\uE012\uE013\uE014','\uE007\uE00B\uE00E\uE012\uE013\uE014','\uE007\uE009\uE00A\uE00B\uE00F\uE010','\uE007\uE009\uE00A\uE00B\uE00F\uE010\uE012\uE014\uE015\uE016','\uE007\uE009\uE00A\uE00B\uE00F\uE021\uE010\uE012\uE014\uE015\uE016',
			],
			allKeysPressed: '\uE000\uE001\uE002\uE003\uE006\uE007\uE008\uE009\uE00A\uE00B\uE00C\uE00D\uE00E\uE00F\uE010\uE011\uE012\uE013\uE014\uE015\uE016\uE017',
		},
		{ // Piccolo
			range: {
				minPitch: 74, // D4 (written)
				maxPitch: 108, // C7
			},
			base: '\uE000',
			mapping: [
				// 1st Octave (D4-B4)
				'\uE007\uE008\uE009\uE00A\uE00E\uE010\uE012','\uE007\uE008\uE009\uE00A\uE00E\uE010\uE012\uE013','\uE007\uE008\uE009\uE00A\uE00E\uE010\uE013','\uE007\uE008\uE009\uE00A\uE00E\uE013','\uE007\uE008\uE009\uE00A\uE012\uE013','\uE007\uE008\uE009\uE00A\uE013','\uE007\uE008\uE009\uE00A\uE00B\uE013','\uE007\uE008\uE009\uE013','\uE007\uE008\uE00E\uE013','\uE007\uE008\uE013',
				// 2nd Octave (C5-B5)
				'\uE008\uE013','\uE013','\uE007\uE009\uE00A\uE00E\uE010\uE012','\uE007\uE009\uE00A\uE00E\uE010\uE012\uE013','\uE007\uE008\uE009\uE00A\uE00E\uE010\uE013','\uE007\uE008\uE009\uE00A\uE00E\uE013','\uE007\uE008\uE009\uE00A\uE012\uE013','\uE007\uE008\uE009\uE00A\uE013','\uE007\uE008\uE009\uE00A\uE00B\uE013','\uE007\uE008\uE009\uE013','\uE007\uE008\uE00E\uE013','\uE007\uE008\uE013',
				// 3nd Octave (C6-B6)
				'\uE008\uE013','\uE013','\uE007\uE009\uE00A\uE013','\uE007\uE008\uE009\uE00A\uE00B\uE00E\uE010\uE012\uE013','\uE007\uE008\uE009\uE00E\uE010\uE013','\uE007\uE008\uE00A\uE00E\uE013','\uE007\uE008\uE00A\uE012\uE013','\uE008\uE009\uE00A\uE013','\uE009\uE00A\uE00B\uE013','\uE007\uE009\uE00E\uE013','\uE007\uE00F\uE00E','\uE007\uE008\uE00A\uE011',
				// 4th Octave (C7)
				'\uE008\uE009\uE00A\uE00B\uE00E',
			],
			allKeysPressed: '\uE000\uE006\uE007\uE008\uE009\uE00A\uE00B\uE00C\uE00D\uE00E\uE00F\uE010\uE011\uE012\uE013',
		},
		{ // Sopranino Clarinet in Eb
			range: {
				minPitch: 54, // D#3 (written)
				maxPitch: 108, // A7
			},
			base: '\uE0A0',
			mapping: [
				// 1st Octave (D#3-B4)
				'\uE0A3\uE0A6\uE0A7\uE0A9\uE0AD\uE0B2\uE0B3\uE0B5\uE0BA','\uE0A3\uE0A6\uE0A7\uE0A9\uE0AD\uE0B2\uE0B3\uE0B5','','','','','','','','\uE0A3\uE0A6\uE0A7\uE0A9','','','','','','','','','','','',
				// 2nd Octave (C5-B5)
				// 3nd Octave (C6-B6)
				// 4th Octave (C7-A7)
			],
			allKeysPressed: '\uE0A0\uE0A2\uE0A3\uE0A4\uE0A5\uE0A6\uE0A7\uE0A8\uE0A9\uE0AA\uE0AB\uE0AC\uE0AD\uE0AE\uE0AF\uE0B0\uE0B1\uE0B2\uE0B3\uE0B4\uE0B5\uE0B6\uE0B7\uE0B8\uE0B9\uE0BA',
		},
		{ // Oboe
			range: {
				minPitch: 58, // A#3
				maxPitch: 97, // C#7
			},
			base: '\uE140',
			mapping: [
				// 1st Octave (A#3-B4)
				'\uE143\uE147\uE149\uE14E\uE151\uE153\uE155\uE157','','\uE143\uE147\uE149\uE151\uE153\uE155\uE157','','','','','','','','','','','',
				// 2nd Octave (C5-B5)
				// 3nd Octave (C6-C#7)
			],
			allKeysPressed: '\uE140\uE141\uE142\uE143\uE144\uE145\uE146\uE147\uE148\uE149\uE14A\uE14B\uE14C\uE14D\uE14E\uE14F\uE150\uE151\uE152\uE153\uE154\uE155\uE156\uE157\uE158\uE159',
		},
		{ // Bassoon
			range: {
				minPitch: 34, // A#1
				maxPitch: 77, // F5
			},
			base: '\uE1E0\uE1E1',
			mapping: [
				// 1st Octave (A#1-B2)
				'\uE1F8\uE1F9\uE1FA\uE1FB\uE1E3\uE1E5\uE1E6\uE1E7\uE1FD\uE1EB\uE1EC\uE1ED\uE1EF\uE1F0','','','','','','','','','','','','','',
				// 2nd Octave (C3-B3)
				'','','','','','','','','','','','',
				// 3nd Octave (C4-B4)
				'\uE1E3\uE1E5\uE1E6\uE1E7\uE1EC','','','','','','','','','','','',
				// 4th Octave (C5-F5)
			],
			allKeysPressed: '\uE1E0\uE1E1\uE1F3\uE1F4\uE1F5\uE1F6\uE1F7\uE1F8\uE1F9\uE1FA\uE1FB\uE1E2\uE1E3\uE1E4\uE1E5\uE1E6\uE1E7\uE1E8\uE1E9\uE1FC\uE1FD\uE1FE\uE1FF\uE1EA\uE1EB\uE1EC\uE1ED\uE1EE\uE1EF\uE1F0\uE1F1\uE1F2',
		},
		{ // Soprano Saxophone in Bb
			range: {
				minPitch: 55, // A3 (written)
				maxPitch: 108, // D8
			},
			base: '\uE280',
			mapping: [
				// 1st Octave (A3-B4)
				'\uE299\uE284\uE286\uE287\uE293\uE294\uE296\uE298','\uE284\uE286\uE287\uE28E\uE293\uE294\uE296\uE298','\uE284\uE286\uE287\uE28D\uE293\uE294\uE296\uE298','\uE284\uE286\uE287\uE293\uE294\uE296\uE298','','','','','','','','','','','',
				// 2nd Octave (C5-B5)
				// 3nd Octave (C6-B6)
				// 4th Octave (C7-D8)
			],
			allKeysPressed: '\uE280\uE281\uE282\uE299\uE283\uE284\uE285\uE286\uE287\uE288\uE289\uE28A\uE28B\uE28C\uE28D\uE28E\uE28F\uE290\uE291\uE292\uE293\uE294\uE295\uE296\uE297\uE298',
		},
		{ // Soprano Recorder (Baroque/English)
			range: {
				minPitch: 72, // C4 (written)
				maxPitch: 105, // A6
			},
			base: '\uE320',
			mapping: [
				// 1st Octave (C4-B4)
				'\uE321\uE322\uE323\uE324\uE325\uE326\uE327\uE328\uE329\uE32A','\uE321\uE322\uE323\uE324\uE325\uE326\uE327\uE328\uE329','\uE321\uE322\uE323\uE324\uE325\uE326\uE327\uE328','\uE321\uE322\uE323\uE324\uE325\uE326\uE327','\uE321\uE322\uE323\uE324\uE325\uE326','\uE321\uE322\uE323\uE324\uE325\uE327\uE328\uE329\uE32A','\uE321\uE322\uE323\uE324\uE326\uE327\uE328','\uE321\uE322\uE323\uE324','\uE321\uE322\uE323\uE325\uE326\uE327','\uE321\uE322\uE323','\uE321\uE322\uE324\uE325','\uE321\uE322',
				// 2nd Octave (C5-B5)
				'\uE321\uE323','\uE322\uE323','\uE323','\uE323\uE324\uE325\uE326\uE327\uE328','\uE32C\uE322\uE323\uE324\uE325\uE326','\uE32C\uE322\uE323\uE324\uE325\uE327\uE328','\uE32C\uE322\uE323\uE324\uE326','\uE32C\uE322\uE323\uE324','\uE32C\uE322\uE323\uE325','\uE32C\uE322\uE323','\uE32C\uE322\uE323\uE326\uE327\uE328','\uE32C\uE322\uE323\uE325\uE326',
				// 3nd Octave (C6-A6)
				'\uE32C\uE322\uE325\uE326','\uE32C\uE322\uE324\uE325\uE327\uE328\uE32B','\uE32C\uE322\uE324\uE325\uE327\uE328','\uE32C\uE323\uE324\uE326\uE327\uE328','\uE32C\uE323\uE324\uE326\uE327\uE328\uE32B','\uE32C\uE322\uE323\uE325\uE326\uE32B','\uE32C\uE322\uE323\uE325\uE326','\uE32C\uE322\uE325','\uE32C\uE322\uE324\uE327\uE328\uE329\uE32A\uE32B','\uE32C\uE322\uE324\uE326\uE327\uE328',
			],
			allKeysPressed: '\uE320\uE321\uE322\uE323\uE324\uE325\uE326\uE327\uE328\uE329\uE32A\uE32B',
		},
		{ // Trumpet
			range: {
				minPitch: 55,
				maxPitch: 82,
			},
		},
		{ // Trombone
			range: {
				minPitch: 40,
				maxPitch: 72,
			},
		},
		{ // French Horn
			range: {
				minPitch: 34,
				maxPitch: 77,
			},
		},
		{ // Tuba
			range: {
				minPitch: 28,
				maxPitch: 58,
			},
		},
	];
	property variant offsetY : 4; // When fingering element not available
	property variant offsetX : 0.5; // When fingering element not available
	property variant fontSize : 42;

   MessageDialog {
      id: fontMissingDialog
      icon: StandardIcon.Warning
      standardButtons: StandardButton.Ok
      title: 'Missing Fiati music font!'
      text: 'The Fiati music font is not installed on your device.'
      detailedText:  'You can download the font from here:\n\n' +
         'https://github.com/eduardomourar/fiati/releases\n\n' +
         'The Zip file contains the font file you need to install on your device.\n' +
         'You will also need to restart MuseScore for it to recognize the new font.'
      onAccepted: {
         Qt.quit()
      }
   }

   MessageDialog {
      id: versionDialog
      icon: StandardIcon.Warning
      standardButtons: StandardButton.Ok
      title: 'Unsupported MuseScore version'
      text: 'This MuseScore version is not supported.'
      detailedText:  'In order to run this plugin, you need MuseScore version 3.2.1 or higher.'
      onAccepted: {
         Qt.quit()
      }
   }

	function getInstrumentId(midiProgram) {
		var instrumentId = null;
		switch (midiProgram) {
			case 56:
			case 59:
				instrumentId = 'brass.trumpet';
				break;
			case 57:
				instrumentId = 'brass.trombone';
				break;
			case 58:
				instrumentId = 'brass.tuba';
				break;
			case 60:
				instrumentId = 'brass.french-horn';
				break;
			case 64:
				instrumentId = 'wind.reed.saxophone.soprano';
				break;
			case 65:
				instrumentId = 'wind.reed.saxophone.alto';
				break;
			case 66:
				instrumentId = 'wind.reed.saxophone.tenor';
				break;
			case 67:
				instrumentId = 'wind.reed.saxophone.baritone';
				break;
			case 68:
				instrumentId = 'wind.reed.oboe';
				break;
			case 69:
				instrumentId = 'wind.reed.english-horn';
				break;
			case 70:
				instrumentId = 'wind.reed.bassoon';
				break;
			case 71:
				instrumentId = 'wind.reed.clarinet';
				break;
			case 72:
				instrumentId = 'wind.flutes.flute.piccolo';
				break;
			case 73:
				instrumentId = 'wind.flutes.flute';
				break;
			case 74:
				instrumentId = 'wind.flutes.recorder';
				break;
		}
		return instrumentId;
	}

	function addFingering(pitch, instrument) {
		var txt = null;
		if (pitch == null || pitch < instrument.range.minPitch) {
			console.log('Skipped note as it was too low. Pitch: ' + pitch);
			return txt;
		} else if (pitch > instrument.range.maxPitch) {
			console.log('Skipped note as it was too high. Pitch: ' + pitch);
			return txt;
		}
		var index = pitch - instrument.range.minPitch;
		var mapping = instrument.mapping[index];
		if (mapping == null) {
			console.log('Note fingering not found. Index: ' + index);
			return txt;
		}
		txt = instrument.base + mapping;
		return txt;
	}

	function changeElement(element, fingering) {
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

	function renderFingering() {
		var mapping = fingerings[0];
		var startStaff;
		var endStaff;
		var endTick;
		var fullScore = false;
		var elementType;
		var supportFingeringElement = false; // (mscoreVersion >= 30500);

		if (supportFingeringElement) {
			elementType = Element.FINGERING;
		} else {
			// STAFF_TEXT element has some issues with autoplace, so you might want to use LYRICS
			elementType = Element.STAFF_TEXT;
		}
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
			console.log('Selected staves ' + startStaff + ' - ' + endStaff + ' - End position: ' + endTick);
		}

		// Loop over the selection
		for (var staff = startStaff; staff <= endStaff; staff++) {
			// Check for supported instrument parts
			var part = curScore.parts[staff];
			var instrument = null;
			if (part != null) {
				instrument = part.instrumentId || '';
			}
			if (!instrument && part && part.midiProgram != null) {
				instrument = getInstrumentId(part.midiProgram);
			}
			console.log('Staff ' + staff + ' instrument: ' + instrument);
			if (instrument === 'wind.flutes.flute' || instrument === 'wind.flutes.flute.alto') {
				mapping = fingerings[0];
				if (instrument === 'wind.flutes.flute.alto') {
					mapping.range.minPitch += -5;
					mapping.range.maxPitch += -5;
				}
			} else if (instrument === 'wind.flutes.flute.piccolo') {
				mapping = fingerings[1];
			} else if (instrument === 'wind.reed.clarinet' || instrument === 'wind.reed.clarinet.eflat' || instrument === 'wind.reed.clarinet.d'
				|| instrument === 'wind.reed.clarinet.bflat' || instrument === 'wind.reed.clarinet.basset'
				|| instrument === 'wind.reed.clarinet.alto' || instrument === 'wind.reed.clarinet.bass') {
				mapping = fingerings[2];
				if (instrument === 'wind.reed.clarinet' || instrument === 'wind.reed.clarinet.d') {
					mapping.range.minPitch += -1;
					mapping.range.maxPitch += -1;
				} else if (instrument === 'wind.reed.clarinet.bflat') {
					mapping.range.minPitch += -4;
					mapping.range.maxPitch += -4;
				} else if (instrument === 'wind.reed.clarinet.basset') {
					mapping.range.minPitch += -1;
					mapping.range.maxPitch += -1;
					mapping.base += '\uE0A1';
				} else if (instrument === 'wind.reed.clarinet.alto') {
					mapping.range.minPitch += -6;
					mapping.range.maxPitch += -6;
				} else if (instrument === 'wind.reed.clarinet.bass') {
					mapping.range.minPitch += -5;
					mapping.range.maxPitch += -5;
					mapping.base += '\uE0A1';
				}
			} else if (instrument === 'wind.reed.oboe') {
				mapping = fingerings[3];
			} else if (instrument === 'wind.reed.bassoon') {
				mapping = fingerings[4];
			} else if (instrument === 'wind.reed.saxophone' || instrument === 'wind.reed.saxophone.soprano' || instrument === 'wind.reed.saxophone.alto' 
				|| instrument === 'wind.reed.saxophone.tenor' || instrument === 'wind.reed.saxophone.baritone') {
				mapping = fingerings[5];
				if (instrument === 'wind.reed.saxophone.alto') {
					mapping.range.minPitch += -7;
					mapping.range.maxPitch += -7;
				} else if (instrument === 'wind.reed.saxophone.tenor') {
					mapping.range.minPitch += -5;
					mapping.range.maxPitch += -5;
				} else if (instrument === 'wind.reed.saxophone.baritone') {
					mapping.range.minPitch += -7;
					mapping.range.maxPitch += -7;
					mapping.base += '\uE281';
				}
			} else if (instrument === 'wind.flutes.recorder') {
				mapping = fingerings[6];
/* 				
			} else if (instrument === 'brass.trumpet') {						
			} else if (instrument === 'brass.trombone' || instrument === 'brass.trombone.alto' 
				|| instrument === 'brass.trombone.tenor' || instrument === 'brass.trombone.bass') {
				if (instrument === 'brass.trombone.bass') {
					mapping.range.minPitch += -6;
					mapping.range.maxPitch += -6;
				}
			} else if (instrument === 'brass.french-horn') {
			} else if (instrument === 'brass.tuba') {
*/
			} else {
				console.log('Skipped staff ' + staff);
				continue;
			}

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
								var el = newElement(elementType);
								if (supportFingeringElement) {
									notes[i].add(el);
								} else {
									cursor.add(el);
									// There seems to be no way of knowing the exact horizontal position
									// of a grace note, so we have to guess.
									el.offsetX = offsetX - 2.5 * (graceChords.length - j);
									// el.offsetY = offsetY;
								}
								el.fontSize = fontSize * 0.7;
								changeElement(el, text);
							}
						}
					}

					var notes = cursor.element.notes;
					for (var i = 0; i < notes.length; i++) {
						var text =  addFingering(notes[i].pitch, mapping); // mapping.allKeysPressed; //
						if (text != null) {
							var el = newElement(elementType);
							if (supportFingeringElement) {
								notes[i].add(el);
							} else {
								cursor.add(el);
								el.offsetX = offsetX;
								// el.offsetY = offsetY;
							}
							el.fontSize = fontSize;
							// TODO: improve the placing of element for different scenarios
							changeElement(el, text);
						}
					}
				} // end if CHORD
				cursor.next();
			} // end while segment
		} // end for staff
	}

	onRun: {
		if (mscoreVersion < 30201) {
			versionDialog.open();
		} else if (Qt.fontFamilies().indexOf('Fiati') < 0) {
			fontMissingDialog.open();
		} else {
			renderFingering();
		}

		Qt.quit();
	}
}
