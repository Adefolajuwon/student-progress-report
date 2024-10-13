# Load necessary library
library(dplyr)

# Simulate student data
students <- data.frame(
  student_id = c(1, 2, 3),
  name = c("Juwon", "Feranmi", "Charles"),
  password = c("juwon123", "feranmi123", "charles123")
)

# Simulate assignments data
assignments <- data.frame(
  assignment_id = 1:5,
  assignment_name = c("Math Assignment", "Science Assignment", "History Assignment", "Art Assignment", "PE Assignment"),
  expected_time_to_complete = c(2, 3, 1, 4, 1) # in hours
)

# Simulate student assignment status (1 - completed, 0 - in progress, NA - not started)
student_assignments <- data.frame(
  student_id = c(1, 1, 1, 2, 2, 3, 3, 3),
  assignment_id = c(1, 2, 3, 1, 2, 1, 4, 5),
  status = c(1, 0, NA, 1, 1, 0, NA, NA)
)

# Login function with input validation and max attempts
student_login <- function(max_attempts = 3) {
  attempts <- 0
  repeat {
    name <- readline(prompt = "Enter your name: ")
    password <- readline(prompt = "Enter your password: ")
    
    attempts <- attempts + 1
    if (name == "" || password == "") {
      cat("\n⚠️  Both name and password are required. Please try again.\n")
    } else {
      student <- students %>% filter(name == !!name & password == !!password)
      if (nrow(student) > 0) return(student$student_id)
      else cat("\n❌ Invalid credentials. Please try again.\n")
    }
    
    if (attempts >= max_attempts) {
      cat("\n🚫 Too many failed attempts. Exiting.\n")
      return(NULL)
    }
  }
}

# Fetch assignments for a student
fetch_assignments <- function(student_id) {
  student_data <- student_assignments %>% filter(student_id == !!student_id)
  
  assignments_progress <- student_data %>% filter(status == 0) %>%
    left_join(assignments, by = "assignment_id") %>%
    select(assignment_name)
  
  assignments_completed <- student_data %>% filter(status == 1) %>%
    left_join(assignments, by = "assignment_id") %>%
    select(assignment_name)
  
  assignments_undone <- assignments %>%
    filter(!(assignment_id %in% student_data$assignment_id)) %>%
    select(assignment_name, expected_time_to_complete)
  
  return(list(
    in_progress = assignments_progress,
    completed = assignments_completed,
    undone = assignments_undone
  ))
}

# Function to display the assignment report
display_assignments_report <- function(report) {
  cat("\n==========================\n")
  cat("📚 Assignments in Progress:\n")
  if (nrow(report$in_progress) > 0) {
    print(report$in_progress)
  } else {
    cat("No assignments in progress.\n")
  }
  
  cat("\n==========================\n")
  cat("✅ Assignments Completed:\n")
  if (nrow(report$completed) > 0) {
    print(report$completed)
  } else {
    cat("No assignments completed.\n")
  }
  
  cat("\n==========================\n")
  cat("⏳ Assignments Not Started (with expected completion time):\n")
  if (nrow(report$undone) > 0) {
    print(report$undone)
  } else {
    cat("No assignments left undone.\n")
  }
  cat("==========================\n\n")
}

# Get user input and fetch assignments
student_id <- student_login()

if (!is.null(student_id)) {
  assignments_report <- fetch_assignments(student_id)
  display_assignments_report(assignments_report)
} else {
  cat("\n❌ Login failed or too many attempts. Exiting.\n")
}
