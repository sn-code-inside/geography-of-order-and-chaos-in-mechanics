		
                     	 ***********************************************     
                     	 *       What is in the attached software?     *     
                     	 ***********************************************     

Let us examine the attached software and see how to use files and programs. Go to the site
         https://github.com/sn-code-inside/Geography-of-Order-and-Chaos-in-Mechanics
where you will find four folders.			   
	       
**************************** PhaseSpaceGeography ***************************************************

This folder is the most important of the attached software, since it contains the five
MATLAB programs POINCARE, HAMILTON, LAGRANGE, KEPLER and LAPLACE.

The code of the programs is written under Windows10, Windows11, and LinuxMint21.
In Linux be sure that all the executables files are checked as such.

Copy the whole folder "PhaseSpaceGeography" where you wish but preserving the tree structure of the files.
To run KEPLER for example: Start MATLAB, then open the folder "AppDesigner/KEPLER/Master" and
type "Kepler_source" in the MATLAB editor: the relative graphical user interface will open.

Bear in mind that, in the usually very demanding computations of the FMI, the
user can exploit the power of a multicore machine. Indeed KEPLER for example, along with the other four
supplied programs, is able to parallelize the computations in the following
way. If you possess an n-core machine, in the folder "Kepler" and
beside the subfolder "Master" create n-1 subfolders \named Slave1,
Slave2, et cetera, then copy the whole content of "Master" identically in
every folder: the n folders must differ only in the name. Start MATLAB then
KEPLER from the "Master" folder, set the parameters, and click on "File/Save setting now".
Without closing, start a new instance of MATLAB, then KEPLER from a folder
"SlaveX": you will notice that the new button "Start Slave" appears. Click on this button
and KEPLER will wait for the start of the
master. Redo for every slave, and lastly go back to the master and click on
"Calculate ...". The whole work will be automatically shared among the n cores.
The final result is displayed by the master. Warning: do not close any waitbar during the computation.

Alternatively, in Windows you can create n links on the desktop, one for
the master and the others for the slaves. In the "Portraits" folder the
corresponding icons are available, in color and in a gray scale for Master and
Slaves, respectively. In the "Target" field of "Property" you will type something like:
"C:/MATLAB/bin/matlab.exe -r Kepler_source" and in the "Start in" field you will type the path
of the work folder, for example, "C:\PhaseSpaceGeography\AppDesigner\KEPLER\Master" 
or "C:\PhaseSpaceGeography\AppDesigner\KEPLER\SlaveX". 

In "PhaseSpaceGeography" you also find the folders "AddedODEsolver", which contains the added
experimental ODE solvers, "Util", which contains scripts and functions common to all five programs,
and "Portrait" which contains the portraits of the great mathematicians mentioned in
the titles of the programs and the respective icons, both in color and in gray scale;
it contains also the icons used in the graphical interface of the five programs.

*********************** 3D Visualization **************************************************************

Throughout this book there are several two-dimensional examples showing the Arnold web of perturbed
Hamiltonian systems. By stacking several figures of this type --- obtained by varying a third coordinate --- we
can obtain a 3D image of the Arnold web, which in this case will obviously not be made up of slightly thickened
lines but of surfaces, also slightly thickened.

In the subfolder "SQZcrossed" you find the source of three examples, regarding the resonance distribution
in the action space of the Kepler problem with electric and magnetic field. The homonymous "*.mat" files
are the corresponding compiled files, ready to be read and stored in the workspace by double-clicking on them.

The best --- but also the most expensive --- way to visualize these examples is to install
the "Image processing" toolbox of MATLAB and to type "volumeViewer" in the Command Window.
The graphical interface will appear. Navigate to the "3D Visualization" folder and load
the "*.mat" files. In the graphical interface click on "Import Volume/Import from Workspace"
and choose one of the files: the three orthogonal sections with a 3D view will appear.
Choose "jet" in "Built-in Colormaps" and click on the icon "Slice planes": moving the three cursor
you can now explore the volume. For other details see the MATLAB documentation.

A less expressive way --- but free of charge --- consists of typing one the name of the three "*.mlapp" files
in the MATLAB editor. The graphical interface will display three sliders --- one for each of the three
orthogonal views --- and you can begin the exploration by clicking on the slice controllers,
then moving the relative arrows.

******************************* Matlab figures ********************************************************

In the "Matlab figures" folder the reader may find some pictures in the
MATLAB format "*.fig". Many of them are the original ones reported in the book,
as attested by the name itself; others are unpublished and concern some
details. In general they regard FMI computations which require very
long times of the order of many days or weeks, even with a multicore machine,
and may serve as a base to the reader for further explorations. In particular,
one can record the values of the coordinates of some points in the picture and use
them for the computation of the relative orbit, to which a frequency analysis can be applied.

*********************************** Euler ***********************************************************

The EULER program, written in MATLAB and MAPLE language, calculates
analytically, thus exactly, the motion of a point under the
gravitational force of two fixed points. For a detailed study of the Euler
problem with some examples of the graphic output, see my book on the Kepler Problem. The exact
integration is useful for a comparison with the numerical integration of
KEPLER, in order to verify its accuracy.

********************************************************************************
