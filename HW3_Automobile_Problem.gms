$ontext
CEE 6410 - Network Shipping Problem - Automobiles

An automobile company must decide how to move cars from suppliers in Kansas City and Dallas to dealerships in New York, Minneapolis, Seattle, and San Francisco.

THE PROBLEM:

Each supplier has a specified number of cars in stock and each dealership has an expected number of sales. Data are as fol-lows:


Inputs:    Suppliers   Dealers
Cost of each route: Rows are suppliers, Coloumns are dealers.
                New York            Minneapolis     Seattle     San Francisco
Kansas          $4                  $12             $18         $18
Dallas          $9                  $15             $17         $21              

Determine the shipping volumes that will minimze cost.

THE SOLUTION:
Minimize shipping cost.

David E Rosenberg
david.rosenberg@usu.edu
September 15, 2015
$offtext

* 1. DEFINE the SETS
SETS suppliers  cars in stock /Kansas, Dallas/
     dealers expected sales /Minneapolis, Newyork, Sanfrancisco, Seattle /;

* 2. DEFINE input data
PARAMETERS
   c(suppliers) Capacity of cars
         /Kansas 1000,
          Dallas 800 /

   b(dealers) Expected sales in quantity of cars
          /Minneapolis 400,
           Newyork  250
           Sanfrancisco 450,
           Seattle  450/;

TABLE A(suppliers,dealers) Cost of each supplier to dealer route
                 Minneapolis  Newyork  Sanfrancisco Seattle  
 Kansas          4            12       18           18
 Dallas          9            15       17           21;


* 3. DEFINE the variables
VARIABLES
    X(suppliers,dealers) Quantity of cars to send from one supplier to one dealer 8 dimensions total,
    VCOST  total cost ($);
*X1 From Kansas to Newyork
*X2 From Kansas to Minneapolis
*X3 From kansas to Seattle
*X4 From Kansas to San Francisco
*Y1 From Dallas to Newyork
*Y2 From Dallas to Minneapolis
*Y3 From Dallas to Seattle
*Y4 From Dallas to San Francicso


* Non-negativity constraints
POSITIVE VARIABLES X;

* 4. COMBINE variables and data in equations
EQUATIONS
   COST Total cost ($) and objective function value
   RES_CONSTRAIN1(suppliers) constraint of how many cars are in stock for each supplier,RES_CONSTRAIN2(dealers) constraint of minimum number of cars sold by each dealer ;

COST..                 VCOST =E= SUM((suppliers,dealers), A(suppliers,dealers)*X(suppliers,dealers));
RES_CONSTRAIN1(suppliers) ..    SUM(dealers, X(suppliers,dealers)) =L= c(suppliers);
RES_CONSTRAIN2(dealers) ..    SUM(suppliers, X(suppliers,dealers)) =G= b(dealers);


* 5. DEFINE the MODEL from the EQUATIONS
MODEL NETWORK /COST, RES_CONSTRAIN1,RES_CONSTRAIN2/;
*Altnerative way to write (include all previously defined equations)
*MODEL PLANTING /ALL/;

OPTION LIMROW = 10;
* 6. SOLVE the MODEL
* Solve the PLANTING model using a Linear Programming Solver (see File=>Options=>Solvers)
*     to maximize VPROFIT
SOLVE NETWORK USING LP MINIMIZING VCOST;


* 6. CLick File menu => RUN (F9) or Solve icon and examine solution report in .LST file
