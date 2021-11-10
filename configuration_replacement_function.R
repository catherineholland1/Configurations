


################################################################################

## configuration replacement function ##

################################################################################


configurations_replacement <- function(Configurations, percent_nconfig = 0.1, replace_type = "multiplicative", plot = TRUE) {
  
  # n in configurations
  n_configuration <- vector()
  for (i in 1:length(Configurations)) {
    n_configuration[i] <- nrow(Configurations[[i]])
  }
  
  n_percent = n_configuration / sum(n_configuration)
  
  if (all(n_percent > 0.05)) {
    message("The number in each configuration is greater than chosen % of total observations, no merging of configurations needed.") 
  } else {
    
    new_configurations <- list()
    
    # dealing with small n in configuration
    allpresent <- 1
   
    for (j in 1:length(Configurations)) {
      
      if (n_percent[j] < percent_nconfig) {
        
          if (n_percent[allpresent] > percent_nconfig) {
          
            # combine into another configuration
            Configurations[[allpresent]] <- 
                rbind(Configurations[[allpresent]], Configurations[[j]])
          
          } 
        } 
        
        new_configurations <- subset(Configurations, n_percent > percent_nconfig)
        
      }
    
    # replacement 
    replaced_configurations <- vector("list", length(new_configurations))
    
    for (k in 1:length(new_configurations)) {
      
      if (length(unique(new_configurations[[k]]$config)) > 1) {
        
        if (replace_type == "simple") {
          # simple
          replaced_configurations[[k]] <- new_configurations[[k]][, -dim(new_configurations[[k]])[2]]
          
          replaced_configurations[[k]][replaced_configurations[[k]] == 0] <- 0.000001
          
        } else if (replace_type == "multiplicative") {
          # multiplicative simple
          replaced_configurations[[k]] <- multRepl(new_configurations[[k]][,-dim(new_configurations[[k]])[[2]]], 
                                                   label = 0, dl = rep(1, dim(new_configurations[[k]])[2] - 1)) 
          
        } else if (replace_type == "EM") {
          # EM
          replaced_configurations[[k]] <- lrEM(new_configurations[[k]][,-dim(new_configurations[[k]])[[2]]], 
                                               label=0, dl=rep(1, dim(new_configurations[[k]])[2] - 1), 
                                               ini.cov="multRepl")
          
        } 
      } else {
        
        replaced_configurations[[k]] <- new_configurations[[k]][,-dim(new_configurations[[k]])[[2]]]
        
      }
    }
    
    # updated n configuration
    n_replaced_configurations <- vector(length = length(replaced_configurations))
    
    for (m in 1:length(replaced_configurations)) {
      
      # updated n within each configuration
      n_replaced_configurations[m] <- nrow(replaced_configurations[[m]])
      names(n_replaced_configurations)[m] <- paste0("n_configuration", sep = "_", m)
      
    }
  }
  
  # plot
  if (plot == TRUE) {
    output <- data.frame(Reduce(rbind, replaced_configurations))
    zPatterns(output, label = 0,
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
  
  return(list(#"Updated Configurations" = new_configurations,
    #print('----------------------------------------------------------'),
    "n in replaced configurations" = n_replaced_configurations,
    "Replaced Configurations" = replaced_configurations))
  
}



