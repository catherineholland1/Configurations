
####################################
## configuration function example ##
####################################

library(zCompositions)

data(Water)

####################################


source("configuration_function.R")


# run function
water_configs <- configurations(Water)

# extract information from function
water_configs$`Components containing a zero`
water_configs$`Proportion of zeros`
water_configs$`Number of Configurations`


# extract the configurations
w_configs <- water_configs$Configurations



####################################


source("configuration_replacement_function.R")


# run replacement function
# using multiplicative replacement and merging configuations that are contain less than 5% of total data
replaced_configuations <- configurations_replacement(w_configs, percent_nconfig = 0.05, replace_type = "multiplicative", plot = TRUE)

# n in the new configurations
replaced_configuations$`n in replaced configurations`

# replaced configurations
replaced_configuations$`Replaced Configurations`



####################################
