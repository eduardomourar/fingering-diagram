#!/usr/bin/env python3
# From https://github.com/geometalab/osmaxx-symbology/blob/master/fontforge_font_creator/creator.py
import fontforge
import os
import ruamel.yaml as ruamel_yaml
import shutil
from xml.etree import ElementTree
from tempfile import NamedTemporaryFile

class FontMaker:
    """
    Usage Example:
        fm = FontMaker('definition.yml')
        fm.create_font()
    """
    def __init__(self, font_config):
        self.config = self.read_yaml(font_config)
        self._base_path = '/home/app/svg'
        self.fontforge_font = fontforge.font()
        self.fontforge_font.encoding = 'Unicode'
        # self.fontforge_font.design_size = 16
        self.fontforge_font.em = 2048
        self.fontforge_font.ascent = 1741
        self.fontforge_font.descent = 307

    def read_yaml(self, file_name):
        with open(file_name, 'r') as yaml_file:
            parsed_yaml = ruamel_yaml.load(yaml_file.read(), Loader=ruamel_yaml.Loader)
        return parsed_yaml

    def fillet_glyph(self, svg, element_name):
        ns = dict(svg='http://www.w3.org/2000/svg')
        tree = ElementTree.parse(os.path.join(self._base_path, svg))
        for parent in tree.findall('.//svg:g', ns):
            for path_el in parent.getchildren():
                if path_el.get('id') != element_name:
                    parent.remove(path_el)
        return tree

    def add_glyph(self, hex_position, svg):
        g = self.fontforge_font.createChar(hex_position)
        g.width = 800
        g.importOutlines(os.path.join(self._base_path, svg))
        assert g.isWorthOutputting()

    def create_font(self):
        for font, definition in self.config.items():
            f = self.fontforge_font
            print("creating {}".format(font))
            g = f.createChar(ord(' '), 'space')
            g.width = 1000
            for hex_position, glyph in definition['mappings'].items():
                hex_value = int(hex_position, 16)
                element = glyph.get('element', hex_position)
                print(hex_value, glyph['filename'], element)
                tree = self.fillet_glyph(glyph['filename'], element)
                with NamedTemporaryFile(suffix='.svg') as glyph_svg_file:
                    tree.write(glyph_svg_file)
                    glyph_svg_file.flush()
                    self.add_glyph(hex_value, glyph_svg_file.name)
            f.fontname = definition['fontname']
            f.familyname = definition['fontname']
            f.fullname = definition['fontname']
            f.comment = definition['fontname']
            f.version = definition['version']
            f.copyright = definition['copyright']
            f.appendSFNTName('English (US)', 'SubFamily', 'Regular')
            f.os2_stylemap = 64 # 0x0040
            # f.weight = 'normal'
            filename = '/dist/{}.sfd'.format(definition['filename'])
            if os.path.exists(filename):
                os.remove(filename)
            f.save(filename)
            export_file_name = '{}.ttf'.format(definition['filename'])
            f.generate(export_file_name)
            print("generated: ", export_file_name)
            shutil.move(export_file_name, '/dist/{}'.format(export_file_name))

if __name__ == '__main__':
    fm = FontMaker('definition.yml')
    fm.create_font()
