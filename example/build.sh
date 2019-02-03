#!/bin/bash

blockdiag block.diag
blockdiag -Tpdf block.diag
blockdiag -Tsvg block.diag
nwdiag nw.diag
nwdiag -Tpdf nw.diag
nwdiag -Tsvg nw.diag
seqdiag seq.diag
seqdiag -Tpdf seq.diag
seqdiag -Tsvg seq.diag
actdiag act.diag
actdiag -Tpdf act.diag
actdiag -Tsvg act.diag
rackdiag rack.diag
rackdiag -Tpdf rack.diag
rackdiag -Tsvg rack.diag
packetdiag packet.diag
packetdiag -Tpdf packet.diag
packetdiag -Tsvg packet.diag
