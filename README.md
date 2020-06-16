Copyright (C) 2020 mirage335
See the end of the file for license conditions.
See license.txt for gEDA_designer license conditions.

Designer scripts using and supplementing gEDA , and similar. Design typical assembled circuits. Output typical manufacturing specifications. Part of gEDA_producer successor to gedaProduction .

# Usage

"_gEDA_designer_geometry"

## Attributes


### PCBWay

Notably, components may be of type SMD, Thru-Hole, or "DNS", with the latter designation apparently "Do Not Stuff" equivalent to "Do Not Place". In practice, this may not need to be specified, particularly if board is predominantly SMD or through-hole. Best design practice may be to use separate PCBs for SMD and through-hole components.

Table format is one of '.xls, xlsx or .csv' . In practice, it may be possible to provide identical information as both xlsx and csv for convenience.

### XY Centroid

Only include surface mount parts.

Column name title header
#refdes,footprint,value,description,cost,device,mfr,mfrpn,dst,dstpn,link,link_page,supplier,sbapn,kitting,kitting_d,Xpos,Ypos,rot,side

	refdes
	footprint
	value
	description
	cost
	device
Type of device - eg. CONNNECTOR_10 , DIODE, LM317HVT .
	mfr
	mfrpn
	dst
	dstpn
	link
From SmallBatchAssembly. 'URL to Datasheet containing package info'.
	link_page
From SmallBatchAssembly. 'URL to page on datasheet containing package info'.
	supplier
Ignored by PCBWay turn-key .
	sbapn
Ignored by PCBWay turn-key .
	kitting
From SmallBatchAssembly. One of - 'tape-with-leader, tape-no-leader, other'.
	kitting_d
From SmallBatchAssembly. Only required if 'KITTING == other'. 'Free text which describes kitting.'


### BOM

Column name title header.
refdes:footprint:value:description:cost:device:mfr:mfrpn:dst:dstpn:link:link_page:supplier:sbapn:kitting:kitting_d:nobom:noplace:qty

	refdes
	footprint
	value
	description
	cost
	device
Type of device - eg. CONNNECTOR_10 , DIODE, LM317HVT .
	mfr
	mfrpn
	dst
	dstpn
	link
From SmallBatchAssembly. 'URL to Datasheet containing package info'.
	link_page
From SmallBatchAssembly. 'URL to page on datasheet containing package info'.
	supplier
Ignored by PCBWay turn-key .
	sbapn
Ignored by PCBWay turn-key .
	kitting
From SmallBatchAssembly. One of - 'tape-with-leader, tape-no-leader, other'.
	kitting_d
From SmallBatchAssembly. Only required if 'KITTING == other'. 'Free text which describes kitting.'
	nobom
Either 'unknown' or true. May be discarded in favor of simply discarding matching entries.
	noplace
Either 'unknown' or true. May be discarded in favor of simply discarding matching entries.
	qty
Total number of line-item .


### SmallBatchAssembly

No header comments. Rotation may be strictly based on silkscreen markings for polarized parts, possibly subject to customer feedback. BOM submission may allow NoPart assignment.

Column name title header.
REF,VALUE,PACKAGE,X,Y,ROTATION,SUPPLIER,SBAPN,MFRPN,KITTING,KITTING_D,MFR,REMARKS,LINK,LINK_PAGE

	REF
Reference designator.
	PACKAGE
Footprint.
	VALUE
Electrical value (eg. 1k, 1uF).
WARNING: Officially claimed to regard identical PACKAGE/VALUE lines as identical BOM entries. Plausibly, this may miss diferences in voltage tolerance.
	DESCRIPTION
'Free format'. Officially stated examples ‘RES 1k 0603′ or ‘CAP .1UF 0805’.
	X
Inches. Part center coordinate.
	Y
Inches. Part center coordinate.
	ROTATION
Degrees counter-clockwise 0 to 359 .
	SUPPLIER
Officially 'a' small batch supplied or 'c' customer supplied.
	SBAPN
Offically, Small Batch Part Number, blank if customer supplied.
	MFRPN
Manufacturers part number. Officially, 'should be searchable on octopart'.
	KITTING
Officially, must be one of - 'tape-with-leader, tape-no-leader, other'.
	KITTING_D
Officially, only required if 'KITTING == other'. 'Free text which describes kitting.'
	MFR
Manufacturer.
	REMARKS
Officially, 'Reserved'. EMPTY unless otherwise officially requested.
	LINK
REQUIRED if customer supplied part. 'URL to Datasheet containing package info'.
	LINK_PAGE
REQUIRED if customer supplied part. 'URL to page on datasheet containing package info'.






# Design

Beware a modified copy of any input project will be used. Existing files, such as "attribs", may be ignored.

# Dependencies

Required programs are gEDA and similar applications typically available from a typical Linux distribution such as Debian Stable. Just run "./ubiquitous_bash.sh _setup" or "./ubiquitous_bash.sh _test" to install/check.

Optional programs used for autorouting (automatic wiring of PCB traces) include "pcb-ioAutorouter" and "Freerouting" . Self-contained versions of these are available. Beware of the limitations of autorouting if these programs are used. Carefully consider unwanted capacitance, unwanted inductance, ground loops, and impedance matching.


# Safety

# Future Work
*) A 'gerberProjectTemplate' file may become necessary. Example provided as '_lib/zOBSOLETE-gedaProduction/assembler/gerberProjectTemplate' .



# Diagnostic



# Certification





# Reference



# Third Party Copyright

All third-party files incorporated retain the licenses provided by their original authors. Incorporated works may include...

## generate-gerbers.sh - Shawn Nock - "_lib/generate-gerbers"

Original 'generate-gerbers.sh' by Shawn Nock retains original MIT license as stated by "_lib/generate-gerbers". Some derived code included in this project may also retain this license. All other code is licensed or relicensed, under GPLv3.

Further, author "mirage335" wishes to officially extend acknowledgement and gratitude. This script has long been a crucial resource, allowing efficient, repeatable, and frequent PCB manufacturing.


# Reference

https://www.pcbway.com/assembly-file-requirements.html

https://www.smallbatchassembly.com/faq/#Placement-BOM-Format
https://www.smallbatchassembly.com/parts-browser/


https://support.jlcpcb.com/article/84-how-to-generate-the-bom-and-centroid-file-from-kicad

https://sourceforge.net/projects/eaglepcb2freecad/
https://beta.sharecad.org/

https://hackaday.com/2017/05/18/kicad-best-practises-library-management/

__Copyright__
This file is part of gEDA_designer.

gEDA_designer is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

gEDA_designer is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with gEDA_designer.  If not, see <http://www.gnu.org/licenses/>.
