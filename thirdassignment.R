# Data load (ek hi baar)
outcome_data <- read.csv("outcome-of-care-measures.csv", 
                         colClasses = "character", 
                         header = TRUE)

# Best function
best <- function(state, outcome) {
  data <- outcome_data
  
  # outcome column mapping
  outcome_map <- c("heart attack" = 11, 
                   "heart failure" = 17, 
                   "pneumonia" = 23)
  
  # validation
  if (!(outcome %in% names(outcome_map))) stop("invalid outcome")
  if (!(state %in% data$State)) stop("invalid state")
  
  col <- outcome_map[outcome]
  state_data <- data[data$State == state, ]
  state_data[, col] <- suppressWarnings(as.numeric(state_data[, col]))
  
  min_value <- min(state_data[, col], na.rm = TRUE)
  best_hospitals <- state_data[state_data[, col] == min_value, "Hospital.Name"]
  
  return(sort(best_hospitals)[1])
}


# Rank Hospital function
rankhospital <- function(state, outcome, num = "best") {
  data <- outcome_data
  
  outcome_map <- c("heart attack" = 11, 
                   "heart failure" = 17, 
                   "pneumonia" = 23)
  
  if (!(outcome %in% names(outcome_map))) stop("invalid outcome")
  if (!(state %in% data$State)) stop("invalid state")
  
  col <- outcome_map[outcome]
  state_data <- data[data$State == state, c("Hospital.Name", "State", col)]
  
  state_data[, 3] <- suppressWarnings(as.numeric(state_data[, 3]))
  state_data <- state_data[complete.cases(state_data), ]
  
  # sort by mortality rate, then hospital name
  state_data <- state_data[order(state_data[, 3], state_data[, 1]), ]
  
  if (num == "best") num <- 1
  if (num == "worst") num <- nrow(state_data)
  
  if (num > nrow(state_data)) return(NA)
  
  return(state_data[num, "Hospital.Name"])
}



# Rank All function
rankall <- function(outcome, num = "best") {
  data <- outcome_data
  outcome_map <- c("heart attack" = 11, 
                   "heart failure" = 17, 
                   "pneumonia" = 23)
  
  if (!(outcome %in% names(outcome_map))) stop("invalid outcome")
  
  col <- outcome_map[outcome]
  data[, col] <- suppressWarnings(as.numeric(data[, col]))
  data <- data[complete.cases(data[, col]), ]
  
  states <- sort(unique(data$State))
  result <- data.frame(hospital = character(), state = character(), stringsAsFactors = FALSE)
  
  for (s in states) {
    state_data <- data[data$State == s, c("Hospital.Name", "State", col)]
    state_data <- state_data[order(state_data[, 3], state_data[, 1]), ]
    
    if (num == "best") n <- 1
    else if (num == "worst") n <- nrow(state_data)
    else n <- num
    
    hosp <- if (n > nrow(state_data)) NA else state_data[n, "Hospital.Name"]
    
    result <- rbind(result, data.frame(hospital = hosp, state = s, stringsAsFactors = FALSE))
  }
  
  return(result)
}
