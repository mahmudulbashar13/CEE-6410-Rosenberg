* ExcelToGDX.gms - Mac/Linux replacement for the $CALL GDXXRW.EXE line (GDXXRW is Windows-only).
* Reads WASH_1yr_InputData.xlsx with GAMS Connect and writes WASH-Data.gdx.
* Symbols with no range (minrv) are skipped; the model sets minrv = 0 itself.
$onEmbeddedCode Connect:
- ExcelReader:
    file: WASH_1yr_InputData2.xlsx
    symbols:
      - {name: t, range: "Month!A1:A12", type: set, rowDimension: 1, columnDimension: 0}
      - {name: s, range: "SubInd!A1:A100", type: set, rowDimension: 1, columnDimension: 0}
      - {name: y, range: "FishSpp!A1:A10", type: set, rowDimension: 1, columnDimension: 0}
      - {name: n, range: "VegSpp!A1:A10", type: set, rowDimension: 1, columnDimension: 0}
      - {name: j, range: "Nodes!A1:A100", type: set, rowDimension: 1, columnDimension: 0}
      - {name: wt, range: "Wetlands!A1:A100", type: set, rowDimension: 1, columnDimension: 0}
      - {name: dem, range: "Demand!A1:A100", type: set, rowDimension: 1, columnDimension: 0}
      - {name: NodeNotDemandSite, range: "NodesNotDemand!A1:A100", type: set, rowDimension: 1, columnDimension: 0}
      - {name: NodeNotHeadwater, range: "NodeNotHeadwater!A1:A100", type: set, rowDimension: 1, columnDimension: 0}
      - {name: v, range: "Reservoirs!A1:A100", type: set, rowDimension: 1, columnDimension: 0}
      - {name: rsi_indx, range: "rsiIndex!A1:A10", type: set, rowDimension: 1, columnDimension: 0}
      - {name: fci_indx, range: "fciIndex!A1:A10", type: set, rowDimension: 1, columnDimension: 0}
      - {name: LinkID, range: "LinkName!A1", type: par, rowDimension: 2, columnDimension: 0}
      - {name: rsi_par, range: "rsiEQ!A1", type: par, rowDimension: 3, columnDimension: 1}
      - {name: fci_par, range: "fciEQ!A1", type: par, rowDimension: 3, columnDimension: 1}
      - {name: envSiteExist, range: "EnvSite!A1", type: par, rowDimension: 1, columnDimension: 1}
      - {name: DiversionExist, range: "Diversions!A1", type: par, rowDimension: 1, columnDimension: 1}
      - {name: returnFlowExist, range: "ReturnFlow!A1", type: par, rowDimension: 1, columnDimension: 1}
      - {name: WetlandsExist, range: "WetlandsSites!A1", type: par, rowDimension: 1, columnDimension: 1}
      - {name: LinktoReservoir, range: "LinktoReservoir!A1", type: par, rowDimension: 1, columnDimension: 1}
      - {name: LinkOutReservoir, range: "LinkOutReservoir!A1", type: par, rowDimension: 1, columnDimension: 1}
      - {name: RA_par_indx, range: "R_indx!A1", type: set, rowDimension: 1, columnDimension: 0}
      - {name: sf_par_indx, range: "sf_indx!A1:A10", type: set, rowDimension: 1, columnDimension: 0}
      - {name: wf_par_indx, range: "wf_indx!A1:A10", type: set, rowDimension: 1, columnDimension: 0}
      - {name: wsi_par_indx, range: "wsi_indx!A1:A10", type: set, rowDimension: 1, columnDimension: 0}
      - {name: reachGain, range: "HeadFlow!A1", type: par, rowDimension: 1, columnDimension: 1}
      - {name: wght, range: "weights!A1", type: par, rowDimension: 3, columnDimension: 1}
      - {name: aw, range: "AW!A1", type: par, rowDimension: 3, columnDimension: 0}
      - {name: lss, range: "lss!A1", type: par, rowDimension: 2, columnDimension: 1}
      - {name: evap, range: "evap!A1", type: par, rowDimension: 1, columnDimension: 1}
      - {name: linkEvap, range: "linkEvap!A1", type: par, rowDimension: 2, columnDimension: 1}
      - {name: RA_par, range: "ResElevVol!A1", type: par, rowDimension: 1, columnDimension: 1}
      - {name: Qsim, range: "QSim!A1", type: par, rowDimension: 2, columnDimension: 1}
      - {name: Qmin, range: "Qmin!A1", type: par, rowDimension: 2, columnDimension: 1}
      - {name: Qmax, range: "Qmax!A1", type: par, rowDimension: 2, columnDimension: 1}
      - {name: Cons, range: "Cons!A1", type: par, rowDimension: 1, columnDimension: 1}
      - {name: lng, range: "Length!A1", type: par, rowDimension: 2, columnDimension: 0}
      - {name: minstor, range: "inactive!A1", type: par, rowDimension: 1, columnDimension: 0}
      - {name: maxstor, range: "capacity!A1", type: par, rowDimension: 1, columnDimension: 0}
      - {name: dReqBase, range: "demandReq!A1", type: par, rowDimension: 1, columnDimension: 1}
      - {name: dCap, range: "divCap!A1", type: par, rowDimension: 2, columnDimension: 0}
      - {name: instreamReq, range: "Instream!A1", type: par, rowDimension: 2, columnDimension: 1}
      - {name: cst, range: "UnitCost!A1", type: par, rowDimension: 1, columnDimension: 0}
      - {name: Linkexist, range: "Connect!A1", type: par, rowDimension: 1, columnDimension: 1}
      - {name: sf_par, range: "StageFlow!A1", type: par, rowDimension: 2, columnDimension: 1}
      - {name: wf_par, range: "WidthFlow!A1", type: par, rowDimension: 2, columnDimension: 1}
      - {name: wsi_par, range: "wp!A1", type: par, rowDimension: 3, columnDimension: 1}
      - {name: b, range: "Budget!A1", type: par, rowDimension: 0, columnDimension: 0}
      - {name: InitSTOR, range: "InStor!A1", type: par, rowDimension: 1, columnDimension: 0}
      - {name: InitD, range: "InitD!A1", type: par, rowDimension: 2, columnDimension: 0}
      - {name: InitC, range: "InitC!A1", type: par, rowDimension: 2, columnDimension: 0}
      - {name: CMax, range: "CMax!A1", type: par, rowDimension: 2, columnDimension: 0}
      - {name: SimLink, range: "SimLinks!A1", type: par, rowDimension: 2, columnDimension: 0}
      - {name: LinkExistSim, range: "Connect_sim!A1", type: par, rowDimension: 1, columnDimension: 1}
      - {name: MassBalanceNodes, range: "MassBalanceNodes!A1", type: set, rowDimension: 1, columnDimension: 0}
      - {name: run, range: "Runs!A1", type: set, rowDimension: 1, columnDimension: 0}
      - {name: DValue, range: "DemandRuns!A1", type: par, rowDimension: 1, columnDimension: 0}
      - {name: Qrun, range: "Qrun!A1", type: set, rowDimension: 1, columnDimension: 0}
      - {name: QLoop, range: "QRunValues!A1", type: par, rowDimension: 1, columnDimension: 0}
      - {name: g, range: "NaturalGrowth!A1", type: par, rowDimension: 3, columnDimension: 1}
      - {name: maxrv, range: "Revegetate!A1", type: par, rowDimension: 3, columnDimension: 1}
- GDXWriter:
    file: WASH-Data.gdx
    duplicateRecords: last
$offEmbeddedCode
