#!/bin/bash

blockdiag block.diag
blockdiag -Tpdf block.diag
nwdiag nw.diag
nwdiag -Tpdf nw.diag
seqdiag seq.diag
seqdiag -Tpdf seq.diag
actdiag act.diag
actdiag -Tpdf actdiag
rackdiag rack.diag
rackdiag -Tpdf rack.diag
packetdiag packet.diag
packetdiag -Tpdf packet.diag
