Assuming I have the tables student, club, and student_club:

student {
    id
    name
}
club {
    id
    name
}
student_club {
    student_id
    club_id
}

I want to know how to find all students in both the soccer (30) and baseball (50) club.

----------------
Verschiede Lösungnen ... gesucht habe ich für Einbau (PHP) in eine Scheife eine "loopable" - Version:  

SELECT s.stud_id,  s.name
FROM   student s
WHERE  s.stud_id IN (SELECT stud_id FROM student_club WHERE club_id = 30)
AND    s.stud_id IN (SELECT stud_id FROM student_club WHERE club_id = 50);

https://stackoverflow.com/questions/7364969/how-to-filter-sql-results-in-a-has-many-through-relation
