* 1. DEFINE the SETS
SETS cars  car produced /Coup, Minivan/
     res resources /Metal, Circuit, Labor/;

* 2. DEFINE input data
PARAMETERS
   c(cars) Objective function coefficients ($ per plant)
         /Coup 6000,
         Minivan 7000 /

   b(res) Right hand constraint values (per resource)
          /Metal 4000000,
           Circuit  12000,
           Labor  17500/;

TABLE A(cars,res) Left hand side constraint coefficients
                 Metal    Circuit  Labor
 Coup           1000      4        5
 Minivan        2000      3        2.5;


* 3. DEFINE the variables
VARIABLES X(cars) cars produced (Number)
          VPROFIT  total profit ($);

* Non-negativity constraints
POSITIVE VARIABLES X;

* 4. COMBINE variables and data in equations
EQUATIONS
   PROFIT Total profit ($) and objective function value
   RES_CONSTRAIN(res) Resource Constraints;

PROFIT..                 VPROFIT =E= SUM(cars, c(cars)*X(cars));
RES_CONSTRAIN(res) ..    SUM(cars, A(cars,res)*X(cars)) =L= b(res);


* 5. DEFINE the MODEL from the EQUATIONS
MODEL PRODUCTION /PROFIT, RES_CONSTRAIN/;
*Altnerative way to write (include all previously defined equations)
*MODEL PLANTING /ALL/;


* 6. SOLVE the MODEL
* Solve the PLANTING model using a Linear Programming Solver (see File=>Options=>Solvers)
*     to maximize VPROFIT
SOLVE PRODUCTION USING LP MAXIMIZING VPROFIT;


* 6. CLick File menu => RUN (F9) or Solve icon and examine solution report in .LST file
