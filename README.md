Copyright (C) 2020 mirage335
See the end of the file for license conditions.
See license.txt for gEDA_designer license conditions.

Designer scripts using gEDA. Design typical assembled circuits. Output typical manufacturing specifications. Part of gEDA_producer successor to gedaProduction . 

# Usage


# Design


# Dependencies

Required programs are gEDA and similar applications typically available from a typical Linux distribution such as Debian Stable. Just run "./ubiquitous_bash.sh _setup" or "./ubiquitous_bash.sh _test" to install/check.

Optional programs used for autorouting (automatic wiring of PCB traces) include "pcb-ioAutorouter" and "Freerouting" . Self-contained versions of these are available. Beware of the limitations of autorouting if these programs are used. Carefully consider unwanted capacitance, unwanted inductance, ground loops, and impedance matching.


# Safety




# Reference



# Third Party Copyright

All third-party files incorporated retain the licenses provided by their original authors. Incorporated works may include...

## generate-gerbers.sh - Shawn Nock - "_lib/generate-gerbers"

Original 'generate-gerbers.sh' by Shawn Nock retains original MIT license as stated by "_lib/generate-gerbers". Some derived code included in this project may also retain this license. All other code is licensed or relicensed, under GPLv3.

Further, author "mirage335" wishes to officially extend acknowledgement and gratitude. This script has long been a crucial resource, allowing efficient, repeatable, and frequent PCB manufacturing.


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
