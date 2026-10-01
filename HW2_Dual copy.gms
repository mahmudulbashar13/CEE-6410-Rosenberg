$ontext
Hay Grain Problem
$offtext

* 1. DEFINE the SETS
SETS crop crops growing /Hay, Grain/
     res resources /June, July, August, Totalcars/;

* 2. DEFINE input data
PARAMETERS
   c(crop) Objective function coefficients ($ per plant)
         /Hay 100,
         Grain 120/
   b(res) Right hand constraint values (per resource)
          /June 14000,
           July  18000,
           August 6000,
           Totalcars 10000/;

TABLE A(crop,res) Left hand side constraint coefficients
                 June    July  August Totalcars
 Hay             2       1     1      1   
 Grain           1       2     0      1;

* 3. DEFINE the variables
VARIABLES X(crop) plants planted (Number)
          VPROFIT  total profit ($)
          Y(res)  value of resources used (units specific to variable)
          VREDCOST total reduced cost ($);

* Non-negativity constraints
POSITIVE VARIABLES X,Y;

* 4. COMBINE variables and data in equations
EQUATIONS
   PROFIT_PRIMAL Total profit ($) and objective function value
   RES_CONS_PRIMAL(res) Resource constraints
   REDCOST_DUAL Reduced Cost ($) associated with using resources
   RES_CONS_DUAL(crop) Profit levels ;

*Primal Equations
PROFIT_PRIMAL..                 VPROFIT =E= SUM(crop,c(crop)*X(crop));
RES_CONS_PRIMAL(res) ..    SUM(crop,A(crop,res)*X(crop)) =L= b(res);


*Dual Equations
REDCOST_DUAL..                 VREDCOST =E= SUM(res,b(res)*Y(res));
RES_CONS_DUAL(crop)..          sum(res,A(crop,res)*Y(res)) =G= c(crop);

X.LO(crop) = 5;

* 5. DEFINE the MODELS
*PRIMAL model
MODEL PLANT_PRIMAL /PROFIT_PRIMAL, RES_CONS_PRIMAL/;
*Set the options file to print out range of basis information
PLANT_PRIMAL.optfile = 1;

*DUAL model
MODEL PLANT_DUAL /REDCOST_DUAL, RES_CONS_DUAL/;

* 6. SOLVE the MODELS
* Solve the PLANTING PRIMAL model using a Linear Programming Solver (see File=>Options=>Solvers)
*     to maximize VPROFIT
SOLVE PLANT_PRIMAL USING LP MAXIMIZING VPROFIT;

* Solve the PLANTING DUAL model using a Linear Programming Solver (see File=>Options=>Solvers)
*     to maximize VPROFIT
SOLVE PLANT_DUAL USING LP MINIMIZING VREDCOST;
*Order does not matter!

* 6. CLick File menu => RUN (F9) or Solve icon and examine solution report in .LST file

* 7 . Dump all data and results to GAMS proprietary file storage .gdx and to Excel
Execute_Unload "ExHW2Dual.gdx";
* Dump the gdx file to an Excel workbook
Execute "gdx2xls ExHW2Dual.gdx"
* To open the GDX file in the GAMS IDE, select File => Open.
* In the Open window, set Filetype to .gdx and select the file.
