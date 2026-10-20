$ontext
CEE 6410 Fall 2015
Problem 7.4

A farmer plans to develop water for irrigation. He is considering two possible sources of
water: a gravity diversion from a possible reservoir with two alternative capacities and/or a
pump from a lower river diversion (refer to Figure 7.3). Between the reservoir and pump
site the river base flow increases by 2 acft/day due to groundwater drainage into the river.
Ignore losses from the reservoir. The river flow into the reservoir and the farmer's demand
during each of two six-month seasons of the year are given in Table 7.5. Revenue is estimated
at $300 per year per acre irrigated.

Season, t River Inflow, Qt (acft) Irrigation Demand (acft/acre)
1 600 1.0
2 200 3.0

Assume that there are only two possible sizes of reservoir: a high dam that has capacity of
700 acft or a low dam with capacity of 300 acft. The capital costs are $10,000/year and
$6,000/year for the high and low dams, respectively (no operating cost). The pump capacity
is fixed at 2.2 acft/day with a capital cost (if it is built) of $8,000/year and operating cost
of $20/acft.

Integer version using INTEGER VARIABLES statement and SOLVE as MIP.

David E Rosenberg
david.rosenberg@usu.edu
September 28, 2015
$offtext

* 1. DEFINE the SETS
SETS src water supply sources /rh "reservoir high", rl "reservoir low",p "pump"/
    time year /y1 "Season 1", y2 "Season 2"/;

* 2. DEFINE input data
PARAMETERS
   CapCost(src) capital cost ($ to build)
         /rh 10000,
          rl 6000,
          p 8000/
   OpCost(src) operating cost ($ per ac-ft)
         /rh 0,
          rl 0,
          p 20/
   MaxCapacity(src) Maximum capacity of source when built (ac-ft per year)
         /rh 700,
          rl 300,
          p 396/
   Inflow(time) Inflow every season
          /y1 600,
           y2  200/
   Irrigation(time) Inflow every year
          /y1 1,
           y2  3/

    GW  groundwater gain /360/
* 3. DEFINE the variables
VARIABLES I(src) binary decision to build or do prject from source src (1=yes 0=no)
          X(src,time) volume of water provided by source src (ac-ft per year)
          AC acre to be irrigated
          Spill(time) water flow from reservoir to pump per season
          S(time) carryover storage reservoir
          TCOST  Maximum Benfiits-Cost ($);
         

BINARY VARIABLES I;
* Non-negativity constraints
POSITIVE VARIABLES X,AC,Spill,S;

* 4. COMBINE variables and data in equations
EQUATIONS
   COST            Total Cost ($) and objective function value
   massbal(time) reservoir mass balance
   demand(time)  crop water demand
   storcap(time) storage limited by reservoir built
   relcap_h(time) release only if high reservoir built
   relcap_l(time) release only if low reservoir built
   pumpcap(time) pump capacity
   pumpriver(time) pump limited by river flow
   onereservoir        at most one reservoir;

COST..  TCOST =e= 300*AC
                  - sum(src, CapCost(src)*I(src))
                  - sum((src,time), OpCost(src)*X(src,time));

massbal(time)..  S(time++1) =e= S(time) + Inflow(time) - Spill(time)
                                - X('rh',time) - X('rl',time);

demand(time)..   sum(src, X(src,time)) =g= Irrigation(time)*AC;

storcap(time)..  S(time) =l= MaxCapacity('rh')*I('rh') + MaxCapacity('rl')*I('rl');

relcap_h(time)..  X('rh',time) =l= (MaxCapacity('rh') + Inflow(time))*I('rh');
relcap_l(time)..  X('rl',time) =l= (MaxCapacity('rl') + Inflow(time))*I('rl');

pumpcap(time)..  X('p',time) =l= MaxCapacity('p')*I('p');

pumpriver(time).. X('p',time) =l= Spill(time) + GW;

onereservoir..   I('rh') + I('rl') =l= 1;

MODEL Irrig /all/;
SOLVE Irrig USING mip MAXIMIZING TCOST;

* 5. DEFINE the MODEL from the EQUATIONS




* Dump all input data and results to a GAMS gdx file
*Execute_Unload "Ex6-3-integer.gdx";
* Dump the gdx file to an Excel workbook
*Execute "gdx2xls Ex6-3-integer.gdx"
