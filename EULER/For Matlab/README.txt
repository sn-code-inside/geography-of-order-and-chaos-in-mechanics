                        *** How to use ***
              
Copy the folder on the hard disk, open MATLAB and navigate to the folder, then
type <Euler> in the Command Window of MATLAB: the Graphical User Interface will appear.

******************************************************************************
***************  The Euler Problem of the two Fixed Centers  *****************
************************  bruno.cordani@unimi.it  ****************************
******************************************************************************
       
 The Euler problem consists in finding the plane motion of a particle which is 
 subjected to the gravitational attraction of two fixed masses: the primary, with 
 mass = 1 and lying in the origin of the Cartesian coordinates, and the secondary, 
 with mass = m and lying in the point (0,2). We use the method of separation 
 of variables in the Hamilton-Jacobi equation written in elliptic-hyperbolic coordinates. 
 The problem is so reduced to the quadratures, i.e., to performing some integrals. 
 In the present case, the involved integrals are the elliptic ones of the first 
 kind, and the central question is how to reduce them to the canonical form of Legendre.
 For details see the book: B. Cordani, The Kepler Problem, 2003, Birkhäuser on page 179.
 First of all we must define the initial position in Cartesian coordinates
 of the moving particle, giving its position x and y, its initial velocity Vx and 
 Vy, the value, between 0 and 1, of the second mass m. To improve the graphic
 result the parameter step may be reduced; however, this increases the processing time.
 Once the initial conditions and the mass m have been chosen, the program calculates the
 value of the two first integrals H and gamma, which determine the type of orbit: see the
 figure on the graphical interface and the above-mentioned book on page 179.
 The evolutive parameter - which regularizes the two singulatities -
 varies between 0 and Total time. Be aware of the fact that with
 some initial conditions the program reports error, since the limit cases of multiple 
 roots in the integrand can not be treated; notice however that the integrals 
 involved in this limiting cases are elementary. When the total energy H is positive,
 the orbits are not periodic and the Total time must be chosen 
 not too great; proceed by trials, beginning with Total time = 1. Anyway if the value
 of Total time is too large and exceeds the threshold that allows for a correct
 numerical evaluation, the orbit calculation stops there. Sometimes, when the
 moving mass transits very close to one of the fixed masses, it may
 follow the wrong path, continuing with an almost straight trajectory instead
 of circling the fixed mass; try to fix the drawback by reducing the step
 but take into account that the problem is "structural", since the x-coordinate
 is defined as a square root and the algorithm that avoids the "rebound" requires
 that the closer the mass m passes to a fixed mass, the more the step needs to be decreased.