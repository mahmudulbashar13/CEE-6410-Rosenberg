*Dimensions
*Time (month) -june,july,august
*Spatioanl (network)- spill, diversion, reservoir storage
*Decision Variables
*How much to release to diversion in time t
*Xdiversion,t [acre-feet], 3 Decision Variables
*How much to keep in reservoir storage at the end of time t
* X Reservoirstorage, [acre-feet], 3 decision variables
*Constraints are gonna cosntrain what decision varaiables can take
*How much water to spill in time t
*X spill [acre-feet], 3 decision variables
*Objective Function
*Maximize irrigation benifits($)
*Max Z = XDiv,june X 150 +Xdiv,jul X 170 + Xdiv,aug X 425
*     = Sum (t=june, aug) Ct * Xdiver,t   + Sum (t=june, aug) 0 * Xspill,t + Sum (t=june, aug) 0 * Xreservoir,t     Simplex requires every decision variables to be present in the objective function
*Constraints:
*           Max Reservoir capacity has to be  9000 ac-ft - 3 constraints, each month
*           Ending storage >=3000 ac-ft beginning storage, 1 constraint, 1 at the beginning of the period and 1 at the end of the total period
*           
*           Inflow >= (Sotrage,t - Sotrage,t-1) + Spill,t + Irrigation,t
*           Delta storage = Inflow -outflow (Needs Rearranging)
*           Also non negativity
*           Delta (Sotrage,t - Sotrage,t-1) = Inflow,t - Spill,t - Irrigation, t
*           Storage, August - Initial Storage = Sum (Inflow, june to August) - Sum (Spill, june to August) -Sum (Irrigation, june to August)
*           Storage, August - Storage, June = Sum (Inflow, june to August) - Sum (Spill, june to August) -Sum (Irrigation, june to August)
* X(s,t) s is three t is three so its 9
* X("Reservoir Storage","June")
* The constraint equation for you
* Res Balance (t) = X("ReservoirStorage",t)- InitialStorage$(ord(t)eq 1) - X("ReservoirStorage", t-1)$(ord(t)gt 1)>= X("Inflow",t) - X("Irrigation",t)- X("Spill",t)
*We can introduce a $ sign which is like an if else so we include it, ord(t) it is greater than 1 so its element number, so our t- is june,july,aug
*so it will only include initial storae when element number is equal to 1 , and only include t-1 reservoir storage when greater than 1)

*Automobiles problem
*Dimensions
*   Suppliers - Kansas, Dallas
*   Dealers -
*Decision Variables
* The number of cars from each supplier to dealer 8 Decision Variables X(Supplier, Dealer)
*Objective Funciton: Minimize Shipping Cost, Min Z = Sum C(Supplier, Dealer) * X(Supplier, Dealer)
* Sum ((Suppliers,Dealers),C(supplier,dealer). X(supplier,dealer))
*Sum (Suppliers, C(Supplier, "New York")), repeat for every dealer

*

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
