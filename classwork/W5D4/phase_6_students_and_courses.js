// Write classes to model students and the courses they can enroll in.
// 
// Student class
// 
// Student - a constructor function which should take a first and last name, and set both of those as attributes. It should also set a courses attribute to an empty array.
// Student.prototype.name - returns the concatenation of the student's first and last name
// Student.prototype.enroll - receives Course object, adds it to the student's list of courses, and updates the Course's list of enrolled students
// enroll should ignore attempts to re-enroll a student
// Student.prototype.courseLoad - returns a hash of departments to number of credits the student is taking in that department
// Course class
// 
// Course, a constructor function which should take the course name, department, and number of credits. It should also initialize students attribute to an empty array.
// Course.prototype.addStudent should add a student to the class
// Probably can rely upon Student.prototype.enroll
// Overlapping Courses
// 
// Each course should also take a set of days of the week ('mon', 'tue', ...), plus a time block (assume each day is broken into 8 consecutive time blocks). So a course could meet ['mon', 'wed', 'fri'] during block #1.
// Update your constructor function to also take a time block and days of the week
// Write a method Course.prototype.conflictsWith which takes a second Course and returns true if they conflict
// Update Student.prototype.enroll so that an error is raised if a Student enrolls in a course that conflicts with an existing course time
// Write a Student.prototype.hasConflict helper method

function Student(firstName, lastName) {
  this.firstName = firstName;
  this.lastName = lastName;
  this.courses = [];
}

Student.prototype.name = function() {
  return `${firstName} + ${lastName}`;
};

Student.prototype.enroll = function(course) {
  if (this.hasConflict(course)) throw 'Course conflict error!';
  
  // add course to student's list of courses
  this.courses.push(course);
  // update Course's list of enrolled students
  if (!course.students.includes(this)) course.students.push(this);
};

Student.prototype.courseLoad = function() {
  let courseLoad = {};
  
  this.courses.forEach(function(course) {
    if (!courseLoad[course.department]) courseLoad[course.department] = 0;
    courseLoad[course.department] += course.numCredits;
  });
  
  return courseLoad;
};

Student.prototype.hasConflict = function(newCourse) {
  let boolean = false;
  
  this.courses.forEach(function(course) {
    // check if any course dates match up
    if (course.conflictsWith(newCourse)) boolean = true;
  });
  
  return boolean;
};

function Course(courseName, department, numCredits, timeBlock, weekdays) {
  this.courseName = courseName;
  this.department = department;
  this.numCredits = numCredits;
  this.timeBlock = timeBlock;
  this.weekdays = weekdays;
  this.students = [];
}

Course.prototype.addStudent = function(student) {
  student.enroll(this);
};

Course.prototype.conflictsWith = function(newCourse) {
  if (this.timeBlock != newCourse.timeBlock) return false;
  
  let boolean = false;
  
  newCourse.weekdays.forEach((day) => {
    if (this.weekdays.includes(day)) boolean = true; // doesn't return out of this scope
  });

  return boolean;
};

tim = new Student('Tim', 'Kwak');
aaron = new Student('Aaron', 'Agarunov');

// courseName, department, numCredits, timeBlock, weekdays
oop = new Course('oop', 'cs', 5, 2, ['mon', 'wed', 'fri']);
diffeq = new Course('diff eq', 'math', 5, 2, ['mon', 'thurs', 'fri']);

tim.enroll(oop);
aaron.enroll(diffeq);

tim.enroll(diffeq); // errors!
