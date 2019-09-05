/*ΠΟΣΟΣΤΟ ΤΩΝ ΕΚΘΕΜΑΤΩΝ ,ΟΜΙΛΙΩΝ ΜΕ ΘΕΜΑ ΠΛΗΡΟΦΟΡΙΚΗ*/

SELECT  COUNT(*)/(SELECT COUNT(*) FROM EXHIBIT) AS POSOSTO 
FROM EXHIBIT
WHERE  EXHIBIT.kind='ΠΛΗΡΟΦΟΡΙΚΗ' 
UNION 
SELECT  COUNT(*)/(SELECT COUNT(*) FROM LECTURE) AS POSOSTO
FROM LECTURE
WHERE  LECTURE.theme='ΠΛΗΡΟΦΟΡΙΚΗ' ;

/* ΑΙΘΟΥΣΕΣ ΠΟΥ ΧΡΕΙΑΖΟΝΤΑΙ ΑΥΞΗΣΗ ΘΕΣΕΩΝ */

SELECT DISTINCT HALL.hall_number, capacity+10 AS new_capacity
FROM HALL,RESTFLOOR
WHERE HALL.capacity<55 
AND RESTFLOOR.restfloor_number=HALL.restfloor_number

/* ΑΤΟΜΑ ΠΟΥ ΜΠΑΙΝΟΥΝ ΔΩΡΕΑΝ */

SELECT PERSON.lastname AS participans_who_wont_pay,PARTICIPANT.part_code
FROM PERSON, PARTICIPANT
WHERE PERSON.id_number=PARTICIPANT.part_id 
AND PERSON.age<23 
AND (part_university='ΠΑΝΕΠΙΣΤΗΜΙΟ ΠΑΤΡΩΝ' OR part_university='ΜΕΤΣΟΒΙΟ ΠΟΛΥΤΕΧΝΕΙΟ')

/* ΕΚΘΕΜΑΤΑ ΣΥΓΚΕΚΡΙΜΕΝΗΣ ΗΜΕΡΟΜΗΝΙΑΣ */

SELECT DISTINCT EXHIBIT.exhibit_title as EXHIBIT,is_shown.date as date
FROM EXHIBIT,is_shown
WHERE is_shown.date='2016-6-2' 
AND is_shown.exhibit_id=EXHIBIT.exhibit_id

/* ΕΝΗΜΕΡΩΣΗ ΚΑΤΑΣΤΑΣΗΣ */

UPDATE is_shown SET DATE = DATE_ADD( DATE, INTERVAL 1 DAY ) WHERE is_shown.exhibit_id IN (
SELECT is_shown.exhibit_id
FROM PERSON, EXHIBITOR, EXHIBIT, PRESENTER, expose_exhibit
WHERE is_shown.exhibit_id = EXHIBIT.exhibit_id
AND EXHIBIT.exhibit_id = expose_exhibit.exhibit_id
AND expose_exhibit.ex_pre_code = EXHIBITOR.ex_pre_code
AND EXHIBITOR.ex_pre_code = pre_code
AND pre_id = id_number
AND lastname =  'ΧΙΟΣ'
)

/* ΒΡΑΒΕΥΣΗ ΚΑΤΑ ΕΠΙΘΕΤΟ */

SELECT PERSON.firstname, PERSON.lastname
FROM PERSON, PRESENTER
WHERE PRESENTER.pre_id = PERSON.id_number
ORDER BY 2

/* ΑΙΘΟΥΣΑ ΜΕ ΚΕΝΕΣ ΘΕΣΕΙΣ */

SELECT DISTINCT HALL.hall_number
FROM HALL, RESTFLOOR
WHERE capacity >40
AND HALL.restfloor_number = RESTFLOOR.restfloor_number

/* ΣΤΟΙΧΕΙΟ ΠΟΥ ΧΡΕΙΑΖΕΤΑΙ ΝΑ ΣΥΜΠΛΗΡΩΘΕΙ */

SELECT PERSON.lastname AS person_that_has_to_give_number
FROM PERSON
WHERE PERSON.phone_number IS NULL 

/* ΜΕΓΑΛΥΤΕΡΗ ΑΙΘΟΥΣΑ */

SELECT BUILDING.building_name, HALL.hall_number, MAX( capacity ) AS max
FROM BUILDING, HALL, RESTFLOOR
WHERE capacity = ( 
SELECT MAX( capacity ) 
FROM HALL ) 
AND BUILDING.building_number = HALL.building_number

