#!/bin/bash

blockdiag block.diag
blockdiag -Tpdf --font=/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf block.diag
blockdiag -Tsvg block.diag
nwdiag nw.diag
nwdiag -Tpdf --font=/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf nw.diag
nwdiag -Tsvg nw.diag
seqdiag seq.diag
seqdiag -Tpdf --font=/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf seq.diag
seqdiag -Tsvg seq.diag
actdiag act.diag
actdiag -Tpdf --font=/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf act.diag
actdiag -Tsvg act.diag
rackdiag rack.diag
rackdiag -Tpdf --font=/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf rack.diag
rackdiag -Tsvg rack.diag
packetdiag packet.diag
packetdiag -Tpdf --font=/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf packet.diag
packetdiag -Tsvg packet.diag
