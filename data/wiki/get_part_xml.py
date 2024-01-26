from lxml import etree
from io import BytesIO

input_file = input('xml file name: ')
output_file = f"part_{input_file}"

context = etree.iterparse(input_file, events=('start', 'end',))

file_size = 0
limit_in_bytes = 0.5 * 1024 * 1024 * 1024 # 0.5 Gigabyte
siteinfo_end_reached = False

with open(output_file, 'wb') as out_file:
    # Write XML header
    out_file.write(b'<?xml version="1.0" encoding="UTF-8"?>\n')

    for event, elem in context:
        if event == 'end':
            if elem.tag.endswith('siteinfo'):
                siteinfo_end_reached = True
                
            xml_bytes = etree.tostring(elem, encoding='UTF-8')
            file_size += len(xml_bytes)
            
            if file_size > limit_in_bytes and siteinfo_end_reached:
                break

            out_file.write(xml_bytes)
            # Clean up the processed element from memory
            elem.clear()
            while elem.getprevious() is not None:
                del elem.getparent()[0]
