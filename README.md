# Fingering Diagram plugin for MuseScore 3.x

Fingering Diagram Plugin for MuseScore 3.x is a tool to create scores with instrument fingering diagrams.

### Introduction
This is a plugin that automatically adds fingering diagram/chart for different musical instruments (initially for windwood) to the score. Note that if the staff instrument is not a wind instrument (`wind.*`) then no fingering will be applied. Those are the instruments currently supported:

* Flute (wind.flutes.flute)
* Piccolo (wind.flutes.flute.piccolo)
* Soprano and Alto Recorder (wind.flutes.recorder)
* Saxophone (wind.reed.saxophone)
* Low and Tin Whistles (wind.flutes.whistle)
* Xaphoon (wind.reed.xaphoon)

### Installation
* If using MuseScore version 3 then download the [plugin](https://github.com/eduardomourar/fingering-diagram/archive/master.zip) and unzip it.

* Install using the [instructions](https://musescore.org/en/handbook/3/plugins#installation) in the MuseScore 3.x Handbook, which typically involves copying the QML file to the local MuseScore Plugin directory.

* Open MuseScore and navigate to ['Plugins' -> 'Plugin Manager'](https://musescore.org/en/handbook/3/plugins#enable-disable-plugins)
to enable the plugin. Tick the box against 'fingeringdiagram' and apply with 'OK'.

* This plugin relies on **Fiati** font being installed, which can be downloaded here: https://github.com/eduardomourar/fiati/releases
For windows 10 users: Make sure to install the font for "All Users" or MuseScore (and thus this plugin) won't have access to it.

### Known issues

Sometimes the diagrams are placed too close together. In order to improve readability, you can either make the font smaller, or set the [minimum note distance](https://musescore.org/en/handbook/3/measure#options) to 1.5sp or higher. 

### Preview

Image exported from the [sample MuseScore file](./sample.mscx) included in this project.

<img src="screenshot.png" alt="Screenshot" width="700">

## IMPORTANT
NO WARRANTY
THE PROGRAM IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU. SHOULD THE PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW THE AUTHOR WILL BE LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER PROGRAMS), EVEN IF THE AUTHOR HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.
