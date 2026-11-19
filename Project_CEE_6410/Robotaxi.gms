$ontext
CEE 6410 Fall 2020
Optimization of Charging and Operational Strategies for a Robotaxi Ride-Hailing Fleet

Model Formulation:

Assumptions
    The project covers a small urban area. 
    There is one zone with a limited number of chargers.
    Time is split into 3-time windows: morning, afternoon and evening.
    Demand is known in advance and differs in each window.
    Deployed vehicles have an operational cost throughout the deployment (even in idle).
    Charging also incurs a cost. 
    Partial charging is allowed. A vehicle can charge up to the maximum capacity of the battery.
    A full battery lasts an entire period. 
    At the beginning of each window, a vehicle can have 4 statuses: charging, deployed but idle, on trip, or not deployed at all.
    Trip durations are fixed. So, a vehicle on trips completes a maximum number of trips per window.
    The revenue from each trip is fixed.

Dimensions:
Time, Status [Not Deployed, Deployed Idle, Deployed Charging, Deployed in Trip], Vehicles


Decision Variables:
    Status of each vehicle in each window: not deployed, deployed but idle, charging, or on trips (binary). A vehicle has exactly one status in each window.
    How much to charge each vehicle in each window (continuous).
    How many trips each vehicle serves in each window (whole number).
    Battery level of each vehicle at the start of each window (continuous)
Constraints:
    All deployed vehicles are assigned to one of the six zones at start. So each deployed vehicle from warehouse will go to one of the six zones.
    ∑▒〖All deployed Taxis≤Maximum Capacity〗  of Taxis
    Vehicle in trip + Vehicle charging + Vehicle not deployed + Vehicle deployed idle <= 1. So, a taxi can have only one status at each window.
    For each taxi battery level at next window (t+1) =
Battery now(t) – trips within that window * battery drainage per trip + Charge added
    Battery charging capacity <= Max Capacity of the battery.
    A vehicle cannot start a trip if its charge is not enough to complete the whole trip. That includes, from pickup point, the whole trip duration to coming back at idling station.
For each taxi, trip begins if Battery level >= battery drainage per trip*Number of trips per window.
    Only a maximum number of vehicles can be charging due to limited number of chargers. 
∑▒〖Taxis charging≤Chargers〗
    Trips are served only by a vehicle that is on trips, and no more than the maximum number of trips per window.
    A vehicle cannot serve a trip if its charge is not enough to complete the whole trip, from the pickup point through the trip duration to coming back to the idling station. So, for each vehicle, battery now ≥ trips served × battery used per trip.
    Trips cannot exceed demand in that window.
     At the start of the morning window, all vehicle is at max battery capacity and all vehicles are deployed from warehouse.
Objective Function:
Max Profit = Profit from Trips – Charging Cost – Operational Cost (For each deployed vehicle)
Expected Results:
How many cars will be deployed, the total profit.


Programmed by David E. Rosenberg
October 26, 2015
Updated October 23, 2018
david.rosenberg@usu.edu
$offtext

*****************************************
** PART I. Simpler Problem Ignoring Status Tracking of Each Vehicle
********************************

*1. Define the sets
SETS v  vehicles / v1*v100 /
     t windows  / morning, afternoon, evening /;

*2. Define th input data
Parameter demand(t) trips demand in each window / morning 200, afternoon 170, evening 240 /;

Scalars
   maxTrips max trips per vehicle per window          / 4  /
   revenue  revenue per trip ($)                      / 50 /
   opCost   operating cost per deployed vehicle per window ($) / 80 /;


*3. Define the decision variables
BINARY VARIABLES deploy(v,t);
INTEGER VARIABLES trips(v,t);
VARIABLE profit;
trips.UP(v,t) = maxTrips;

*4. Define the equations
Equations
    obj Revenue from trips - Operational costs
    cap(v,t) A vehicle serves trips only if deployed and maximum trips in a window is limited to 4
    dem(t)  The trips served in a window can not exceed demand;
    

obj..      profit =e= sum((v,t), revenue*trips(v,t) - opCost*deploy(v,t));
cap(v,t).. trips(v,t) =l= maxTrips*deploy(v,t);
dem(t)..   sum(v, trips(v,t)) =l= demand(t);


Model deployModel / all /;
Solve deployModel using mip maximizing profit;

Parameter deployed(t), served(t);
Scalar totalTrips;
deployed(t) = sum(v, deploy.l(v,t));
served(t)   = sum(v, trips.l(v,t));
totalTrips  = sum(t, served(t));
display profit.l, deployed, served, totalTrips;