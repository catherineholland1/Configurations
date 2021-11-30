# Configurations
R Functions to deal with data by splitting up into configurations based on presence and absence of components. 

Uses `zCompositions` package (J Palarea-Albaladejo and JA Martin-Fernandez, [2015]) (http://dx.doi.org/10.1016/j.chemolab.2015.02.019)


Full example run of both functions within 'configuration_example.R'


`configuration_function.R`

Takes a dataset and spilts it up into configurations based on the prescence and absence of the components. 

The function outputs: 
  - List of components that contain an absence;
  - Proportion of zero;
  - The number of Configurations;
  - The number of observations in each configuration;
  - The configurations created.

If `plot == TRUE` is defined then a plot of the configurations will be produced.


`configuration_replacement_function.R`

Takes the configurations created in configuration_function.R as a list and merges configurations based on a percentage of the number within each component / total number. 
i.e if the % in configuration i is a user-defined % then configuration i would be combined with the configuration where all the components are present. The zero values are then replaced using a method defined by the user (simple, additive, multiplicative, EM).

The function outputs: 
  - The number of observations in each configuration after the function has dealt with;
  - The replaced configurations created.

If `plot == TRUE` is defined then a plot of the replaced configurations will be produced.
