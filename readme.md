## How to Run the Program

1. Clone or download the project to your local machine.
2. Open a terminal and navigate to the project folder.
3. Run the script using the following command:

    ```bash
    Rscript main.r
    ```

4. You will be prompted to enter your name and password to log in. For testing, you can use one of the following credentials:

    | Name    | Password   |
    |---------|------------|
    | Juwon   | juwon123   |
    | Feranmi | feranmi123 |
    | Charles | charles123 |

5. After logging in, you will see a list of your assignments divided into three categories:
    - **Assignments in Progress.**
    - **Assignments Completed.**
    - **Assignments Not Started (with the expected time to complete them).**

6. If you fail to log in after three attempts, the program will exit.

---

## Data Structures and Algorithm Choices

### 1. Data Representation

- **Student Data**: Stored in a `data.frame` called `students`, containing the `student_id`, `name`, and `password` of each student. This data frame is used to verify login credentials.

    Example:
    ```r
    students <- data.frame(
      student_id = c(1, 2, 3),
      name = c("Juwon", "Feranmi", "Charles"),
      password = c("juwon123", "feranmi123", "charles123")
    )
    ```

- **Assignments Data**: Stored in a `data.frame` called `assignments`, which includes the `assignment_id`, `assignment_name`, and `expected_time_to_complete` in hours. This data structure is used to retrieve information on each assignment.

    Example:
    ```r
    assignments <- data.frame(
      assignment_id = 1:5,
      assignment_name = c("Math Assignment", "Science Assignment", "History Assignment", "Art Assignment", "PE Assignment"),
      expected_time_to_complete = c(2, 3, 1, 4, 1)
    )
    ```

- **Student Assignments**: Stored in a `data.frame` called `student_assignments`, where the `status` column indicates whether an assignment is completed (1), in progress (0), or not started (NA). This structure maps assignments to students.

    Example:
    ```r
    student_assignments <- data.frame(
      student_id = c(1, 1, 1, 2, 2, 3, 3, 3),
      assignment_id = c(1, 2, 3, 1, 2, 1, 4, 5),
      status = c(1, 0, NA, 1, 1, 0, NA, NA)
    )
    ```

### 2. Program Flow

- **Login Process**: The `student_login()` function prompts the user for their name and password. It checks the credentials by filtering the `students` data frame. If valid credentials are provided, the program retrieves the corresponding `student_id`. Otherwise, the user is given three attempts to log in before the program exits.

- **Fetching Assignment Data**: Once a student logs in, the program uses the `fetch_assignments()` function to retrieve the student's assignments from the `student_assignments` data frame. It then categorizes assignments into three lists:
  - **In Progress**: Assignments with status `0`.
  - **Completed**: Assignments with status `1`.
  - **Not Started**: Assignments not yet attempted by the student, retrieved using a negative match in the `assignments` data frame.

- **Displaying Results**: The `display_assignments_report()` function provides a visually appealing output of the assignments, dividing them into the three categories: in progress, completed, and not started (with expected time to complete).

### 3. Algorithm Choices

- **Data Filtering**: The `dplyr` library is used extensively for filtering and joining the data frames, as it provides a clear and efficient way to handle data manipulation in R.

- **Error Handling**: The program uses a `repeat` loop for user input with validation to ensure correct credentials are entered or the program exits after a maximum number of attempts.

---

## Future Improvements

- Add more student and assignment data for comprehensive testing.
- Allow for dynamic updates to the assignment statuses.
- Implement a password-hashing mechanism for secure storage of credentials.
