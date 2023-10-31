README.TXT  
L. Villani, G. Oriolo, B. Siciliano
February 2009

File for use of MATLAB software tools to accompany "Robotics: Modelling,
Planning and Control" by B. Siciliano, L. Sciavicco, L. Villani and G. Oriolo, Springer-Verlag, London, 2009.  The software shall be retrieved by instructors only.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Solutions to programming problems are accompanied by results of computer
implementations in MATLAB (version 7.4) with SIMULINK.

The software is not aimed at providing a complete toolbox, but only at 
giving the code written to solve the end-of-chapter problems. Nonetheless, 
the code has been developed in a modular fashion which should allow direct
expansion to more complex problems as well as ease of changing the
problems data.

For the problems solved in MATLAB, the solution is contained in an
M-file where the first letter is an "s", followed by the problem number,
e.g., "s4_1.m" is the M-file to execute for solving Problem 4.1.

The problems requiring simulation of a dynamic system have been solved 
in SIMULINK, and the solution is contained in a Model-file,  e.g., "s3_21.mdl" 
is the file solving Problem 3.21. Each  problem of this kind requires the 
initialization  of certain variables prior to starting simulation. This is performed
in an M-file where the  first letter is an "i", followed by the problem number, e.g., "i3_21.m" is the M-file containing variables initialization for Problem 3.21.

For both MATLAB- and SIMULINK-based problems, the output plots of
relevant variables are obtained by executing an M-file where the first
letter is a "p", followed by the problem number, e.g., "p3_21.m" is the
initialization file for Problem 3.21.

Variables initialization and plot can be activated by double clicking
respectively on the upper-left block and the lower-right block in the
SIMULINK block diagram.

For problems requiring the simulation of two different systems,
two M-files have been created where letters "a" and "b" have been used
to distinguish them, e.g., "s3_22a.m" and "s3_22b.m" are the M-files for
solving Problem 3.22 with two different algorithms; accordingly, the
M-files for plotting output variables have been named "p3_22a.m" and
"p3_22b.m".

The above files are supplemented by other function and script M-files
which are needed to solve the programming problems.

All the files used to solve a given problem are collected into a folder with 
the same label of the problem, e.g. folder "3_21" contains the files of 
Problem 3.21.
             
If you would like to view this information from within MATLAB, copy the
files into a folder and make sure that the folder is on your MATLAB path.  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Should you have any questions, please contact the authors:
Luigi Villani, Giuseppe Oriolo, Bruno Siciliano
E-mail: luigi.villani@unina.it
            oriolo@dis.uniroma1.it
            bruno.siciliano@unina.it
