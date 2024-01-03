#Cosmogenic Tadpole

A landscape evolution model with cosmogenic nuclide conservation based on Ferrier and Perron (2020). This is a distant fork of the Tadpole landscape evolution model (Perron et al., 2008; 2009; 2012; Richardson et al. 2020a; 2020b). This model code was used in Reed et al. (2023, in prep).

The 2D, MATLAB-based model computes transient changes in topography, soil thickness, soil mineral concentrations, and soil cosmogenic nuclide concentrations stemming changes in rock uplift rate ("tectonic") or hillslope process efficiencies ("climatic"). The model runs in GNU Octave with TCN profile tracking turned off.

Load initial conditions, parameters, production rate pchip interpolants from steady_state_U_50mmkyr-1.mat.

Alter p.experiment_type to 'tectonic' or 'climatic'

admwx()

or

Generate initial topography grid in another landscape evolution model like Tadpole (Richardson et al. 2020). This version of the model does not include dynamic channels (e.g., stream-power incision). Extract channel network grid beginning at selected drainage area (e.g., 5000 m2).

Generate grids of soil thickness (H), mineral concentrations (X), and soil and bedrock nuclide concentrations (Ns & Nzb) using startup.m.

Run admwx() with p.experiment_type='steady-state' until steady-state conditions attained -- several Myr

Run admwx() with p.experiment_type='tectonic' or 'climatic'

References:

Ferrier, K. L., & Perron, J. T. (2020). The importance of hillslope scale in responses of chemical erosion rate to changes in tectonics and climate. Journal of Geophysical Research: Earth Surface, 125(9), e2020JF005562.

Perron, J. T., Dietrich, W. E., & Kirchner, J. W. (2008). Controls on the spacing of first‐order valleys. Journal of Geophysical Research: Earth Surface, 113(F4).

Perron, J.T., J.W. Kirchner and W.E. Dietrich (2009), Formation of evenly spaced ridges and valleys. Nature, 460, 502–505, doi: 10.1038/nature08174.

Perron, J. T., Richardson, P. W., Ferrier, K. L., & Lapôtre, M. (2012). The root of branching river networks. Nature, 492(7427), 100-103.

Richardson, P. W., Perron, J. T., Miller, S. R., & Kirchner, J. W. (2020a). Unraveling the mysteries of asymmetric topography at Gabilan Mesa, California. Journal of Geophysical Research: Earth Surface, 125(7), e2019JF005378.

Richardson, P. W., Perron, J. T., Miller, S. R., & Kirchner, J. W. (2020b). Modeling the formation of topographic asymmetry by aspect‐dependent erosional processes and lateral channel migration. Journal of Geophysical Research: Earth Surface, 125(7), e2019JF005377.

Reed M.R., Ferrier K.L., & Perron, J. T. (2023). Modeling cosmogenic nuclides in transiently evolving topography and chemically weathering soils. in prep.

