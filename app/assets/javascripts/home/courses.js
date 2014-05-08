$(document).ready(function() {
  /* For course categories dropdown on courses page */
  $("#course_category_id").change(function() {
    $.get('/courses/by_category/'+$(this).val());
  });

  /* For courses dropdown on courses page */
  $("#courses_dropdown_id").change(function () {
    $.get('/courses/'+$(this).val());
  });
});

