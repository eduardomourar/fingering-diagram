//=============================================================================
//  Fingering Diagram Plugin
//
//  Add instrument fingering diagrams to the score
//
//  Requires Fiati music font that can found here:
//     https://github.com/eduardomourar/fiati
//
//  Copyright (c) 2019-2020 Eduardo Rodrigues
//=============================================================================
import QtQuick 2.9
import QtQuick.Dialogs 1.1
import MuseScore 3.0

MuseScore {
	menuPath: 'Plugins.Fingering Diagram'
	version: '1.5'
	description: 'Add instrument fingering diagrams to the score'
	requiresScore: true

	/**
	* Class used to create a new musical part fingering containing its type, range,
	* mapping, transposition, etc.
	*/
	function FingeringClass(part) {
		this.part = part || {};
		this.instrument = null;
		this.range = {};
		this.transpose = 0;
		this.base = '';
		this.mapping = [];
		this.allKeysPressed = '';

		/**
		* Populate dictionary mapping from notes pitch
		* to character sequence in the font.
		*/
		this._populate = function(instrument) {
			if (instrument === 'wind.flutes.flute' || instrument === 'wind.flutes.flute.alto') {
				this.instrument = 'flute'; // Default: Flute
				this.range = {
					minPitch: 59, // B3 - For B foot flute
					maxPitch: 105, // A7
				};
				this.base = '\uE000\uE001\uE002\uE003'; // To add open holes (\uE004)
				this.mapping = [
					// 1st Octave (B3-B4)
					'\uE007\uE008\uE009\uE00A\uE00E\uE010\uE012\uE014\uE015\uE016','\uE007\uE008\uE009\uE00A\uE00E\uE010\uE012\uE014\uE015','\uE007\uE008\uE009\uE00A\uE00E\uE010\uE012\uE014','\uE007\uE008\uE009\uE00A\uE00E\uE010\uE012','\uE007\uE008\uE009\uE00A\uE00E\uE010\uE012\uE013','\uE007\uE008\uE009\uE00A\uE00E\uE010\uE013','\uE007\uE008\uE009\uE00A\uE00E\uE013','\uE007\uE008\uE009\uE00A\uE012\uE013','\uE007\uE008\uE009\uE00A\uE013','\uE007\uE008\uE009\uE00A\uE00B\uE013','\uE007\uE008\uE009\uE013','\uE007\uE008\uE00E\uE013','\uE007\uE008\uE013',
					// 2nd Octave (C5-B5)
					'\uE008\uE013','\uE013','\uE007\uE009\uE00A\uE00E\uE010\uE012','\uE007\uE009\uE00A\uE00E\uE010\uE012\uE013','\uE007\uE008\uE009\uE00A\uE00E\uE010\uE013','\uE007\uE008\uE009\uE00A\uE00E\uE013','\uE007\uE008\uE009\uE00A\uE012\uE013','\uE007\uE008\uE009\uE00A\uE013','\uE007\uE008\uE009\uE00A\uE00B\uE013','\uE007\uE008\uE009\uE013','\uE007\uE008\uE00E\uE013','\uE007\uE008\uE013',
					// 3nd Octave (C6-B6)
					'\uE008\uE013','\uE013','\uE007\uE009\uE00A\uE013','\uE007\uE008\uE009\uE00A\uE00B\uE00E\uE010\uE012\uE013','\uE007\uE008\uE009\uE00E\uE010\uE013','\uE007\uE008\uE00A\uE00E\uE013','\uE007\uE008\uE00A\uE012\uE013','\uE008\uE009\uE00A\uE013','\uE009\uE00A\uE00B\uE013','\uE007\uE009\uE00E\uE013','\uE007\uE00F\uE00E','\uE007\uE008\uE00A\uE011',
					// 4th Octave (C7-A7)
					'\uE008\uE009\uE00A\uE00B\uE00E','\uE009\uE00E\uE012\uE014\uE015','\uE007\uE009\uE00A\uE00E\uE010\uE015','\uE007\uE00A\uE00F\uE00E\uE014\uE015','\uE007\uE009\uE00A\uE00B\uE00F\uE011\uE012\uE015\uE016','\uE009\uE011\uE012\uE013\uE014','\uE007\uE00B\uE00E\uE012\uE013\uE014','\uE007\uE009\uE00A\uE00B\uE00F\uE010','\uE007\uE009\uE00A\uE00B\uE00F\uE010\uE012\uE014\uE015\uE016','\uE007\uE009\uE00A\uE00B\uE00F\uE021\uE010\uE012\uE014\uE015\uE016',
				];
				this.allKeysPressed = '\uE000\uE001\uE002\uE003\uE006\uE007\uE008\uE009\uE00A\uE00B\uE00C\uE00D\uE00E\uE00F\uE010\uE011\uE012\uE013\uE014\uE015\uE016\uE017';
				if (instrument === 'wind.flutes.flute.alto') {
					this.transpose = 5;
				}
			} else if (instrument === 'wind.flutes.flute.piccolo') {
				this.instrument = 'piccolo'; // Default: Piccolo
				this.range = {
					minPitch: 74, // D4 (written)
					maxPitch: 108, // C7
				};
				this.base = '\uE000';
				this.mapping = [
					// 1st Octave (D4-B4)
					'\uE007\uE008\uE009\uE00A\uE00E\uE010\uE012','\uE007\uE008\uE009\uE00A\uE00E\uE010\uE012\uE013','\uE007\uE008\uE009\uE00A\uE00E\uE010\uE013','\uE007\uE008\uE009\uE00A\uE00E\uE013','\uE007\uE008\uE009\uE00A\uE012\uE013','\uE007\uE008\uE009\uE00A\uE013','\uE007\uE008\uE009\uE00A\uE00B\uE013','\uE007\uE008\uE009\uE013','\uE007\uE008\uE00E\uE013','\uE007\uE008\uE013',
					// 2nd Octave (C5-B5)
					'\uE008\uE013','\uE013','\uE007\uE009\uE00A\uE00E\uE010\uE012','\uE007\uE009\uE00A\uE00E\uE010\uE012\uE013','\uE007\uE008\uE009\uE00A\uE00E\uE010\uE013','\uE007\uE008\uE009\uE00A\uE00E\uE013','\uE007\uE008\uE009\uE00A\uE012\uE013','\uE007\uE008\uE009\uE00A\uE013','\uE007\uE008\uE009\uE00A\uE00B\uE013','\uE007\uE008\uE009\uE013','\uE007\uE008\uE00E\uE013','\uE007\uE008\uE013',
					// 3nd Octave (C6-B6)
					'\uE008\uE013','\uE013','\uE007\uE009\uE00A\uE013','\uE007\uE008\uE009\uE00A\uE00B\uE00E\uE010\uE012\uE013','\uE007\uE008\uE009\uE00E\uE010\uE013','\uE007\uE008\uE00A\uE00E\uE013','\uE007\uE008\uE00A\uE012\uE013','\uE008\uE009\uE00A\uE013','\uE009\uE00A\uE00B\uE013','\uE007\uE009\uE00E\uE013','\uE007\uE00F\uE00E','\uE007\uE008\uE00A\uE011',
					// 4th Octave (C7)
					'\uE008\uE009\uE00A\uE00B\uE00E',
				];
				this.allKeysPressed = '\uE000\uE006\uE007\uE008\uE009\uE00A\uE00B\uE00C\uE00D\uE00E\uE00F\uE010\uE011\uE012\uE013';
			} else if (instrument === 'wind.reed.clarinet' || instrument === 'wind.reed.clarinet.eflat' || instrument === 'wind.reed.clarinet.d'
				|| instrument === 'wind.reed.clarinet.bflat' || instrument === 'wind.reed.clarinet.basset'
				|| instrument === 'wind.reed.clarinet.alto' || instrument === 'wind.reed.clarinet.bass') {
				this.instrument = 'clarinet'; // Default: Sopranino Clarinet in Eb
				this.range = {
					minPitch: 54, // D#3 (written)
					maxPitch: 108, // A7
				};
				this.base = '\uE0A0';
				this.mapping = [
					// 1st Octave (D#3-B4)
					'\uE0A3\uE0A6\uE0A7\uE0A9\uE0AD\uE0B2\uE0B3\uE0B5\uE0BA',
					[
						'\uE0A3\uE0A6\uE0A7\uE0A9\uE0AD\uE0B2\uE0B3\uE0B5\uE0B9',  // E 'LR'
						'\uE0A3\uE0A6\uE0A7\uE0A9\uE0AD\uE0B2\uE0B3\uE0B5',        // E 'L'
						'\uE0A3\uE0A6\uE0A7\uE0A9\uE0B2\uE0B3\uE0B5\uE0B8'         // E 'R'
					],
					[
						'\uE0A3\uE0A6\uE0A7\uE0A9\uE0B2\uE0B3\uE0B5\uE0B9',    // F 'R'
						'\uE0A3\uE0A6\uE0A7\uE0A9\uE0AB\uE0B2\uE0B3\uE0B5'     // F 'L'
					],
					[
						'\uE0A3\uE0A6\uE0A7\uE0A9\uE0AC\uE0B2\uE0B3\uE0B5\uE0B9', // F# LR
						'\uE0A3\uE0A6\uE0A7\uE0A9\uE0AC\uE0B2\uE0B3\uE0B5',       // F# L
						'\uE0A3\uE0A6\uE0A7\uE0A9\uE0B2\uE0B3\uE0B5\uE0B6'        // F# R
					],
					'\uE0A3\uE0A6\uE0A7\uE0A9\uE0B2\uE0B3\uE0B5', '\uE0A3\uE0A6\uE0A7\uE0A9\uE0B2\uE0B3\uE0B5\uE0B7', '\uE0A3\uE0A6\uE0A7\uE0A9\uE0B2\uE0B3', // A
					'\uE0A3\uE0A6\uE0A7\uE0A9\uE0B2', // Bb
					[
						'\uE0A3\uE0A6\uE0A7\uE0A9\uE0B3', // B
						'\uE0A3\uE0A6\uE0A7\uE0A9\uE0B2\uE0B4'
					],
					'\uE0A3\uE0A6\uE0A7\uE0A9',       // C
					'\uE0A3\uE0A6\uE0A7\uE0A9\uE0AA',  // C#
					'\uE0A3\uE0A6\uE0A7', // D
					[
						'\uE0A3\uE0A6\uE0A7\uE0B1', // Eb
						'\uE0A3\uE0A6\uE0A7\uE0A8', // Eb
						'\uE0A3\uE0A6\uE0B2'        // Eb
					],
					'\uE0A3\uE0A6',  // E
					'\uE0A3',  // F
					[
						'\uE0A6',                 // F#
						'\uE0A3\uE0B0\uE0B1'
					],
					'',   // G
					'\uE0A5', // G#
					'\uE0A4',
					'\uE0A2\uE0A4',
					[     // B
						'\uE0A2\uE0A3\uE0A6\uE0A7\uE0A9\uE0AD\uE0B2\uE0B3\uE0B5\uE0B9', // LR 
						'\uE0A2\uE0A3\uE0A6\uE0A7\uE0A9\uE0AD\uE0B2\uE0B3\uE0B5',       // L
						'\uE0A2\uE0A3\uE0A6\uE0A7\uE0A9\uE0B2\uE0B3\uE0B5\uE0B8'        // R
					],
					// 2nd Octave (C5-B5)
					[     // C
						'\uE0A2\uE0A3\uE0A6\uE0A7\uE0A9\uE0B2\uE0B3\uE0B5\uE0B9',      // R
						'\uE0A2\uE0A3\uE0A6\uE0A7\uE0A9\uE0AB\uE0B2\uE0B3\uE0B5'       // L
					],
					[   // C#
						'\uE0A2\uE0A3\uE0A6\uE0A7\uE0A9\uE0AC\uE0B2\uE0B3\uE0B5',         // L
						'\uE0A2\uE0A3\uE0A6\uE0A7\uE0A9\uE0AC\uE0B2\uE0B3\uE0B5\uE0B9',   // LR
						'\uE0A2\uE0A3\uE0A6\uE0A7\uE0A9\uE0B2\uE0B3\uE0B5\uE0B6'          // R
					],
					'\uE0A2\uE0A3\uE0A6\uE0A7\uE0A9\uE0B2\uE0B3\uE0B5',
					'\uE0A2\uE0A3\uE0A6\uE0A7\uE0A9\uE0B2\uE0B3\uE0B5\uE0B7', // D#
					'\uE0A2\uE0A3\uE0A6\uE0A7\uE0A9\uE0B2\uE0B3',
					'\uE0A2\uE0A3\uE0A6\uE0A7\uE0A9\uE0B2',
					[     // F#
						'\uE0A2\uE0A3\uE0A6\uE0A7\uE0A9\uE0B3',
						'\uE0A2\uE0A3\uE0A6\uE0A7\uE0A9\uE0B2\uE0B4'
					],
					'\uE0A2\uE0A3\uE0A6\uE0A7\uE0A9', // G
					'\uE0A2\uE0A3\uE0A6\uE0A7\uE0A9\uE0AA', // G# 
					'\uE0A2\uE0A3\uE0A6\uE0A7',
					[  // A#
						'\uE0A2\uE0A3\uE0A6\uE0A7\uE0B1',
						'\uE0A2\uE0A3\uE0A6\uE0A7\uE0A8',
						'\uE0A2\uE0A3\uE0A6\uE0B2'
					],
					'\uE0A2\uE0A3\uE0A6',
					// 3nd Octave (C6-B6)
					'\uE0A2\uE0A3',
					'\uE0A2\uE0A3\uE0A7\uE0A9\uE0B2\uE0B3',
					'\uE0A2\uE0A3\uE0A7\uE0A9\uE0B2\uE0B7', // D
					[  // D#
						'\uE0A2\uE0A3\uE0A7\uE0A9\uE0B2\uE0B4\uE0B7',
						'\uE0A2\uE0A3\uE0A7\uE0A9\uE0B3\uE0B7'
					],
					'\uE0A2\uE0A3\uE0A7\uE0A9\uE0B7',  // E
					'\uE0A2\uE0A3\uE0A7\uE0A9\uE0AA\uE0B7', // F
					[
						'\uE0A2\uE0A3\uE0A7\uE0B7',  // F#
						'\uE0A2\uE0A3\uE0A6\uE0A7\uE0B2\uE0B3\uE0B5\uE0B7'
					],
					[
						'\uE0A2\uE0A3\uE0A7\uE0B2\uE0B3\uE0B7',  // G
						'\uE0A2\uE0A3\uE0A7\uE0A9\uE0B2\uE0B3\uE0B7'
					],
					[
						'\uE0A2\uE0A3\uE0A7\uE0A9\uE0AC\uE0B2\uE0B5',
						'\uE0A2\uE0A3\uE0A7\uE0A9\uE0B2\uE0B5\uE0B6'
					],
					[
						'\uE0A2\uE0A3\uE0A7\uE0A9\uE0B9',
						'\uE0A2\uE0A3\uE0A7\uE0A9\uE0AB'
					],
					[
						'\uE0A2\uE0A3\uE0A5\uE0A7\uE0A9\uE0AA\uE0B7',
						'\uE0A2\uE0A3\uE0A5\uE0A7\uE0A9\uE0B6'
					],
					[
						'\uE0A2\uE0A3\uE0A5\uE0A6\uE0A7\uE0B2\uE0B3',
						'\uE0A2\uE0A3\uE0A6\uE0A7\uE0B2\uE0B3\uE0B6'
					],
					[
						'\uE0A2\uE0A3\uE0A5\uE0A6\uE0B2\uE0B6',
						'\uE0A2\uE0A3\uE0A5\uE0A6\uE0AC\uE0B2'
					],
				];
				this.allKeysPressed = '\uE0A0\uE0A2\uE0A3\uE0A4\uE0A5\uE0A6\uE0A7\uE0A8\uE0A9\uE0AA\uE0AB\uE0AC\uE0AD\uE0AE\uE0AF\uE0B0\uE0B1\uE0B2\uE0B3\uE0B4\uE0B5\uE0B6\uE0B7\uE0B8\uE0B9\uE0BA';
				if (instrument === 'wind.reed.clarinet' || instrument === 'wind.reed.clarinet.d') {
					this.transpose = 1;
				} else if (instrument === 'wind.reed.clarinet.bflat') {
					this.transpose = 5;
				} else if (instrument === 'wind.reed.clarinet.basset') {
					this.transpose = 1;
					this.base += '\uE0A1';
				} else if (instrument === 'wind.reed.clarinet.alto') {
					this.transpose = 6;
				} else if (instrument === 'wind.reed.clarinet.bass') {
					this.transpose = 5;
					this.base += '\uE0A1';
				}
			} else if (instrument === 'wind.reed.oboe') {
				this.instrument = 'oboe'; // Default: Oboe
				this.range = {
					minPitch: 58, // A#3
					maxPitch: 97, // C#7
				};
				this.base = '\uE140';
				this.mapping = [
					// 1st Octave (A#3-B4)
					'\uE143\uE147\uE149\uE14E\uE151\uE153\uE155\uE157','','\uE143\uE147\uE149\uE151\uE153\uE155\uE157','','','','','','','','','','','',
					// 2nd Octave (C5-B5)
					'','','','','','','','','','','','',
					// 3nd Octave (C6-C#7)
					'','','','','','','','','','','','',
				];
				this.allKeysPressed = '\uE140\uE141\uE142\uE143\uE144\uE145\uE146\uE147\uE148\uE149\uE14A\uE14B\uE14C\uE14D\uE14E\uE14F\uE150\uE151\uE152\uE153\uE154\uE155\uE156\uE157\uE158\uE159';
			} else if (instrument === 'wind.reed.bassoon') {
				this.instrument = 'bassoon';// Default: Bassoon
				this.range = {
					minPitch: 34, // A#1
					maxPitch: 77, // F5
				};
				this.base = '\uE1E0\uE1E1';
				this.mapping = [
					// 1st Octave (A#1-B2)
					'\uE1F8\uE1F9\uE1FA\uE1FB\uE1E3\uE1E5\uE1E6\uE1E7\uE1FD\uE1EB\uE1EC\uE1ED\uE1EF\uE1F0','','','','','','','','','','','','','',
					// 2nd Octave (C3-B3)
					'','','','','','','','','','','','',
					// 3nd Octave (C4-B4)
					'\uE1E3\uE1E5\uE1E6\uE1E7\uE1EC','','','','','','','','','','','',
					// 4th Octave (C5-F5)
					'','','','','','','','','','','','',
				];
				this.allKeysPressed = '\uE1E0\uE1E1\uE1F3\uE1F4\uE1F5\uE1F6\uE1F7\uE1F8\uE1F9\uE1FA\uE1FB\uE1E2\uE1E3\uE1E4\uE1E5\uE1E6\uE1E7\uE1E8\uE1E9\uE1FC\uE1FD\uE1FE\uE1FF\uE1EA\uE1EB\uE1EC\uE1ED\uE1EE\uE1EF\uE1F0\uE1F1\uE1F2';
			} else if (instrument === 'wind.reed.saxophone' || instrument === 'wind.reed.saxophone.soprano' || instrument === 'wind.reed.saxophone.alto' 
				|| instrument === 'wind.reed.saxophone.tenor' || instrument === 'wind.reed.saxophone.baritone') {
				this.instrument = 'saxophone'; // Default: Soprano Saxophone in Bb
				this.range = {
					minPitch: 55, // A3 (written)
					maxPitch: 108, // D8
				};
				this.base = '\uE280';
				this.mapping = [
					// 1st Octave (A3-B4)
					'\uE299\uE284\uE286\uE287\uE293\uE294\uE296\uE298','\uE284\uE286\uE287\uE28E\uE293\uE294\uE296\uE298','\uE284\uE286\uE287\uE28D\uE293\uE294\uE296\uE298','\uE284\uE286\uE287\uE293\uE294\uE296\uE298','\uE284\uE286\uE287\uE28C\uE293\uE294\uE296\uE298','\uE284\uE286\uE287\uE293\uE294\uE296','\uE284\uE286\uE287\uE293\uE294\uE296\uE297','\uE284\uE286\uE287\uE293\uE294','\uE284\uE286\uE287\uE293','\uE284\uE286\uE287\uE294','\uE284\uE286\uE287','\uE284\uE286\uE287\uE28B','\uE284\uE286','\uE284\uE285','\uE284',
					// 2nd Octave (C5-B5)
					'\uE286','','\uE282\uE284\uE286\uE287\uE293\uE294\uE296','\uE282\uE284\uE286\uE287\uE293\uE294\uE296\uE297','\uE282\uE284\uE286\uE287\uE293\uE294','\uE282\uE284\uE286\uE287\uE293','\uE282\uE284\uE286\uE287\uE294','\uE282\uE284\uE286\uE287','\uE282\uE284\uE286\uE287\uE28B','\uE282\uE284\uE286','\uE282\uE284\uE285','\uE282\uE284',
					// 3nd Octave (C6-B6)
					'\uE282\uE286','\uE282','\uE282\uE289','\uE282\uE288\uE289','\uE282\uE288\uE289\uE28F','\uE282\uE288\uE289\uE28A\uE28F','\uE282\uE283\uE286\uE28D','\uE282\uE284\uE287\uE296','\uE282\uE284\uE287','\uE282\uE286\uE287','\uE282\uE287\uE290','\uE282\uE289',
					// 4th Octave (C7-D8)
					'\uE282\uE288\uE289','\uE282\uE288\uE289\uE28F','\uE282\uE284\uE288','\uE282\uE283\uE286','\uE282\uE286\uE293\uE294','\uE282\uE284\uE287\uE293\uE296','','','','','','','','','',
				];
				this.allKeysPressed = '\uE280\uE281\uE282\uE299\uE283\uE284\uE285\uE286\uE287\uE288\uE289\uE28A\uE28B\uE28C\uE28D\uE28E\uE28F\uE290\uE291\uE292\uE293\uE294\uE295\uE296\uE297\uE298';
				if (instrument === 'wind.reed.saxophone.alto') {
					this.transpose = 7;
				} else if (instrument === 'wind.reed.saxophone.tenor') {
					this.transpose = 12;
				} else if (instrument === 'wind.reed.saxophone.baritone') {
					this.transpose = 19;
					this.base += '\uE281';
				}
			} else if (instrument === 'wind.flutes.recorder' || instrument === 'wind.flutes.recorder.soprano'
				|| instrument === 'wind.flutes.recorder.alto') {
				this.instrument = 'recorder'; // Default: Soprano Recorder (Baroque/English)
				this.range = {
					minPitch: 72, // C4 (written)
					maxPitch: 105, // A6
				};
				this.base = '\uE320';
				this.mapping = [
					// 1st Octave (C4-B4)
					'\uE321\uE322\uE323\uE324\uE325\uE326\uE327\uE328\uE329\uE32A','\uE321\uE322\uE323\uE324\uE325\uE326\uE327\uE328\uE329','\uE321\uE322\uE323\uE324\uE325\uE326\uE327\uE328','\uE321\uE322\uE323\uE324\uE325\uE326\uE327','\uE321\uE322\uE323\uE324\uE325\uE326','\uE321\uE322\uE323\uE324\uE325\uE327\uE328\uE329\uE32A','\uE321\uE322\uE323\uE324\uE326\uE327\uE328','\uE321\uE322\uE323\uE324','\uE321\uE322\uE323\uE325\uE326\uE327','\uE321\uE322\uE323','\uE321\uE322\uE324\uE325','\uE321\uE322',
					// 2nd Octave (C5-B5)
					'\uE321\uE323','\uE322\uE323','\uE323','\uE323\uE324\uE325\uE326\uE327\uE328','\uE32C\uE322\uE323\uE324\uE325\uE326','\uE32C\uE322\uE323\uE324\uE325\uE327\uE328','\uE32C\uE322\uE323\uE324\uE326','\uE32C\uE322\uE323\uE324','\uE32C\uE322\uE323\uE325','\uE32C\uE322\uE323','\uE32C\uE322\uE323\uE326\uE327\uE328','\uE32C\uE322\uE323\uE325\uE326',
					// 3nd Octave (C6-A6)
					'\uE32C\uE322\uE325\uE326','\uE32C\uE322\uE324\uE325\uE327\uE328\uE32B','\uE32C\uE322\uE324\uE325\uE327\uE328','\uE32C\uE323\uE324\uE326\uE327\uE328','\uE32C\uE323\uE324\uE326\uE327\uE328\uE32B','\uE32C\uE322\uE323\uE325\uE326\uE32B','\uE32C\uE322\uE323\uE325\uE326','\uE32C\uE322\uE325','\uE32C\uE322\uE324\uE327\uE328\uE329\uE32A\uE32B','\uE32C\uE322\uE324\uE326\uE327\uE328',
				];
				this.allKeysPressed = '\uE320\uE321\uE322\uE323\uE324\uE325\uE326\uE327\uE328\uE329\uE32A\uE32B';
				if (instrument === 'wind.flutes.recorder.alto') {
					this.transpose = 7;
				}
			} else if (instrument === 'wind.flutes.whistle.tin.d' || instrument === 'wind.flutes.whistle.tin.common'
				|| instrument === 'wind.flutes.whistle.low.d' || instrument === 'wind.flutes.whistle.low.f' || instrument === 'wind.flutes.whistle.low.g'
				|| instrument === 'wind.flutes.whistle.tin.bflat' || instrument === 'wind.flutes.whistle.tin'|| instrument === 'wind.flutes.whistle.tin.c'
				|| instrument === 'wind.flutes.whistle.tin.eflat' || instrument === 'wind.flutes.whistle.tin.f'|| instrument === 'wind.flutes.whistle.tin.g') {
				this.instrument = 'whistle'; // Default: Tin Whistle
				this.range = {
					minPitch: 74, // D4 (written)
					maxPitch: 104, // G#6
				};
				this.base = '\uE3C0\uE3C3\uE3C6';
				this.mapping = [
					// 1st Octave (D4-B4)
					'\uE3CF\uE3D1\uE3D2\uE3D3\uE3D5\uE3D6','\uE3CF\uE3D1\uE3D2\uE3D3\uE3D5\uE3E6','\uE3CF\uE3D1\uE3D2\uE3D3\uE3D5','\uE3CF\uE3D1\uE3D2\uE3D3\uE3E5','\uE3CF\uE3D1\uE3D2\uE3D3','\uE3CF\uE3D1\uE3D2','\uE3CF\uE3D1\uE3E2','\uE3CF\uE3D1','\uE3CF\uE3E1','\uE3CF',
					// 2nd Octave (C5-B5)
					'\uE3D1\uE3D2','','\uE3D1\uE3D2\uE3D3\uE3D5\uE3D6\uE43D','\uE3CF\uE3D1\uE3D2\uE3D3\uE3D5\uE3E6\uE43D','\uE3CF\uE3D1\uE3D2\uE3D3\uE3D5\uE43D','\uE3CF\uE3D1\uE3D2\uE3D3\uE3E5\uE43D','\uE3CF\uE3D1\uE3D2\uE3D3\uE43D','\uE3CF\uE3D1\uE3D2\uE43D','\uE3CF\uE3D1\uE3E2\uE43D','\uE3CF\uE3D1\uE43D','\uE3CF\uE3E1\uE43D','\uE3CF\uE43D',
					// 3nd Octave (C6-G#6)
					'\uE3DF\uE43D','\uE3D1\uE3D2\uE3D3\uE43D','\uE3D1\uE3D2\uE3D3\uE3D5\uE3D6\uE43E','\uE3CF\uE3D1\uE3D3\uE3D6\uE43E','\uE3CF\uE3D1\uE3D2\uE3D3\uE3D5\uE43E','\uE3CF\uE3D1\uE3D2\uE3D3\uE3E5\uE3D6\uE43E','\uE3CF\uE3D1\uE3D2\uE3D3\uE3D6\uE43E','\uE3CF\uE3D1\uE3D2\uE3D6\uE43E','\uE3CF\uE3D1\uE3E2\uE3D6\uE43E',
				];
				this.allKeysPressed = '\uE3C0\uE3C3\uE3C6\uE3CF\uE3D1\uE3D2\uE3D3\uE3D5\uE3D6\uE43E';
				if (instrument === 'wind.flutes.whistle.low.d') {
					this.transpose = 12;
				} else if (instrument === 'wind.flutes.whistle.low.f') {
					this.transpose = 9;
				} else if (instrument === 'wind.flutes.whistle.low.g') {
					this.transpose = 7;
				} else if (instrument === 'wind.flutes.whistle.tin.bflat') {
					this.transpose = 4;
				} else if (instrument === 'wind.flutes.whistle.tin' || instrument === 'wind.flutes.whistle.tin.c') {
					this.transpose = 2;
				} else if (instrument === 'wind.flutes.whistle.tin.eflat') {
					this.transpose = -1;
				} else if (instrument === 'wind.flutes.whistle.tin.f') {
					this.transpose = -3;
				} else if (instrument === 'wind.flutes.whistle.tin.g') {
					this.transpose = -5;
				}
			} else if (instrument === 'wind.reed.xaphoon'
				|| instrument === 'wind.reed.xaphoon.g' || instrument === 'wind.reed.xaphoon.bflat' || instrument === 'wind.reed.xaphoon.d') {
				this.instrument = 'xaphoon'; // Default: Xaphoon in C
				this.range = {
					minPitch: 59, // B3 (written)
					maxPitch: 84, // C6
				};
				this.base = '\uE3C0\uE3C1\uE3C2\uE3C3\uE3C6\uE3C7';
				this.mapping = [
					// 1st Octave (B3-B4)
					'\uE3CD\uE3CE\uE3CF\uE3D1\uE3D2\uE3D3\uE3D5\uE3D6\uE3D7','\uE3CD\uE3CE\uE3CF\uE3D1\uE3D2\uE3D3\uE3D5\uE3D6\uE3D7','\uE3CD\uE3CE\uE3CF\uE3D1\uE3D2\uE3D3\uE3D5\uE3D6\uE3E7','\uE3CD\uE3CE\uE3CF\uE3D1\uE3D2\uE3D3\uE3D5\uE3D6','\uE3CD\uE3CE\uE3CF\uE3D1\uE3D2\uE3D3\uE3D5\uE3D7','\uE3CD\uE3CE\uE3CF\uE3D1\uE3D2\uE3D3\uE3D5','\uE3CD\uE3CE\uE3CF\uE3D1\uE3D2\uE3D3','\uE3CD\uE3CE\uE3CF\uE3D1\uE3D2\uE3D5\uE3D6\uE3D7','\uE3CD\uE3CE\uE3CF\uE3D1\uE3D2\uE427','\uE3CD\uE3CE\uE3CF\uE3D1\uE3D3\uE3D5\uE3D6','\uE3CD\uE3CE\uE3CF\uE3D1\uE427','\uE3CD\uE3CE\uE3CF\uE427','\uE3CD\uE3CE\uE3D1\uE3D2\uE3D3\uE427',
					// 2nd Octave (C5-C6)
					'\uE3CD\uE3CE\uE427','\uE3CD\uE3CF\uE3D1\uE3D2\uE427','\uE3CD\uE427','\uE3CE\uE3CF\uE3D1\uE3D2\uE427','\uE3CE\uE427','\uE427','\uE427','\uE43F\uE3CE\uE3CF\uE3D1\uE3D2\uE3D3\uE3D5\uE3D6\uE3D7','\uE43F\uE3CD\uE3CE\uE3CF\uE3D1\uE3D2\uE3D3\uE3D5\uE3D6\uE3E7','\uE43F\uE3CD\uE3CE\uE3CF\uE3D1\uE3D2\uE3D3\uE3D5\uE3D6','\uE43F\uE3CD\uE3CE\uE3CF\uE3D1\uE3D2\uE3D3\uE3D5\uE3D7','\uE43F\uE3CD\uE3CE\uE3CF\uE3D1\uE3D2\uE3D3','\uE43F\uE3CD\uE3CE\uE3CF\uE3D1\uE3D2\uE427',
				];
				this.allKeysPressed = '\uE3C0\uE3C1\uE3C2\uE3C3\uE3C6\uE3C7\uE43F\uE3CD\uE3CE\uE3CF\uE3D1\uE3D2\uE3D3\uE3D5\uE3D6\uE3D7';
				if (instrument === 'wind.reed.xaphoon.g') {
					this.transpose = 5;
				} else if (instrument === 'wind.reed.xaphoon.bflat') {
					this.transpose = 2;
				} else if (instrument === 'wind.reed.xaphoon.d') {
					this.transpose = -2;
				}
			} else if (instrument === 'brass.trumpet') {	
				// this.instrument = 'trumpet'; // Default: Trumpet
				this.range = {
					minPitch: 55,
					maxPitch: 82,
				};
			} else if (instrument === 'brass.trombone' || instrument === 'brass.trombone.alto' 
				|| instrument === 'brass.trombone.tenor' || instrument === 'brass.trombone.bass') {
				// this.instrument = 'trombone'; // Default: Trombone
				this.range = {
					minPitch: 40,
					maxPitch: 72,
				};
				if (instrument === 'brass.trombone.bass') {
					this.transpose = 6;
				}
			} else if (instrument === 'brass.french-horn') {
				// this.instrument = 'french-horn'; // Default: French Horn
				this.range = {
					minPitch: 34,
					maxPitch: 77,
				};
			} else if (instrument === 'brass.tuba') {
				this.instrument = 'tuba'; // Default: Tuba
				this.range = {
					minPitch: 24,
					maxPitch: 65,
				};
				this.base = '\uE3C0';
				var f = { 0: '', 1: '\uE3D1', 2: '\uE3D2', 3: '\uE3D3', 4: '\uE3D5'};

				f[12]   = f[1]+f[2];
				f[23]   = f[2]+f[3];
				f[24]   = f[2]+f[4];
				f[124]  = f[1]+f[2]+f[4];
				f[134]  = f[1]+f[3]+f[4];
				f[234]  = f[2]+f[3]+f[4];
				f[1234] = f[1]+f[2]+f[3]+f[4];

				this.mapping = [
					// 1st Octave (C1-B1)
					f[1234], f[134], f[234], f[124], f[24], f[4], f[23], f[12], f[1], f[2], f[0], f[24], 
					// 2nd Octave (C2-B2)
					f[4], f[23], f[12], f[1], f[2], f[0], f[23], f[12], f[1], f[2], f[0], f[12], 
					// 3rd Octave (C3-B3)
					f[4], f[23], f[12], f[1], f[2], f[0], f[23], f[12], f[1], f[2], f[0], f[12], 
					// 4th Octave (C4-F4)
					f[4], f[23], f[12], f[1], f[2], f[0]
				];
			}
		}
		
		this._getInstrumentId = function() {
			var part = this.part;
			var instrumentId = part.instrumentId;
			if (part && !instrumentId && part.midiProgram && midiMapping.has(midiMapping)) {
				instrumentId = midiMapping[part.midiProgram];
			}
			if (instrumentId) {
				this._populate(instrumentId);
			}
			return instrumentId;
		}

		this.getPitchText = function(pitch) {
			var txt = null;
			if (pitch == null || pitch < this.range.minPitch - this.transpose) {
				console.log('Skipped note as it was too low. Pitch: ' + pitch);
				return txt;
			} else if (pitch > this.range.maxPitch - this.transpose) {
				console.log('Skipped note as it was too high. Pitch: ' + pitch);
				return txt;
			}
			var index = pitch + this.transpose - this.range.minPitch;
			var mapping = this.mapping[index];
			if (mapping == null) {
				console.log('Note fingering not found. Index: ' + index);
				return txt;
			} else if (Array.isArray(mapping)) {
				// In case alternate fingering, we will consider the first one for now
				mapping = mapping[0];
			}
			txt = this.base + mapping;
			return txt;
		}

		this.instrumentId = this._getInstrumentId();
	}

	property variant midiMapping : {
		56: 'brass.trumpet',
		59: 'brass.trumpet',
		57: 'brass.trombone',
		58: 'brass.tuba',
		60: 'brass.french-horn',
		64: 'wind.reed.saxophone.soprano',
		65: 'wind.reed.saxophone.alto',
		66: 'wind.reed.saxophone.tenor',
		67: 'wind.reed.saxophone.baritone',
		68: 'wind.reed.oboe',
		69: 'wind.reed.english-horn',
		70: 'wind.reed.bassoon',
		71: 'wind.reed.clarinet',
		72: 'wind.flutes.flute.piccolo',
		73: 'wind.flutes.flute',
		74: 'wind.flutes.recorder'
		};
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

	MessageDialog {
		id: nothingProcessed
		icon: StandardIcon.Warning
		standardButtons: StandardButton.Ok
		title: 'No valid score found'
		text: 'The instruments in this project are not supported or not yet fully implemented. Nothing was changed.'
		onAccepted: {
			Qt.quit()
		}
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
		var fingering = null;
		var startStaff;
		var endStaff;
		var endTick;
		var fullScore = false;
		var elementType;
		var supportFingeringElement = false; // (mscoreVersion >= 30500);
		var staffChanged = 0;
		var staffFound = [];

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
			fingering = new FingeringClass(part);
			staffFound.push(part.longName + ' (' + part.instrumentId + ')');
			if (fingering && fingering.instrument) {
				console.log('Staff ' + staff + ' instrument: ' + fingering.instrumentId);
				staffChanged += 1;
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
							var text = fingering.getPitchText(notes[i].pitch);
							if (text != null) {
								var el = newElement(elementType);
								if (supportFingeringElement) {
									notes[i].add(el);
								} else {
									cursor.add(el);
									var noteType = notes[i].noteType;
									var graceOffset = -2.5;
									if (noteType == NoteType.GRACE8_AFTER || noteType == NoteType.GRACE16_AFTER ||
										noteType == NoteType.GRACE32_AFTER) {
										graceOffset = -1 * graceOffset;
									}

									// There seems to be no way of knowing the exact horizontal position
									// of a grace note, so we have to guess.
									el.offsetX = offsetX + graceOffset * (graceChords.length - j);
									// el.offsetY = offsetY;
								}
								el.fontSize = fontSize * 0.7;
								changeElement(el, text);
							}
						}
					}

					var notes = cursor.element.notes;
					for (var i = 0; i < notes.length; i++) {
						var text = fingering.getPitchText(notes[i].pitch); // fingering.allKeysPressed; //
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
		if (staffChanged == 0) {
			nothingProcessed.detailedText = "Found following instruments:\n"+staffFound.join('\n')+"\n\nSupported are only:\n";
			for (var i in midiMapping) {
				nothingProcessed.detailedText += midiMapping[i] + "\n";
			}
			nothingProcessed.open();
		}
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
