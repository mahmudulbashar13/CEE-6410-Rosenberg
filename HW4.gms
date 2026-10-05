$ontext
Reservoir Problem
September 15, 2015
$offtext

* 1. DEFINE the SETS
SETS time  month /1, 2, 3, 4, 5, 6/
     spatial water flow /turbine,irrigation,reservoir,spill,A/;


* 2. DEFINE input data
PARAMETERS
   
    
   inflow(time) Inflow
         /1 2,
          2 2,
          3 3,
          4 4,
          5 3,
          6 2/;

SCALARS
    reservoirmax     reservoir capcaity          /9/
    reservoirinit    reservoir initial storage  /5/
    turbinemax    Turbine capacity             /4/
    Amin     Minimum flow at A                /1/ ;

TABLE A(time,spatial) Benifits
           turbine  irrigation  reservoir   spill   A  
 1         1.6      1.0         0           0       0    
 2         1.7      1.2         0           0       0
 3         1.8      1.9         0           0       0
 4         1.9      2.0         0           0       0
 5         2.0      2.2         0           0       0
 6         2.0      2.2         0           0       0;

* 3. DEFINE the variables
VARIABLES
    X(time,spatial) Quantity of water flow each month to each location,
    VCOST  total benifits ($);



* Non-negativity constraints
POSITIVE VARIABLES X(time,spatial);

* 4. COMBINE variables and data in equations
EQUATIONS
    COST Total cost ($) and objective function value
    resemassbalance(time)     Reservoir storage mass balance
    spill(time)       water flow to spill
    Aminimum(time)    minimum flow to A
    resendstorage           Ending storage >= beginning storage
    turbinecap(time)     turbine capacity
    resmax(time)      reservoir capacity limit ;
    
COST..                 VCOST =E= SUM((time,spatial), A(time,spatial)*X(time,spatial));
resemassbalance(time)..   X(time,'reservoir') - reservoirinit$(ord(time) eq 1)
                          - X(time-1,'reservoir')$(ord(time) gt 1)
                          =E= inflow(time) - X(time,'turbine') - X(time,'spill');
spill(time)..             X(time,'turbine') + X(time,'spill')
                          =E= X(time,'irrigation') + X(time,'A');

Aminimum(time)..          X(time,'A') =G= Amin;

resendstorage..           X('6','reservoir') =G= reservoirinit;

turbinecap(time)..        X(time,'turbine') =L= turbinemax;

resmax(time)..            X(time,'reservoir') =L= reservoirmax;

* 5. DEFINE the MODEL from the EQUATIONS
MODEL Reservoir /ALL/;
*Altnerative way to write (include all previously defined equations)
*MODEL PLANTING /ALL/;

OPTION LIMROW = 10;
* 6. SOLVE the MODEL
* Solve the Network model using a Linear Programming Solver (see File=>Options=>Solvers)
*     to minimize VCOST
SOLVE Reservoir USING LP MAXIMIZING VCOST;


* 6. CLick File menu => RUN (F9) or Solve icon and examine solution report in .LST file
