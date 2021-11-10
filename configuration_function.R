


################################################################################

## configuration function ##

################################################################################


library(zCompositions)


configurations <- function(data, plot_configurations = TRUE) {
  
  # total number of elements
  D = ncol(data)
  
  # elements always present
  AlwaysPres <- sum(apply(data != 0, 2, sum) == nrow(data)) 
  
  # elements absent
  absent <- colnames(data[apply(data != 0, 2, sum) != nrow(data)])
  
  # number of configurations
  #nconfig <- 2^(D-AlwaysPres)
  
  # proportion of zeros
  p_zero <- rep(0, ncol(data))
  names(p_zero) <- colnames(data)
  for (i in 1:ncol(data)) {
    p_zero[i] <- round((sum(data[, i] == 0) / nrow(data)) * 100, 2)
  }
  
  
  config <- zPatterns(data, label = 0, plot = FALSE)
  
  patterns_dat <- cbind(data, config)
  
  configurations <- list()
  n_configuration <- vector(length = length(levels(config)))
  
  for (j in 1:length(levels(config))) {
    
    # configurations
    configurations[[j]] <- subset(patterns_dat, config == j)
    names(configurations)[[j]] <- paste0("configuration", sep = "_", j)
    
    # n within each configuration
    n_configuration[j] <- nrow(configurations[[j]])
    names(n_configuration)[j] <- paste0("n_configuration", sep = "_", j)
    
  }
  
  # indicator
  #indicator_configurations <- configurations
  #for (p in 1:length(indicator_configurations)) {
    
   # indicator_configurations[[p]] <- ifelse(indicator_configurations[[p]] != 0, 1, 0)
    
  #}
  
  if (plot_configurations == TRUE) {
    
    zPatterns(data, label = 0,
              axis.labels = c("Component", "Configuration"),
              bar.ordered = c(FALSE, FALSE),
              bar.colors = c("skyblue1", "lightsalmon1"),
              cell.colors = c("thistle1", "grey94"),
              cell.labels = c("Zero", "Non-Zero"),
              grid.color = "black", grid.lty = "dotted",
              legend = TRUE,
              bar.labels = TRUE, 
              show.means = TRUE,
              type.means = "cgm",
              cex.axis = 0.75) 
  }
  
  return(list("Components containing a zero" = absent,
              "Proportion of zeros" = p_zero,
              "Number of Configurations" = length(configurations),
              "n within each configuration" = n_configuration,
              "Configurations" = configurations
              #,
              #print('----------------------------------------------------------'),
              #"Indicator Configurations" = indicator_configurations
  ))
  
}

  